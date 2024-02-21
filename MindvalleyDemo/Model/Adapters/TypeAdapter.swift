//
//  ChannelTypeAdapter.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 6/2/24.
//

import Foundation
import CoreData

extension MediaObject: Episode {
    var coverPhoto: String { coverAsset?.url ?? "" }
    var channel: String { mediaChannel?.title ?? "" }
}

extension ChannelObject: Channel {
    var icon: String {
        iconAsset?.thumbnailUrl ?? coverAsset?.url ?? ""
    }
    var episodes: [Media] {
        isSeries ? series : latestMediaItems
    }
    var isSeries: Bool { !self.series.isEmpty }
}

extension LatestMediaItem: Media {
    var coverPhoto: String { coverAsset?.url ?? "" }
}

extension Series: Media {
    var coverPhoto: String { coverAsset?.url ?? "" }
}
