//
//  ChannelsListView.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 6/2/24.
//

import SwiftUI

struct ChannelsListView: View {
    @ObservedObject var viewModel: ChannelsListViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ChannelsListView(viewModel: ChannelsListViewModel(dataProvider: MockDataProvider()))
}
