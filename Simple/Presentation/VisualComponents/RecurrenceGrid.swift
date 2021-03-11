//
//  RecurrenceGrid.swift
//  Simple
//
//  Created by Mikael Weiss on 3/9/21.
//

import SwiftUI

extension View {
    // view.inverseMask(_:)
    public func inverseMask<M: View>(_ mask: () -> M) -> some View {
        ZStack {
            self
            mask()
                .blendMode(.destinationOut)
        }.compositingGroup()
    }
}

struct RecurrenceGrid: View {
    private let columns = [GridItem(.adaptive(minimum: 30))]
    
    let data = Array(reapeating, 1...31).map { (val: $0, selected: False) }
    
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(1 ..< 30) { num in
                Circle()
                    .stroke(Color.gray, lineWidth: 2)
                    .frame(width: 30, height: 30)
                    .overlay (
                        Text("\(num)")
                            .font(.system(size: 17, weight: .medium, design: .rounded))
                    )
            }
        }
        .background(Color.darkPurpleTextColor)
    }
}

struct RecurrenceGrid_Previews: PreviewProvider {
    static var previews: some View {
        RecurrenceGrid()
    }
}

struct ContentView: View {
    let data = (1...1000).map { "Item \($0)" }

    let columns = [
        GridItem(.adaptive(minimum: 80))
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(data, id: \.self) { item in
                    Text(item)
                }
            }
            .padding(.horizontal)
        }
    }
}
