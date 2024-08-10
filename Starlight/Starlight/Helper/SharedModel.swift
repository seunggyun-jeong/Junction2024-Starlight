//
//  SharedModel.swift
//  Starlight
//
//  Created by Gyunni on 8/10/24.
//

import Foundation

struct SharedModel {
  static var shared = SharedModel()
  
  var dawnSafetyInfo: [SafetyInfo] = []
  var daySafetyInfo: [SafetyInfo] = []
  var nightSafetyInfo: [SafetyInfo] = []
  var securityLights: [SecurityLight] = []
  var policeStations: [PoliceStation] = []
  var cctvInfo: [CCTVInfo] = []
  
  init() {
    // Dawn Safety Info
    switch JSONConverter.parseArrayFromFile("New_Dawn_Safety_Grades", to: [SafetyInfo].self) {
    case .success(let dawnInfo):
      self.dawnSafetyInfo = dawnInfo
    case .failure(let error):
      print("dawnInfo error : \(error)")
    }
    
    // Day Safety Info
    switch JSONConverter.parseArrayFromFile("New_Day_Safety_Grades", to: [SafetyInfo].self) {
    case .success(let dayInfo):
      self.daySafetyInfo = dayInfo
    case .failure(let error):
      print("dawnInfo error : \(error)")
    }
    
    // Night Safety Info
    switch JSONConverter.parseArrayFromFile("New_Night_Safety_Grades", to: [SafetyInfo].self) {
    case .success(let nightInfo):
      self.nightSafetyInfo = nightInfo
    case .failure(let error):
      print("dawnInfo error : \(error)")
    }
    
    // Lights
    switch JSONConverter.parseArrayFromFile("StreetLight", to: [SecurityLight].self) {
    case .success(let lights):
      self.securityLights = lights
    case .failure(let error):
      print("dawnInfo error : \(error)")
    }
    
    // Police Stations
    switch JSONConverter.parseArrayFromFile("PoliceOffice", to: [PoliceStation].self) {
    case .success(let policeStations):
      self.policeStations = policeStations
    case .failure(let error):
      print("dawnInfo error : \(error)")
    }
    
    // CCTV Info
    switch JSONConverter.parseArrayFromFile("CCTV", to: [CCTVInfo].self) {
    case .success(let cctvs):
      self.cctvInfo = cctvs
    case .failure(let error):
      print("dawnInfo error : \(error)")
    }
  }
}
