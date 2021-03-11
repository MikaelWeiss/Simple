//
//  Styles.swift
//  Raindrop
//
//  Created by Mikael Weiss on 11/4/20.
//

import SwiftUI

enum Styles {
    static let standardPlaceholderFontStyle: Font = .system(size: 18, weight: .bold, design: .rounded)
    static let standardValueFontStyle: Font = .system(size: 18, weight: .heavy, design: .rounded)
    static let standardFontStyle: Font = .system(size: 18, weight: .medium, design: .rounded)
}


extension View {
    func fontStyle() -> some View {
        self.font(Styles.standardValueFontStyle)
    }
    
    func placeholderFontStyle() -> some View {
        self
            .font(Styles.standardPlaceholderFontStyle)
            .foregroundColor(.appStandardCellFontColor)
    }
    
    func valueFontStyle() -> some View {
        self
            .font(Styles.standardValueFontStyle)
            .foregroundColor(.appEntryItemValueColor)
    }
}
