//
//  DataEntryCell.swift
//  Elements
//
//  Created by Mikael Weiss on 4/14/21.
//  Copyright © 2021 Elements Advisors, LLC. All rights reserved.
//

import SwiftUI

struct DataEntryCell: View {
    
    enum DataEntryType {
        case textEntry
        case selection
    }
    
    enum DataEntryViewState {
        case error
        case normal
    }
    
    @State private var isTyping = false
    
    private let title: String
    private let infoMessage: String?
    private let text: String
    private let attributedText: Text?
    private let image: Image?
    private let tintColor: UIColor
    private let state: DataEntryViewState
    private let type: DataEntryType
    private let isRequired: Bool
    private let onTextChanged: (String) -> Void
    private let onCommit: () -> Void
    private let onSelectionTap: () -> Void
    
    init(title: String,
         infoMessage: String? = nil,
         text: String,
         attributedText: Text? = nil,
         image: Image? = nil,
         tintColor: UIColor = .appTintColor,
         state: DataEntryViewState = .normal,
         type: DataEntryType = .textEntry,
         isRequired: Bool = false,
         onTextChanged: @escaping (String) -> Void = { _ in },
         onCommit: @escaping () -> Void = {},
         onSelectionTap: @escaping () -> Void = {}) {
        
        self.title = title
        self.infoMessage = infoMessage
        self.text = text
        self.attributedText = attributedText
        self.image = image
        self.tintColor = tintColor
        self.state = state
        self.type = type
        self.isRequired = isRequired
        self.onTextChanged = onTextChanged
        self.onCommit = onCommit
        self.onSelectionTap = onSelectionTap
    }
    
    private func onTap() {
        if type == .selection {
            onSelectionTap()
        } else {
            withAnimation { isTyping = true }
        }
    }
    
    private func onImageTap() {
        if image == nil && isTyping {
            withAnimation {
                onTextChanged("")
            }
        }
    }
    
    private var imageToUse: Image? {
        if type == .selection { return Image(uiImage: .dropDownIcon) }
        if let image = image { return image }
        if isTyping == true {
            return Image(uiImage: .clearTextIcon)
        } else {
            if isRequired == true && state == .error {
                return Image(uiImage: .errorIcon)
            }
        }
        return nil
    }
    
    private var attributedTextToUse: Text? {
        if text != "" { return attributedText }
        return nil
    }
    
    private var tintColorToUse: Color {
        if state == .error { return Color(.appErrorColor) }
        if isTyping, isRequired, text == "" { return Color(.appErrorColor) }
        if isTyping, state == .normal { return Color(tintColor) }
        return Color(.appGrayMedium)
    }
    
    private var infoMessageToUse: Text? {
        withAnimation {
            if let message = infoMessage, message.isEmpty == false {
                let textView = Text(message).font(.system(size: 12, weight: .semibold))
                if state == .error { return textView }
                if isTyping, isRequired, text == "" { return textView }
                if !isTyping, state == .error, isRequired == true, text == "" { return textView }
                return nil
            }
            return nil
        }
    }
    
    var body: some View {
        let binding = Binding(get: { text }, set: { onTextChanged($0) })
        
        ZStack {
            VStack {
                HStack {
                    attributedTextToUse
                    LegacyTextField(text: binding, isFirstResponder: $isTyping, onCommit: onCommit) {
                        $0.tintColor = tintColor
                    }
                    if image == nil, !isTyping {
                        imageToUse
                    } else {
                        Button(action: onImageTap, label: {
                            imageToUse
                        })
                    }
                }.padding(.horizontal, 16)
                .overlay(
                    RoundedRectangle(cornerRadius: 5, style: .continuous)
                        .stroke(tintColorToUse, lineWidth: 1)
                )
                .frame(height: 56)
                HStack {
                    infoMessageToUse
                    Spacer()
                }.padding(.leading, 12)
            }
        }
        .foregroundColor(tintColorToUse)
        .padding(.bottom, 24)
        .onTapGesture { onTap() }
    }
}

private struct PreviewableDataEntryCell: View {
    @State private var text1 = ""
    @State private var text2 = ""
    @State private var text3 = ""
    @State private var isRequired = false
    @State private var isInError = false
    
    var body: some View {
        VStack {
            DataEntryCell(title: "Some title", text: text1, onTextChanged: { text1 = $0 })
                .padding(.horizontal)
            DataEntryCell(title: "Some title", infoMessage: "Try this format: mm/dd/yyyy", text: text2, state: isInError ? .error : .normal, isRequired: isRequired, onTextChanged: { text2 = $0 })
                .padding(.horizontal)
            DataEntryCell(title: "Some title", text: text3, onTextChanged: { text3 = $0 })
                .padding(.horizontal)
            Button("isRequired", action: { withAnimation { isRequired.toggle() } })
            Button("isInError", action: { withAnimation { isInError.toggle() } })
        }
    }
}

struct DataEntryCell_Previews: PreviewProvider {
    static var previews: some View {
        PreviewableDataEntryCell()
    }
}

// https://stackoverflow.com/a/59059359/6842785

struct LegacyTextField: UIViewRepresentable {
    @Binding var isFirstResponder: Bool
    @Binding var text: String
    private var onCommit: () -> Void
    
    private var configuration = { (view: UITextField) in }
    
    init(text: Binding<String>,
         isFirstResponder: Binding<Bool>,
         onCommit: @escaping () -> Void,
         configuration: @escaping (UITextField) -> Void = { _ in }) {
        
        self._isFirstResponder = isFirstResponder
        self._text = text
        self.onCommit = onCommit
        self.configuration = configuration
    }
    
    func makeUIView(context: Context) -> UITextField {
        let view = UITextField()
        view.addTarget(context.coordinator, action: #selector(Coordinator.textViewDidChange), for: .editingChanged)
        view.delegate = context.coordinator
        return view
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
        switch isFirstResponder {
        case true: uiView.becomeFirstResponder()
        case false: uiView.resignFirstResponder()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator($text, isFirstResponder: $isFirstResponder, onCommit: onCommit)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var text: Binding<String>
        var isFirstResponder: Binding<Bool>
        var onCommit: () -> Void
        
        init(_ text: Binding<String>,
             isFirstResponder: Binding<Bool>,
             onCommit: @escaping () -> Void) {
            
            self.text = text
            self.isFirstResponder = isFirstResponder
            self.onCommit = onCommit
        }
        
        @objc func textViewDidChange(_ textField: UITextField) {
            withAnimation { self.text.wrappedValue = textField.text ?? "" }
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            withAnimation { self.isFirstResponder.wrappedValue = true }
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            withAnimation { self.isFirstResponder.wrappedValue = false }
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            onCommit()
            return true
        }
    }
}
