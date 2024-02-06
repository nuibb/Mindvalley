//
//  MindvalleyDemoApp.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 6/2/24.
//

import SwiftUI

@main
struct MindvalleyDemoApp: App {
    init() {
        /// Defining server configuration domain on the current 'Schema' by the run time
        Config.shared.setupServerConfiguration()
        Logger.log(type: .info, "[Current][Environment]: \(Config.baseUrl ?? "Not Defined Yet")")
    }

    var body: some Scene {
        WindowGroup {
            /// Injecting dependency for defining data provider based on Schema...
            /// Mock data for local and API response for DEV/QA/DEMO/PROD environment.
            ChannelsListView(viewModel: ChannelsListViewModel(dataProvider: Config.shared.getDataProvider()))
        }
    }
}
