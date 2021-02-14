//
//  DateSelection.swift
//  Raindrop
//
//  Created by Mikael Weiss on 11/8/20.
//

import SwiftUI

struct DateSelection: View {
    let title: String
    let value: Date
    let onDateChanged: (Date) -> Void
    
    init(_ title: String, value: Date, onDateChanged: @escaping (Date) -> Void) {
        self.title = title
        self.value = value
        self.onDateChanged = onDateChanged
    }
    
    var body: some View {
        let binding = Binding(get: { value }, set: { onDateChanged($0) })
        HStack {
            DatePicker(selection: binding, label: { Text(title) })
                .frame(height: 24)
        }.cellStyle()
    }
}

struct DateItemCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DateSelection("Some title", value: Date.today, onDateChanged: {_ in })
                .frame(width: 400)
            
            DateSelection("Some title", value: Date.today, onDateChanged: {_ in })
                .background(Color(.systemBackground))
                .colorScheme(.dark)
                .frame(width: 400)
        }.previewLayout(.sizeThatFits)
    }
}
