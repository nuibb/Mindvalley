//
//  Image.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 8/2/24.
//

import SwiftUI

extension Image {
    func imageModifier(width: Double, height: Double) -> some View {
        self
            .resizable()
            .scaledToFill()
            .frame(width: width, height: height, alignment: .center)
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    
    func iconModifier(width: Double, height: Double) -> some View {
        self
            .resizable()
            .scaledToFit()
            .frame(width: width, height: height, alignment: .center)
            .clipShape(Circle())
    }
    
    func iconModifierFill(width: Double, height: Double) -> some View {
        self
            .resizable()
            .scaledToFill()
            .frame(width: width, height: height, alignment: .center)
            .clipShape(Circle())
    }
}
