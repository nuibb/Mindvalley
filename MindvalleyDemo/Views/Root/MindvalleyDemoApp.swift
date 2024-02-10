//
//  MindvalleyDemoApp.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 6/2/24.
//

import SwiftUI

@available(iOS 14.0, *)
struct MindvalleyDemoApp: App {
    @StateObject var viewModel = ChannelsListViewModel(dataProvider: Config.shared.getDataProvider())

    var body: some Scene {
        WindowGroup {
            /// Injecting dependency for defining data provider based on Schema...
            /// Mock data for local and API response for DEV/QA/DEMO/PROD environment.
            ChannelsListView(viewModel: viewModel)
        }
    }
}

