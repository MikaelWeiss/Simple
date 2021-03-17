//
//  RecurrenceGrid.swift
//  Simple
//
//  Created by Mikael Weiss on 3/9/21.
//

import SwiftUI

struct RecurrenceGrid: View {
    private let columns = [GridItem(.adaptive(minimum: 36))]
    
    let data: [ValueData]
    
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(data) { value in
                if value.selected {
                    Circle()
                        .frame(width: 36, height: 36)
                        .inverseMask {
                            Number(value.text)
                        }
                } else {
                    Circle()
                        .stroke(Color.gray, lineWidth: 2)
                        .frame(width: 36, height: 36)
                        .overlay (
                            Number(value.text)
                        )
                }
            }
        }
    }
}

extension RecurrenceGrid {
    struct ValueData: Identifiable {
        internal let id = UUID()
        let text: String
        let selected: Bool
    }
}

extension RecurrenceGrid {
    struct Number: View {
        private let value: String
        
        init(_ value: String) {
            self.value = value
        }
        
        var body: some View {
            Text(value)
                .font(.system(size: 17, weight: .medium, design: .rounded))
        }
    }
}

struct RecurrenceGrid_Previews: PreviewProvider {
    
    static let data: [RecurrenceGrid.ValueData] = {
        var vals = Array(1...30).map { RecurrenceGrid.ValueData(text: "\($0)", selected: false) }
        vals.append(RecurrenceGrid.ValueData(text: "31", selected: true))
        return vals
    }()
    
    static var previews: some View {
        RecurrenceGrid(data: data)
    }
}
