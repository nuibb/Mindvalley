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
    let mediaItems: [MediaObject]

    enum CodingKeys: String, CodingKey {
        case mediaItems = "media"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        mediaItems = try values.decodeIfPresent([MediaObject].self, forKey: .mediaItems) ?? []
    }
}

struct MediaObject: Decodable {
    let id: String
    let type: String
    let name: String
    let coverAsset: CoverAsset?
    let mediaChannel: MediaChannel?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case type = "type"
        case title = "title"
        case coverAsset = "coverAsset"
        case mediaChannel = "channel"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id) ?? ""
        type = try values.decodeIfPresent(String.self, forKey: .type) ?? ""
        name = try values.decodeIfPresent(String.self, forKey: .title) ?? ""
        coverAsset = try values.decodeIfPresent(CoverAsset.self, forKey: .coverAsset)
        mediaChannel = try values.decodeIfPresent(MediaChannel.self, forKey: .mediaChannel)
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
