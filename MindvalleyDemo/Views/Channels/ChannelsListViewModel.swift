//
//  ChannelsListViewModel.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 6/2/24.
//

import Foundation
import SwiftUI

final class ChannelsListViewModel: ObservableObject {
    @Published var messageColor: Color = MessageType.error.color
    @Published var isRequesting: Bool = false
    @Published var showToast: Bool = false
    @Published var newEpisodes: [Episode] = []
    @Published var channels: [Channel] = []
    
    let dataProvider: ChannelsDataProvider
    var toastMessage: String = ""
    
    init(dataProvider: ChannelsDataProvider) {
        self.dataProvider = dataProvider
        Utils.after(seconds: 1) { [weak self] in
            guard let self = self else { return }
            self.fetchNewEpisodes()
            self.fetchChannels()
        }
    }
    
    func fetchNewEpisodes() {
        self.isRequesting = true
        
        Task { [weak self] in
            guard let self = self else { return }
            let response = await dataProvider.fetchNewEpisodes()
            if case .success(let result) = response {
                Logger.log(type: .error, "[Response][Data]: \(result)")
                DispatchQueue.main.async { [weak self] in
                    self?.isRequesting = false
                    let items = result.data?.mediaItems ?? []
                    self?.newEpisodes = items.count < 6 ? items : Array(items.prefix(6))
                }
            } else if case .failure(let error) = response {
                Logger.log(type: .error, "[Request] failed: \(error.description)")
                DispatchQueue.main.async { [weak self] in
                    self?.isRequesting = false
                    self?.displayMessage(error.description)
                }
            } else {
                DispatchQueue.main.async { [weak self] in
                    self?.isRequesting = false
                    self?.displayMessage(RequestError.unknown.description)
                }
            }
        }
    }
    
    func fetchChannels() {
        self.isRequesting = true
        
        Task { [weak self] in
            guard let self = self else { return }
            let response = await dataProvider.fetchChannels()
            if case .success(let result) = response {
                Logger.log(type: .error, "[Response][Data]: \(result)")
                DispatchQueue.main.async { [weak self] in
                    self?.isRequesting = false
                    let items = result.rawData?.channels ?? []
                    self?.channels = items.count < 6 ? items : Array(items.prefix(6))
                }
            } else if case .failure(let error) = response {
                Logger.log(type: .error, "[Request] failed: \(error.description)")
                DispatchQueue.main.async { [weak self] in
                    self?.isRequesting = false
                    self?.displayMessage(error.description)
                }
            } else {
                DispatchQueue.main.async { [weak self] in
                    self?.isRequesting = false
                    self?.displayMessage(RequestError.unknown.description)
                }
            }
        }
    }
    
    private func displayMessage(_ msg: String) {
        toastMessage = msg
        showToast = true
        Utils.after(seconds: 5.0) { [weak self] in
            self?.toastMessage = ""
        }
    }
    
}
