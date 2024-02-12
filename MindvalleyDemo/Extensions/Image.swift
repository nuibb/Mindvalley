//
//  Image.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 8/2/24.
//

import SwiftUI

extension Image {
    func imageModifier(size: CGSize) -> some View {
        self
            .resizable()
            .scaledToFill()
            .frame(width: size.width, height: size.height, alignment: .center)
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    
    func iconModifier(size: CGSize) -> some View {
        self
            .resizable()
            .scaledToFit()
            .frame(width: size.width, height: size.height, alignment: .center)
            .clipShape(Circle())
    }
    
    func iconModifierFill(size: CGSize) -> some View {
        self
            .resizable()
            .scaledToFill()
            .frame(width: size.width, height: size.height, alignment: .center)
            .clipShape(Circle())
    }
}
