//
//  HorizontalScrollView.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 7/2/24.
//

import SwiftUI

struct EpisodeView: View {
    let episodes: [Episode]
    let size: CGSize = CGSize(width: UIScreen.main.bounds.width/3, height: 228)
    
    var body: some View {
        ForEach(episodes, id:\.id) { episode in
            VStack(alignment: .leading, spacing: 8) {
                if !episode.coverPhoto.isEmpty {
                    if let cachedUrl = URL(string: episode.coverPhoto), let image = cachedUrl.loadImage() {
                        /// TODO: Load it asynchronously from local for better performance
                        Image(uiImage: image).imageModifier(size: size)
                        
                    } else {
                        if #available(iOS 15.0, *) {/// Avoiding 3rd party library, doing everything in swiftUI
                            CustomAsyncImage(photoURL: episode.coverPhoto, size: size, isIcon: false)
                        } else {
                            CacheWebImage(imageName: episode.coverPhoto, size: size)
                        }
                    }
                }
                
                if !episode.title.isEmpty {
                    Text(episode.title)
                        .font(.circular(.subheadline).bold())
                        .foregroundColor(Color.primaryColor)
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                }
                
                if !episode.channel.isEmpty {
                    Text(episode.channel.capitalized)
                        .font(.circular(.footnote).bold())
                        .foregroundColor(Color.textDarkGrey)
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                }
            }
            .frame(width: size.width)
        }
    }
}
