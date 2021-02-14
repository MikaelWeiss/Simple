//
//  View+Extensions.swift
//  Simple
//
//  Created by Mikael Weiss on 2/13/21.
//

import SwiftUI

extension View {
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, content: (Self) -> Content) -> some View {
        if condition {
            content(self)
        } else {
            self
        }
    }
}

