//
//  Color+Extensions.swift
//  Simple
//
//  Created by Mikael Weiss on 2/13/21.
//

import SwiftUI

extension Color {
    static let appDarkPurpleTextColor = Color(#colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1))
    static let appStandardCellFontColor = Color(#colorLiteral(red: 0.5411272645, green: 0.5412079692, blue: 0.5411095023, alpha: 1))
    static let appEntryItemValueColor = Color("entryItemValueColor")
    static let appCellOutlineColor = Color("cellOutlineColor")
    static let appTreeGreen = Color(#colorLiteral(red: 0.1490196078, green: 0.3607843137, blue: 0.003921568627, alpha: 1))
    static let appDeepBlue = Color(#colorLiteral(red: 0.003921568627, green: 0.2470588235, blue: 0.5058823529, alpha: 1))
    
    static let appTintColor = Color(#colorLiteral(red: 0.1490196078, green: 0.3607843137, blue: 0.003921568627, alpha: 1))
    static let appErrorColor = Color(#colorLiteral(red: 0.631372549, green: 0.003921568627, blue: 0.08235294118, alpha: 1))
    static let appGrayMedium = Color(#colorLiteral(red: 0.4251748161, green: 0.4605827138, blue: 0.5, alpha: 1))
}

extension Color {
    /// Example: Color(hex: 0xA10115)
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}
