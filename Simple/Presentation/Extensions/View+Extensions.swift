//
//  View+Extensions.swift
//  Simple
//
//  Created by Mikael Weiss on 2/13/21.
//

import SwiftUI

extension View {
    /// Used when you want to have a conditional modifier
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
    @available(*, deprecated, message: "Not helpful untill light mode is suported")
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

extension View {
    func wrapInPlainButton(action: @escaping () -> Void) -> some View {
        Button(action: action, label: {
            self
        })
        .buttonStyle(NoButtonStyle())
    }
}

private struct NoButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(Color.black.opacity(0.0001))
    }
}

extension View {
    /// Used to provide an inverse masking
    public func inverseMask<M: View>(_ mask: () -> M) -> some View {
        ZStack {
            self
            mask()
                .blendMode(.destinationOut)
        }.compositingGroup()
    }
}
