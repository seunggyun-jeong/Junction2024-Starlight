//
//  Color+Extention.swift
//  Starlight
//
//  Created by Yeji Seo on 8/10/24.
//

import Foundation
import SwiftUI

// hex 코드를 사용하기 위한 Color Extension
extension Color {
    init(hex: UInt, opacity: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: opacity
        )
    }
}

