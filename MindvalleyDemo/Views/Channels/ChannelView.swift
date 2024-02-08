//
//  ChannelsView.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 8/2/24.
//

import SwiftUI

struct ChannelView: View {
    let channel: Channel
    let size: CGSize
    
    init(channel: Channel) {
        self.channel = channel
        if channel.isSeries {
            self.size = CGSize(width: UIScreen.main.bounds.width - 32, height: 172)
        } else {
            self.size = CGSize(width: UIScreen.main.bounds.width/3, height: 228)
        }
    }
    
    var body: some View {
        ForEach(channel.items, id:\.id) { episode in
            VStack(alignment: .leading, spacing: 8) {
                if !episode.coverPhoto.isEmpty {
                    Image("pic")
                        .imageModifier(width: size.width, height: size.height)
                }
                
                if !episode.title.isEmpty {
                    Text(episode.title)
                        .font(.circular(.headline).bold())
                        .foregroundColor(Color.primaryColor)
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                }
            }
            .frame(width: size.width)
        }
    }
}
