//
//  TextEntry.swift
//  Raindrop
//
//  Created by Mikael Weiss on 11/4/20.
//

import SwiftUI

struct TextEntry: View {
    enum ValueState {
        case error
        case normal
    }
    
    @State private var isTyping = false
    @Environment(\.colorScheme) private var colorScheme
    let title: String
    let infoText: String?
    let value: String
    let state: ValueState
    let onTextChanged: (String) -> Void
    
    private var redColor: Color {
        colorScheme == .dark ? Color(hex: 0xA10115) : Color(hex: 0xC50101, alpha: 0.9)
    }
    
    private var outlineColor: Color {
        state == .normal ? Color.cellOutlineColor : redColor
    }
    
    private var xColor: Color {
        if state == .error {
            return redColor
        }
        return colorScheme == .dark ? .deepBlue : .entryItemValueColor
    }
    
    init(_ title: String, infoText: String? = nil, value: String, state: ValueState, onTextChanged: @escaping (String) -> Void) {
        self.title = title
        self.infoText = infoText
        self.value = value
        self.onTextChanged = onTextChanged
        self.state = state
    }
    
    var body: some View {
        let binding = Binding(
            get: { value }, set: { onTextChanged($0) })
        VStack(spacing: 0) {
            ZStack(alignment: .leading) {
                TextField(title, text: binding, onEditingChanged: { isTyping = $0 })
                    .placeholderFontStyle()
                    .padding(.trailing, 10)
            }
            .cellStyle(outlineColor: outlineColor)
            .overlay(
                HStack {
                    Spacer()
                    Image(systemName: "xmark.circle.fill")
                        .onTapGesture {
                            binding.wrappedValue = ""
                        }
                        .font(.system(size: 22, weight: .black, design: .rounded))
                        .padding(.trailing, 8)
                        .foregroundColor(xColor)
                }
            )
            .overlay(
                Text(title)
                    .padding(.horizontal, 4)
                    .background(Color(.systemBackground))
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .offset(x: 28, y: -27)
                    .if(value.isEmpty) { $0.hidden() }
                    .animation(.default)
                    .foregroundColor(outlineColor)
                , alignment: .leading)
            if let infoText = infoText, !infoText.isEmpty {
                HStack {
                    Text(infoText)
                        .fontWeight(.semibold)
                        .padding(.top, 4)
                        .foregroundColor(outlineColor)
                        .offset(x: 28)
                    Spacer()
                }
                .animation(.easeIn)
            }
        }
    }
}

struct TextEntry_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ZStack {
                TextEntry("Some title", value: "asdf", state: .error, onTextChanged: {_ in })
            }.frame(height: 100)
            
            ZStack {
                TextEntry("Some title", infoText: "Something here", value: "asdf", state: .error, onTextChanged: {_ in })
            }.frame(height: 100)
            
            TextEntry("Some title", value: "", state: .normal, onTextChanged: {_ in })
                .background(Color(.systemBackground))
                .colorScheme(.dark)
            
            
            ZStack {
                TextEntry("Some title", infoText: "Something here", value: "asdf", state: .error, onTextChanged: {_ in })
            }.frame(height: 100)
            .background(Color(.systemBackground))
            .colorScheme(.dark)
        }.previewLayout(.sizeThatFits)
    }
}
