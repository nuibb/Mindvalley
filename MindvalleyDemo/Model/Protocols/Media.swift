//
//  Media.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 6/2/24.
//

import Foundation

protocol Media {
    var id: String { get }
    var title: String { get }
    var coverPhoto: String { get }
}

struct MediaItem: Media {
    var id: String
    var title: String
    var coverPhoto: String
}
