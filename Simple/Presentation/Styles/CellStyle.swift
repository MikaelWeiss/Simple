//
//  CellStyle.swift
//  Simple
//
//  Created by Mikael Weiss on 2/13/21.
//

import SwiftUI

extension View {
    func cellStyle(outlineColor: Color = Color.cellOutlineColor, lineWidth: CGFloat = 1.5) -> some View {
        self
            .padding()
            .overlay (
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .stroke(outlineColor, lineWidth: lineWidth)
            )
            .frame(minWidth: 56)
    }
}

// MARK: - Previews

struct CellStyle_Previews: PreviewProvider {
    static var previews: some View {
        Text("Sup")
            .cellStyle()
            .makePreviewKind()
    }
}
