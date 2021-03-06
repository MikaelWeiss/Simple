//
//  CellStyle.swift
//  Simple
//
//  Created by Mikael Weiss on 2/13/21.
//

import SwiftUI

extension View {
    func cellStyle(outlineColor: Color = Color.cellOutlineColor, lineWidth: CGFloat = 1.5, hasPadding: Bool = true) -> some View {
        self
            .if(hasPadding, content: { $0.padding() })
            .clipShape (
                RoundedRectangle(cornerRadius: 14, style: .continuous)
            )
            .overlay (
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .stroke(outlineColor, lineWidth: lineWidth)
            )
            .frame(minHeight: 56)
    }
}

// MARK: - Previews

struct CellStyle_Previews: PreviewProvider {
    static var previews: some View {
        Text("Sup")
            .cellStyle()
            .makePreviewKind()
        Text("Sup")
            .cellStyle(hasPadding: false)
            .makePreviewKind()
    }
}
