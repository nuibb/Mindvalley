//
//  ChannelHeaderView.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 8/2/24.
//

import SwiftUI

struct ChannelHeaderView: View {
    let channel: Channel
    let size = CGSize(width: 50, height: 50)
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            if !channel.icon.isEmpty {
                if #available(iOS 15.0, *) {
                    CacheAsyncIcon(photoURL: channel.icon, size: size)
                } else {
                    Image("pic")
                        .iconModifier(width: size.width, height: size.height)
                }
            }
            
            VStack(alignment: .leading, spacing: 4) {
                if !channel.name.isEmpty {
                    Text(channel.name)
                        .font(.circular(.headline).bold())
                        .foregroundColor(Color.primaryColor)
                        .lineLimit(1)
                        .multilineTextAlignment(.leading)
                }
                
                Text("\(channel.items.count) Episodes".capitalized)
                    .font(.circular(.subheadline).bold())
                    .foregroundColor(Color.textDarkGrey)
                    .lineLimit(1)
                    .multilineTextAlignment(.leading)
            }
            .insensitiveTextCase()
            
            Spacer()
        }
        .background(Color.backgroundColor)
    }
}
