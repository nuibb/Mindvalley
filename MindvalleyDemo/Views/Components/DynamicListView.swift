//
//  DynamicListView.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 7/2/24.
//

import SwiftUI

struct DynamicListView<Content>: View where Content : View {
    let content: () -> Content
    let spacing: CGFloat?
    
    public init(spacing: CGFloat? = nil, @ViewBuilder content: @escaping () -> Content) {
        self.spacing = spacing
        self.content = content
    }
    
    @ViewBuilder public var body: some View {
        if #available(iOS 14.0, *) {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(alignment: .leading, spacing: spacing, content: self.content)
                    .background(Color.backgroundColor)
                    .padding()
            }
        } else {
            List(content: self.content)
                .hideIndicator()
                .listStyle(.plain)
                .background(Color.backgroundColor) ///For iOS 16, use .scrollContentBackground(.hidden) in case if you use List view
        }
    }
}
