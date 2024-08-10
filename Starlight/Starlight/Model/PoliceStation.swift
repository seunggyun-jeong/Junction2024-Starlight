//
//  PoliceStation.swift
//  Starlight
//
//  Created by Gyunni on 8/10/24.
//

import Foundation

struct PoliceStation: Codable {
    let sequenceNumber: String
    let metropolitanOffice: String
    let policeStation: String
    let officeName: String
    let category: String
    let address: String
    
    enum CodingKeys: String, CodingKey {
        case sequenceNumber = "﻿연번"
        case metropolitanOffice = "시도청"
        case policeStation = "경찰서"
        case officeName = "관서명"
        case category = "구분"
        case address = "주소"
    }
}
