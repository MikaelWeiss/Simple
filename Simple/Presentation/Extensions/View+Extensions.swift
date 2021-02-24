//
//  View+Extensions.swift
//  Simple
//
//  Created by Mikael Weiss on 2/13/21.
//

import SwiftUI

extension View {
    /// Added for when you want to have a conditional modifier
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, content: (Self) -> Content) -> some View {
        if condition {
            content(self)
        } else {
            self
        }
    }
}

extension View {
    /// Used to make nav link routing more like sheet routing
    func wrapInNavigationLink<Destination: View>(isActive: Binding<Bool>, destination: @escaping () -> Destination) -> some View {
        NavigationLink(
            destination: destination(),
            isActive: isActive,
            label: { self })
            .buttonStyle(PlainButtonStyle())
    }
}

extension View {
    /// Used for when you want to route using a navigation link, but don't want the nav bar
    func wrapInPlainNavigationView() -> some View {
        NavigationView {
            self
                .navigationBarHidden(true)
        }
    }
}

extension View {
    /// Used to make things read easier
    func wrapInNavigationView() -> some View {
        NavigationView {
            self
        }
    }
}

extension View {
    /// Used to show both a dark mode and light mode preview of a view
    func makePreviewKind(previewLayout: PreviewLayout = .sizeThatFits) -> some View {
        Group {
            self
            self
                .background(Color(.systemBackground))
                .colorScheme(.dark)
        }
        .previewLayout(previewLayout)
    }
}

extension Spacer {
    /// Used to make a Spacer able to register a tap
    func tappable() -> some View {
        Color.blue.opacity(0.0001)
    }
}
