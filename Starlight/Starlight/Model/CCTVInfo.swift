//
//  CCTVInfo.swift
//  Starlight
//
//  Created by Gyunni on 8/10/24.
//

import Foundation

struct CCTVInfo: Codable {
    let number: String
    let managementAgency: String
    let roadAddress: String
    let lotAddress: String
    let purpose: String
    let numberOfCameras: String
    let cameraResolution: String
    let shootingDirection: String
    let storageDays: String
    let installationDate: String
    let agencyPhoneNumber: String
    let latitude: String
    let longitude: String
    let dataStandardDate: String
    
    enum CodingKeys: String, CodingKey {
        case number = "﻿번호"
        case managementAgency = "관리기관명"
        case roadAddress = "소재지도로명주소"
        case lotAddress = "소재지지번주소"
        case purpose = "설치목적구분"
        case numberOfCameras = "카메라대수"
        case cameraResolution = "카메라화소수"
        case shootingDirection = "촬영방면정보"
        case storageDays = "보관일수"
        case installationDate = "설치연월"
        case agencyPhoneNumber = "관리기관전화번호"
        case latitude = "WGS84위도"
        case longitude = "WGS84경도"
        case dataStandardDate = "데이터기준일자"
    }
}
