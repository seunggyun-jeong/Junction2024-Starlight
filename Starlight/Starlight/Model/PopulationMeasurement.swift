//
//  PopulationMeasurement.swift
//  Starlight
//
//  Created by Gyunni on 8/10/24.
//

import Foundation

struct PopulationMeasurement: Codable {
    let geohash: String
    let operatedAt: Date
    let population: Int
    let latitude: Double
    let longitude: Double
    let si: String
    let gungu: String
    let dong: String
    
    enum CodingKeys: String, CodingKey {
        case geohash
        case operatedAt = "operated_at"
        case population
        case latitude
        case longitude
        case si
        case gungu
        case dong
    }
}

extension PopulationMeasurement {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        geohash = try container.decode(String.self, forKey: .geohash)
        
        let dateString = try container.decode(String.self, forKey: .operatedAt)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = dateFormatter.date(from: dateString) else {
            throw DecodingError.dataCorruptedError(forKey: .operatedAt, in: container, debugDescription: "Date string does not match format")
        }
        operatedAt = date
        
        population = try Int(container.decode(String.self, forKey: .population)) ?? 0
        latitude = try Double(container.decode(String.self, forKey: .latitude)) ?? 0.0
        longitude = try Double(container.decode(String.self, forKey: .longitude)) ?? 0.0
        
        si = try container.decode(String.self, forKey: .si)
        gungu = try container.decode(String.self, forKey: .gungu)
        dong = try container.decode(String.self, forKey: .dong)
    }
}
