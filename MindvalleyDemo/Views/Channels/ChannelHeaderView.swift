//
//  ChannelHeaderView.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 8/2/24.
//

import SwiftUI

struct ChannelHeaderView: View {
    let channel: Channel
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            if !channel.icon.isEmpty {
                Image("pic")
                    .iconModifier(width: 50, height: 50)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                if !channel.name.isEmpty {
                    Text(channel.name)
                        .font(.circular(.title3).bold())
                        .foregroundColor(Color.primaryColor)
                        .lineLimit(1)
                        .multilineTextAlignment(.leading)
                }
                
                Text("\(channel.items.count) Episodes")
                    .font(.circular(.callout).bold())
                    .foregroundColor(Color.primaryColor)
                    .lineLimit(1)
                    .multilineTextAlignment(.leading)
            }
            
            Spacer()
        }
    }
}
