//
//  Channel.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 6/2/24.
//

import Foundation

protocol Channel {
    var channelId: String { get }
    var name: String { get }
    var icon: String { get }
    var items: [Media] { get }
    var isSeries: Bool { get }
}

struct ChannelItem: Channel {
    var channelId: String
    var name: String
    var icon: String
    var items: [Media]
    var isSeries: Bool
}
