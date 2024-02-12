//
//  View.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 6/2/24.
//

import SwiftUI

extension View {
    func showToast(isShowing: Binding<Bool>, message: String, color: Color, duration: TimeInterval = 3) -> some View {
        self.modifier(ToastModifier(isShowing: isShowing, message: message, color: color, duration: duration))
    }
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
    
    // MARK: List Attributes
    func listRowBackgroundColor(_ color: Color) -> some View {
        self.modifier(ListRowBackgroundColorModifier(color: color))
    }
    
    func enableAutoKeyboardDismissal() -> some View {
        self.modifier(AutoKeyboardDismissal())
    }
    
    func hideSeparator() -> some View {
        self.modifier(HideListSeparator())
    }
    
    func hideIndicator() -> some View {
        self.modifier(HideListIndicator())
    }
    
    func insensitiveTextCase() -> some View {
        self.modifier(InsensitiveTextCase())
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    // MARK: View Attributes
    func conditionalFrame(linesAllowed: Int) -> some View {
        self.modifier(ConditionalFrameModifier(linesAllowed: linesAllowed))
    }
    
    func ignoringSafeArea(to edge: Edge.Set, flag: Bool) -> some View {
        self.modifier(IgnoringSafeAreaModifier(edge: edge, flag: flag))
    }
}
