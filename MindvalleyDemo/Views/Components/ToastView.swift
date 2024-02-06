//
//  ToastView.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 6/2/24.
//

import SwiftUI

struct ToastModifier: ViewModifier {
    @Binding var isShowing: Bool
    let message: String
    let color: Color
    let duration: TimeInterval
    
    @ViewBuilder
    func body(content: Content) -> some View {
        ZStack {
            content
            if isShowing {
                VStack {
                    HStack() {
                        Spacer()
                        Image(systemName: "exclamationmark.circle")
                            .padding(.trailing, 10)
                        Text(message)
                        Spacer()
                    }
                    .padding()
                    .foregroundColor(color)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(5)
                    .shadow(radius: 5)
                    .onAppear {
                        setDuration()
                    }
                    
                    Spacer()
                }
            }
        }
        .padding()
    }
    
    private func setDuration() {
        Utils.after(seconds: duration) {
            withAnimation {
                isShowing = false
            }
        }
    }
}

