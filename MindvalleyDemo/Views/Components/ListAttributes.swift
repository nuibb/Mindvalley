//
//  HideListIndicator.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 9/2/24.
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
