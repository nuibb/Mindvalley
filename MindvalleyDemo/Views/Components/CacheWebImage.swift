//
//  CacheWebImage.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 12/2/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct CacheWebImage: View {
    var imageName: String
    var size: CGSize
    
    var body: some View {
        let cacheKey = SDWebImageManager.shared.cacheKey(for: URL(string: imageName))
        if let cachedImage = SDImageCache.shared.imageFromCache(forKey: cacheKey) {
            Image(uiImage: cachedImage).imageModifier(size: size)
        } else {
            WebImage(url: URL(string: imageName))
                .resizable()
                .placeholder(content: {
                    Image(systemName: Constants.emptyPhaseIcon).iconModifier(size: size)
                })
                .indicator(.activity(style: .large))
                .transition(.fade(duration: 0.5))
                .scaledToFill()
                .frame(width: size.width, height: size.height, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}
