//
//  ChannelTypeAdapter.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 6/2/24.
//

import Foundation

extension MediaItem: Episode {
    var id: String { UUID().uuidString }
    var title: String { name }
    var coverPhoto: String { coverAsset?.url ?? "" }
    var channel: String { mediaChannel?.title ?? "" }
}

extension ChannelItem: Channel {
    var channelId: String { id.isEmpty ? UUID().uuidString : id }
    var name: String { title }
    var icon: String {
        iconAsset?.thumbnailUrl ?? coverAsset?.url ?? ""
    }
    var items: [Media] {
        isSeries ? series : latestMediaItems
    }
    var isSeries: Bool { !self.series.isEmpty }
}

extension LatestMediaItem: Media {
    var id: String { UUID().uuidString }
    var title: String { name }
    var coverPhoto: String { coverAsset?.url ?? "" }
}

extension Series: Media {
    var id: String { UUID().uuidString }
    var title: String { name }
    var coverPhoto: String { coverAsset?.url ?? "" }
}
