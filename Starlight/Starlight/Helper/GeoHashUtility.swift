//
//  GeoHashUtility.swift
//  Starlight
//
//  Created by Gyunni on 8/10/24.
//

import Foundation
import CoreLocation

import Foundation
import CoreLocation

struct Geohash {
    private static let base32 = "0123456789bcdefghjkmnpqrstuvwxyz"
    
    static func encode(_ lat: Double, _ lon: Double, precision: Int? = nil) -> String {
        var precision = precision
        if precision == nil {
            // Infer precision
            for p in 1...12 {
                let hash = encode(lat, lon, precision: p)
                let position = decode(hash)
                if position.latitude == lat && position.longitude == lon {
                    return hash
                }
            }
            precision = 12 // Set to maximum
        }
        
        guard !lat.isNaN && !lon.isNaN && precision! > 0 else {
            fatalError("Invalid geohash")
        }
        
        var idx = 0
        var bit = 0
        var evenBit = true
        var geohash = ""
        
        var latMin = -90.0, latMax = 90.0
        var lonMin = -180.0, lonMax = 180.0
        
        while geohash.count < precision! {
            if evenBit {
                // Bisect E-W longitude
                let lonMid = (lonMin + lonMax) / 2
                if lon >= lonMid {
                    idx = idx * 2 + 1
                    lonMin = lonMid
                } else {
                    idx *= 2
                    lonMax = lonMid
                }
            } else {
                // Bisect N-S latitude
                let latMid = (latMin + latMax) / 2
                if lat >= latMid {
                    idx = idx * 2 + 1
                    latMin = latMid
                } else {
                    idx *= 2
                    latMax = latMid
                }
            }
            evenBit.toggle()
            
            bit += 1
            if bit == 5 {
                geohash += String(base32[base32.index(base32.startIndex, offsetBy: idx)])
                bit = 0
                idx = 0
            }
        }
        
        return geohash
    }
    
    static func decode(_ geohash: String) -> CLLocationCoordinate2D {
        let bounds = self.bounds(geohash)
        
        let latMin = bounds.sw.latitude, lonMin = bounds.sw.longitude
        let latMax = bounds.ne.latitude, lonMax = bounds.ne.longitude
        
        let lat = (latMin + latMax) / 2
        let lon = (lonMin + lonMax) / 2
        
        let latPrecision = floor(2 - log10(latMax - latMin))
        let lonPrecision = floor(2 - log10(lonMax - lonMin))
        
        return CLLocationCoordinate2D(
            latitude: lat.rounded(toDecimalPlaces: Int(latPrecision)),
            longitude: lon.rounded(toDecimalPlaces: Int(lonPrecision))
        )
    }
    
    static func bounds(_ geohash: String) -> (sw: CLLocationCoordinate2D, ne: CLLocationCoordinate2D) {
        guard !geohash.isEmpty else {
            fatalError("Invalid geohash")
        }
        
        let geohash = geohash.lowercased()
        var evenBit = true
        var latMin = -90.0, latMax = 90.0
        var lonMin = -180.0, lonMax = 180.0
        
        for char in geohash {
            guard let idx = base32.firstIndex(of: char) else {
                fatalError("Invalid geohash")
            }
            
            let index = base32.distance(from: base32.startIndex, to: idx)
            
            for n in (0...4).reversed() {
                let bitN = (index >> n) & 1
                if evenBit {
                    // Longitude
                    let lonMid = (lonMin + lonMax) / 2
                    if bitN == 1 {
                        lonMin = lonMid
                    } else {
                        lonMax = lonMid
                    }
                } else {
                    // Latitude
                    let latMid = (latMin + latMax) / 2
                    if bitN == 1 {
                        latMin = latMid
                    } else {
                        latMax = latMid
                    }
                }
                evenBit.toggle()
            }
        }
        
        return (
            sw: CLLocationCoordinate2D(latitude: latMin, longitude: lonMin),
            ne: CLLocationCoordinate2D(latitude: latMax, longitude: lonMax)
        )
    }
    
    static func adjacent(_ geohash: String, direction: String) -> String {
        let geohash = geohash.lowercased()
        let direction = direction.lowercased()
        
        guard !geohash.isEmpty else {
            fatalError("Invalid geohash")
        }
        guard "nsew".contains(direction) else {
            fatalError("Invalid direction")
        }
        
        let neighbour: [String: [String]] = [
            "n": [ "p0r21436x8zb9dcf5h7kjnmqesgutwvy", "bc01fg45238967deuvhjyznpkmstqrwx" ],
            "s": [ "14365h7k9dcfesgujnmqp0r2twvyx8zb", "238967debc01fg45kmstqrwxuvhjyznp" ],
            "e": [ "bc01fg45238967deuvhjyznpkmstqrwx", "p0r21436x8zb9dcf5h7kjnmqesgutwvy" ],
            "w": [ "238967debc01fg45kmstqrwxuvhjyznp", "14365h7k9dcfesgujnmqp0r2twvyx8zb" ]
        ]
        
        let border: [String: [String]] = [
            "n": [ "prxz",     "bcfguvyz" ],
            "s": [ "028b",     "0145hjnp" ],
            "e": [ "bcfguvyz", "prxz"     ],
            "w": [ "0145hjnp", "028b"     ]
        ]
        
        let lastChar = String(geohash.last!)
        var parent = String(geohash.dropLast())
        
        let type = geohash.count % 2
        
        if border[direction]![type].contains(lastChar) && !parent.isEmpty {
            parent = adjacent(parent, direction: direction)
        }
        
        let charIndex = neighbour[direction]![type].firstIndex(of: lastChar.first!)!
        return parent + String(base32[base32.index(base32.startIndex, offsetBy: charIndex.utf16Offset(in: neighbour[direction]![type]))])
    }
    
    static func neighbours(_ geohash: String) -> [String: String] {
        return [
            "n":  adjacent(geohash, direction: "n"),
            "ne": adjacent(adjacent(geohash, direction: "n"), direction: "e"),
            "e":  adjacent(geohash, direction: "e"),
            "se": adjacent(adjacent(geohash, direction: "s"), direction: "e"),
            "s":  adjacent(geohash, direction: "s"),
            "sw": adjacent(adjacent(geohash, direction: "s"), direction: "w"),
            "w":  adjacent(geohash, direction: "w"),
            "nw": adjacent(adjacent(geohash, direction: "n"), direction: "w")
        ]
    }
}

extension Double {
    func rounded(toDecimalPlaces places: Int) -> Double {
        let multiplier = pow(10.0, Double(places))
        return (self * multiplier).rounded() / multiplier
    }
}
