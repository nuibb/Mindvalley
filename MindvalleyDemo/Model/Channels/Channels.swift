//
//  Channels.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 8/2/24.
//

import Foundation

struct ChannelsData: Decodable {
    let rawData: ChannelsRawData?

    enum CodingKeys: String, CodingKey {
        case rawData = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        rawData = try values.decodeIfPresent(ChannelsRawData.self, forKey: .rawData)
    }
}

struct ChannelsRawData: Decodable {
    let channels: [ChannelItem]

    enum CodingKeys: String, CodingKey {
        case channels = "channels"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        channels = try values.decodeIfPresent([ChannelItem].self, forKey: .channels) ?? []
    }
}

struct ChannelItem: Decodable {
    let id: String
    let title: String
    let series: [Series]
    let mediaCount: Int
    let latestMediaItems: [LatestMediaItem]
    let iconAsset: IconAsset?
    let coverAsset: CoverAsset?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case series = "series"
        case mediaCount = "mediaCount"
        case latestMedia = "latestMedia"
        case iconAsset = "iconAsset"
        case coverAsset = "coverAsset"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id) ?? ""
        title = try values.decodeIfPresent(String.self, forKey: .title) ?? ""
        series = try values.decodeIfPresent([Series].self, forKey: .series) ?? []
        mediaCount = try values.decodeIfPresent(Int.self, forKey: .mediaCount) ?? 0
        latestMediaItems = try values.decodeIfPresent([LatestMediaItem].self, forKey: .latestMedia) ?? []
        iconAsset = try values.decodeIfPresent(IconAsset.self, forKey: .iconAsset)
        coverAsset = try values.decodeIfPresent(CoverAsset.self, forKey: .coverAsset)
    }
}

struct Series: Decodable {
    let name: String
    let coverAsset: CoverAsset?

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case coverAsset = "coverAsset"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .title) ?? ""
        coverAsset = try values.decodeIfPresent(CoverAsset.self, forKey: .coverAsset)
    }
}


struct LatestMediaItem: Decodable {
    let type: String
    let name: String
    let coverAsset: CoverAsset?

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case title = "title"
        case coverAsset = "coverAsset"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decodeIfPresent(String.self, forKey: .type) ?? ""
        name = try values.decodeIfPresent(String.self, forKey: .title) ?? ""
        coverAsset = try values.decodeIfPresent(CoverAsset.self, forKey: .coverAsset)
    }
}

struct IconAsset : Codable {
    let thumbnailUrl : String

    enum CodingKeys: String, CodingKey {
        case thumbnailUrl = "thumbnailUrl"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        thumbnailUrl = try values.decodeIfPresent(String.self, forKey: .thumbnailUrl) ?? ""
    }
}
