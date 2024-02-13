//
//  Channel.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 6/2/24.
//

import Foundation

protocol Channel {
    var id: String { get }
    var title: String { get }
    var icon: String { get }
    var items: [Media] { get }
    var isSeries: Bool { get }
}

struct ChannelItem: Channel {
    var id: String
    var title: String
    var icon: String
    var items: [Media]
    var isSeries: Bool
}
