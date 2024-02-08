//
//  CacheAsyncImage.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 8/2/24.
//

import SwiftUI

@available(iOS 15.0, *)
struct CacheAsyncImage: View {
    private let photoURL = URL(string: "https://picsum.photos/256")

    var body: some View {
        AsyncImage(url: photoURL) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
        } placeholder: {
            ProgressView()
        }
    }
}
