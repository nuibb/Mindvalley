//
//  Modifiers.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 12/2/24.
//

import SwiftUI

struct HideListSeparator: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 15, *) {
            return AnyView(content.listRowSeparator(.hidden))
        } else {
            return content
        }
    }
}

struct HideListIndicator: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 16, *) {
            return AnyView(content.scrollIndicators(.hidden))
        } else {
            return content
        }
    }
}

struct AutoKeyboardDismissal: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 16, *) {
            return AnyView(content.scrollDismissesKeyboard(.immediately))
        } else {
            return content
        }
    }
}

struct InsensitiveTextCase: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 14, *) {
            return AnyView(content.textCase(nil))
        } else {
            return content
        }
    }
}

struct IgnoringSafeAreaModifier: ViewModifier {
    let edge: Edge.Set
    let flag: Bool
    
    @ViewBuilder
    func body(content: Content) -> some View {
        if flag {
            content
                .edgesIgnoringSafeArea(edge)
        } else {
            content
        }
    }
}

struct ConditionalFrameModifier: ViewModifier {
    let linesAllowed: Int
    
    @ViewBuilder
    func body(content: Content) -> some View {
        if linesAllowed > 0 {
            content
                .frame(height: CGFloat(linesAllowed) * UIFont.preferredFont(forTextStyle: .body).lineHeight)
                .fixedSize(horizontal: false, vertical: true)
        } else {
            content
        }
    }
}

struct ListRowBackgroundColorModifier: ViewModifier {
    let color: Color
    
    @ViewBuilder
    func body(content: Content) -> some View {
            content
                .listRowBackground(color)
                .padding(.bottom, 8)
    }
}
