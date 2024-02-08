//
//  ChannelsListView.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 6/2/24.
//

import SwiftUI

struct ChannelsListView: View {
    @ObservedObject var viewModel: ChannelsListViewModel
    
    init(viewModel: ChannelsListViewModel) {
        self.viewModel = viewModel
        UINavigationBar.appearance().backgroundColor = UIColor.backgroundColor
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.textLightGrey]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.textLightGrey]
        UINavigationBar.appearance().tintColor = UIColor.backgroundColor
        UINavigationBar.appearance().barTintColor = UIColor.backgroundColor
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.backgroundColor.edgesIgnoringSafeArea(.all)
                //MARK: Progress View
                if viewModel.isRequesting {
                    if #available(iOS 14.0, *) {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .purple))
                            .zIndex(1)
                    }
                }
                
                VStack(alignment: .leading) {
                    DynamicListView(spacing: 8) {
                        if !viewModel.newEpisodes.isEmpty {
                            EpisodeHeaderView(title: "New Episodes")
                            DynamicHorizontalView(spacing: 16) {
                                EpisodeView(episodes: viewModel.newEpisodes)
                            }
                        }
                        
                        if !viewModel.channels.isEmpty {
                            ForEach(viewModel.channels, id:\.channelId) { channel in
                                VStack(alignment: .leading, spacing: 8) {
                                    ChannelHeaderView(channel: channel).padding(.top)
                                    DynamicHorizontalView(spacing: 16) {
                                        ChannelView(channel: channel)
                                    }
                                }
                                .padding(.vertical)
                            }
                        }
                    }
                }
                .zIndex(0)
                .padding()
            }
            .background(Color.backgroundColor)
            .navigationBarTitle(Text(Constants.appTitle), displayMode: .large)
            //.showToast(isShowing: $viewModel.showToast, message: viewModel.toastMessage, color: viewModel.messageColor)
        }
    }
}

