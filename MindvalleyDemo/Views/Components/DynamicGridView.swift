//
//  DynamicGridView.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 11/2/24.
//

import SwiftUI

@available(iOS 14.0, *)
struct DynamicGridView<Content>: View where Content : View {
    let columns: Int
    let content: () -> Content
    
    @State private var gridLayout: [GridItem] = [GridItem(.flexible())]
    
    public init(columns: Int, @ViewBuilder content: @escaping () -> Content) {
        self.columns = columns
        self.content = content
    }
    
    @ViewBuilder public var body: some View {
        LazyVGrid(columns: gridLayout, alignment: .center, spacing: 10, content: self.content)
            .onAppear {
                gridLayout = Array(repeating: .init(.flexible()), count: columns)
            }
    }
}
