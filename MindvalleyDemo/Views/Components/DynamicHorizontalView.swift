//
//  DynamicHorizontalView.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 7/2/24.
//

import SwiftUI

struct DynamicHorizontalView<Content>: View where Content : View {
    let content: () -> Content
    let spacing: CGFloat?
    
    public init(spacing: CGFloat? = nil, @ViewBuilder content: @escaping () -> Content) {
        self.spacing = spacing
        self.content = content
    }
    
    @ViewBuilder public var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            if #available(iOS 14.0, *) {
                LazyHStack(alignment: .top, spacing: spacing, content: self.content)
            } else {
                HStack(alignment: .top, spacing: spacing, content: self.content)
            }
        }
    }
}

