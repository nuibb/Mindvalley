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
                    if #available(iOS 15.0, *) {
                        CacheAsyncImage(photoURL: episode.coverPhoto, size: size)
                    } else {
                        Image("pic")
                            .imageModifier(width: size.width, height: size.height)
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
