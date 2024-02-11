//
//  ChannelHeaderview.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 8/2/24.
//

import SwiftUI

struct EpisodeHeaderView: View {
    let title: String
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(Color.textDarkGrey)
                .font(.circular(.title3).bold())
            
            Spacer()
        }
        .background(Color.backgroundColor)
        .insensitiveTextCase()
    }
}
