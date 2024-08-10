//
//  SecurityLight.swift
//  Starlight
//
//  Created by Gyunni on 8/10/24.
//

import Foundation

struct SecurityLight: Codable {
    let locationName: String
    let installationCount: String
    let roadAddress: String
    let lotAddress: String
    let latitude: String
    let longitude: String
    let installationYear: String
    let installationType: String
    let managementPhoneNumber: String
    let managementAgency: String
    let dataStandardDate: String
    
    enum CodingKeys: String, CodingKey {
        case locationName = "﻿보안등위치명"
        case installationCount = "설치개수"
        case roadAddress = "소재지도로명주소"
        case lotAddress = "소재지지번주소"
        case latitude = "위도"
        case longitude = "경도"
        case installationYear = "설치연도"
        case installationType = "설치형태"
        case managementPhoneNumber = "관리기관전화번호"
        case managementAgency = "관리기관명"
        case dataStandardDate = "데이터기준일자"
    }
}
