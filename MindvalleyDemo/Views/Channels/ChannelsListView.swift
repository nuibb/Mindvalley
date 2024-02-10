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
                
                DynamicListView(spacing: 8) {
                    // MARK: New Episodes Section
                    if !viewModel.newEpisodes.isEmpty {
                        Section(header: EpisodeHeaderView(title: "New Episodes")) {
                            DynamicHStackView(spacing: 16) {
                                EpisodeView(episodes: viewModel.newEpisodes)
                            }
                        }
                    }
                    
                    
                    // MARK: Channels Sections
                    if !viewModel.channels.isEmpty {
                        ForEach(viewModel.channels, id:\.channelId) { channel in
                            Spacer().frame(height: 8)
                            Divider()
                                .frame(height: 1)
                                .background(Color.dividerColor)
                                .padding(.bottom, 8)
                            
                            Section(header: ChannelHeaderView(channel: channel)) {
                                DynamicHStackView(spacing: 16) {
                                    ChannelView(channel: channel)
                                }
                            }
                        }
                    }
                    
                    // MARK: Categories Section
                    if !viewModel.categories.isEmpty {
                        Spacer().frame(height: 8)
                        Divider()
                            .frame(height: 1)
                            .background(Color.dividerColor)
                            .padding(.bottom, 8)
                        
                        Section(header: EpisodeHeaderView(title: "Browse by categories")) {
                            if #available(iOS 14.0, *) {
                                DynamicGridView(columns: 2) {
                                    ForEach(viewModel.categories, id:\.id) { category in
                                        CategoryView(category: category)
                                    }
                                }
                                .padding(.top, 8)
                            } else {
                                Spacer().frame(height: 8)
                                ForEach(viewModel.categories.indices, id:\.self) { index in
                                    if index % 2 == 1 {
                                        EmptyView()
                                    } else {
                                        HStack {
                                            CategoryView(category: viewModel.categories[index])
                                            Spacer()
                                            if index + 1 < viewModel.categories.count {
                                                CategoryView(category: viewModel.categories[index + 1])
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .background(Color.backgroundColor)
            .navigationBarTitle(Text(Constants.appTitle), displayMode: .large)
            //.showToast(isShowing: $viewModel.showToast, message: viewModel.toastMessage, color: viewModel.messageColor)
        }
    }
}

