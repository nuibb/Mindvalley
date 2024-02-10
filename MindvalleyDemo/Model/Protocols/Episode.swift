//
//  Episode.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 6/2/24.
//

import Foundation

protocol Episode: Media {
    var channel: String { get }
}

struct EpisodeItem: Episode {
    var id: String
    var title: String
    var coverPhoto: String
    var channel: String
}
