//
//  FontStyle.swift
//  Raindrop
//
//  Created by Mikael Weiss on 11/4/20.
//

import SwiftUI

struct FontStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Styles.standardFontStyle)
            .foregroundColor(.standardCellFontColor)
    }
}

struct ValueFontStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Styles.standardValueFontStyle)
            .foregroundColor(.entryItemValueColor)
    }
}

extension View {
    func fontStyle() -> some View {
        self.modifier(FontStyle())
    }
    
    func valueFontStyle() -> some View {
        self.modifier(ValueFontStyle())
    }
}
