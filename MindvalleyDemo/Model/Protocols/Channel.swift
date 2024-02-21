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
    var episodes: [Media] { get }
    var isSeries: Bool { get }
}
