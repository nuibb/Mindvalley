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
                
                if viewModel.newEpisodes.isEmpty && viewModel.channels.isEmpty && viewModel.categories.isEmpty {
                    if !viewModel.isRequesting {
                        Text("No Items Available!")
                            .font(.circular(.callout))
                            .foregroundColor(.red)
                            .padding()
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
                        .listRowBackgroundColor(Color.backgroundColor)
                    }
                    
                    
                    // MARK: Channels Sections
                    if !viewModel.channels.isEmpty {
                        ForEach(viewModel.channels, id:\.channelId) { channel in
                            if #available(iOS 14.0, *) {
                                Spacer().frame(height: 8)
                                Divider()
                                    .frame(height: 1)
                                    .background(Color.dividerColor)
                                    .padding(.bottom, 8)
                            }
                            
                            Section(header: ChannelHeaderView(channel: channel)) {
                                DynamicHStackView(spacing: 16) {
                                    ChannelView(channel: channel)
                                }
                            }
                        }
                        .listRowBackgroundColor(Color.backgroundColor)
                    }
                    
                    // MARK: Categories Section
                    if !viewModel.categories.isEmpty {
                        
                        if #available(iOS 14.0, *) {
                            Spacer().frame(height: 8)
                            Divider()
                                .frame(height: 1)
                                .background(Color.dividerColor)
                                .padding(.bottom, 8)
                        }
                        
                        Section(header: EpisodeHeaderView(title: "Browse by categories")) {
                            if #available(iOS 14.0, *) {
                                DynamicGridView(columns: 2) {
                                    ForEach(viewModel.categories, id:\.id) { category in
                                        CategoryView(category: category)
                                    }
                                }
                                .padding(.top, 8)
                                
                            } else {
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
                        .listRowBackgroundColor(Color.backgroundColor)
                    }
                }
                .showToast(isShowing: $viewModel.showToast, message: viewModel.toastMessage, color: viewModel.messageColor)
            }
            .background(Color.backgroundColor)
            .navigationBarTitle(Text(Constants.appTitle), displayMode: .large)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

