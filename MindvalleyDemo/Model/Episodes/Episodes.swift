//
//  Episodes.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 6/2/24.
//

import Foundation

/// MARK: Handle any kind of missing value/property from the server
struct Episodes: Decodable {
    let data: EpisodesData?

    enum CodingKeys: String, CodingKey {
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(EpisodesData.self, forKey: .data)
    }
}

struct EpisodesData: Decodable {
    let mediaItem: [MediaItem]

    enum CodingKeys: String, CodingKey {
        case mediaItem = "media"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        mediaItem = try values.decodeIfPresent([MediaItem].self, forKey: .mediaItem) ?? []
    }
}

struct MediaItem: Decodable {
    let type: String
    let title: String
    let coverAsset: CoverAsset?
    let channel: MediaChannel?

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case title = "title"
        case coverAsset = "coverAsset"
        case channel = "channel"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decodeIfPresent(String.self, forKey: .type) ?? ""
        title = try values.decodeIfPresent(String.self, forKey: .title) ?? ""
        coverAsset = try values.decodeIfPresent(CoverAsset.self, forKey: .coverAsset)
        channel = try values.decodeIfPresent(MediaChannel.self, forKey: .channel)
    }
}

struct CoverAsset : Decodable {
    let url: String

    enum CodingKeys: String, CodingKey {
        case url = "url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        url = try values.decodeIfPresent(String.self, forKey: .url) ?? ""
    }

}

struct MediaChannel : Decodable {
    let title: String

    enum CodingKeys: String, CodingKey {
        case title = "title"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title) ?? ""
    }
}
