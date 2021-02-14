//
//  CellStyle.swift
//  Simple
//
//  Created by Mikael Weiss on 2/13/21.
//

import SwiftUI

struct CellStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .overlay (
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .stroke(Color.cellOutlineColor, lineWidth: 1.5)
            )
            .fontStyle()
    }
}

extension View {
    func cellStyle() -> some View {
        self.modifier(CellStyle())
    }
}

// MARK: - Previews

struct CellStyle_Previews: PreviewProvider {
    static var previews: some View {
        Text("Sup")
            .cellStyle()
    }
}
