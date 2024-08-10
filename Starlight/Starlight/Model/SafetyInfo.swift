//
//  SafetyInfo.swift
//  Starlight
//
//  Created by Gyunni on 8/10/24.
//

import Foundation

struct SafetyInfo: Codable {
  let geohash: String
  let operatedAtX: Date
  let avgLightlux: Double
  let latitudeX: Double
  let longitudeX: Double
  let siX: String
  let gunguX: String
  let dongX: String
  let operatedAtY: Date
  let population: Int
  let latitudeY: Double
  let longitudeY: Double
  let siY: String
  let gunguY: String
  let dongY: String
  let safetyGrade: Int
  
  var grade: SafetyGrade {
    if safetyGrade == 1 {
      return .one
    } else if safetyGrade == 2 {
      return .two
    } else if safetyGrade == 3 {
      return .three
    } else if safetyGrade == 4 {
      return .four
    } else if safetyGrade == 5 {
      return .five
    } else {
      return .five
    }
  }
  
  enum CodingKeys: String, CodingKey {
    case geohash
    case operatedAtX = "operated_at_x"
    case avgLightlux = "avg_lightlux"
    case latitudeX = "latitude_x"
    case longitudeX = "longitude_x"
    case siX = "si_x"
    case gunguX = "gungu_x"
    case dongX = "dong_x"
    case operatedAtY = "operated_at_y"
    case population
    case latitudeY = "latitude_y"
    case longitudeY = "longitude_y"
    case siY = "si_y"
    case gunguY = "gungu_y"
    case dongY = "dong_y"
    case safetyGrade = "safety_grade"
  }
}

extension SafetyInfo {
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    geohash = try container.decode(String.self, forKey: .geohash)
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    
    let operatedAtXString = try container.decode(String.self, forKey: .operatedAtX)
    guard let operatedAtXDate = dateFormatter.date(from: operatedAtXString) else {
      throw DecodingError.dataCorruptedError(forKey: .operatedAtX, in: container, debugDescription: "Date string does not match format")
    }
    operatedAtX = operatedAtXDate
    
    avgLightlux = try container.decode(Double.self, forKey: .avgLightlux)
    latitudeX = try container.decode(Double.self, forKey: .latitudeX)
    longitudeX = try container.decode(Double.self, forKey: .longitudeX)
    siX = try container.decode(String.self, forKey: .siX)
    gunguX = try container.decode(String.self, forKey: .gunguX)
    dongX = try container.decode(String.self, forKey: .dongX)
    
    let operatedAtYString = try container.decode(String.self, forKey: .operatedAtY)
    guard let operatedAtYDate = dateFormatter.date(from: operatedAtYString) else {
      throw DecodingError.dataCorruptedError(forKey: .operatedAtY, in: container, debugDescription: "Date string does not match format")
    }
    operatedAtY = operatedAtYDate
    
    population = try container.decode(Int.self, forKey: .population)
    latitudeY = try container.decode(Double.self, forKey: .latitudeY)
    longitudeY = try container.decode(Double.self, forKey: .longitudeY)
    siY = try container.decode(String.self, forKey: .siY)
    gunguY = try container.decode(String.self, forKey: .gunguY)
    dongY = try container.decode(String.self, forKey: .dongY)
    safetyGrade = try container.decode(Int.self, forKey: .safetyGrade)
  }
}
