//
//  TextEntry.swift
//  Raindrop
//
//  Created by Mikael Weiss on 11/4/20.
//

import SwiftUI

struct TextEntry: View {
    @State private var isTyping = false
    let title: String
    let value: String
    let onTextChanged: (String) -> Void
    
    init(_ title: String, value: String, onTextChanged: @escaping (String) -> Void) {
        self.title = title
        self.value = value
        self.onTextChanged = onTextChanged
    }
    
    var body: some View {
        let binding = Binding(
            get: { value }, set: { onTextChanged($0) })
        ZStack(alignment: .leading) {
            TextField(title, text: binding, onEditingChanged: { isTyping = $0 })
                .placeholderFontStyle()
        }
        .cellStyle()
        .overlay(
            Text(title)
                .padding(.horizontal, 4)
                .background(Color(.systemBackground))
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .offset(x: 28, y: -19)
                .if(value.isEmpty) { $0.hidden() }
                .animation(.default)
            , alignment: .leading)
    }
}

struct TextEntry_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TextEntry("Some title", value: "", onTextChanged: {_ in })
            
            TextEntry("Some title", value: "", onTextChanged: {_ in })
                .background(Color(.systemBackground))
                .colorScheme(.dark)
        }.previewLayout(.sizeThatFits)
    }
}
