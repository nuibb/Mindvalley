//
//  CategoryView.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 11/2/24.
//

import SwiftUI

struct CategoryView: View {
    let category: CategoryItem
    
    var body: some View {
        Text(category.name)
            .foregroundColor(Color.primaryColor)
            .font(.circular(.headline).weight(.semibold))
            .frame(width: 160, height: 50)
            .background(Color.textDarkGrey.opacity(0.2))
            .clipShape(Capsule())
    }
}
