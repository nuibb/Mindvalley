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
    @Published var categories: [CategoryItem] = []
    var toastMessage: String = ""
    
    let remoteDataProvider: ChannelsDataProvider
    let localDataProvider: StorageDataProvider
    
    init(remoteDataProvider: ChannelsDataProvider, localDataProvider: StorageDataProvider) {
        self.remoteDataProvider = remoteDataProvider
        self.localDataProvider = localDataProvider
        
        Utils.after(seconds: 1) { [weak self] in
            guard let self = self else { return }
            self.isRequesting = true //TODO: explore async group later to fetch all by group
            self.fetchNewEpisodes()
            self.fetchChannels()
            self.fetchCategories()
        }
    }
    
    func fetchNewEpisodes() {
        Task { [weak self] in
            guard let self = self else { return }
            let response = await remoteDataProvider.fetchNewEpisodes()
            if case .success(let result) = response {
                //Logger.log(type: .info, "[Episodes][Response][Data]: \(result)")
                DispatchQueue.main.async { [weak self] in
                    self?.isRequesting = false
                    let items = result.data?.mediaItems ?? []
                    self?.newEpisodes = items.count < 6 ? items : Array(items.prefix(6))
                    
                    // MARK: Insert into DB
                    self?.addEpisodes()
                }
            } else if case .failure(let error) = response {
                Logger.log(type: .error, "[Episodes][Request] failed: \(error.description)")
                DispatchQueue.main.async { [weak self] in
                    self?.isRequesting = false
                    
                    // MARK: Fetching from local storage if internet unavailable
                    if error.description == RequestError.networkNotAvailable.description {
                        self?.getEpisodes()
                        return
                    }
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
        Task { [weak self] in
            guard let self = self else { return }
            let response = await remoteDataProvider.fetchChannels()
            if case .success(let result) = response {
                //Logger.log(type: .info, "[Channels][Response][Data]: \(result)")
                DispatchQueue.main.async { [weak self] in
                    self?.isRequesting = false
                    self?.channels = result.rawData?.channels ?? []
                    
                    // MARK: Insert into DB
                    self?.addChannels()
                }
            } else if case .failure(let error) = response {
                Logger.log(type: .error, "[Channels][Request] failed: \(error.description)")
                DispatchQueue.main.async { [weak self] in
                    self?.isRequesting = false
                    
                    // MARK: Fetching from local storage if internet unavailable
                    if error.description == RequestError.networkNotAvailable.description {
                        self?.getChannels()
                        return
                    }
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
    
    func fetchCategories() {
        Task { [weak self] in
            guard let self = self else { return }
            let response = await remoteDataProvider.fetchCategories()
            if case .success(let result) = response {
                //Logger.log(type: .info, "[Categories][Response][Data]: \(result)")
                DispatchQueue.main.async { [weak self] in
                    self?.isRequesting = false
                    let filteredCategories = result.rawData?.categories.filter { !$0.name.isEmpty } ?? []
                    if !filteredCategories.isEmpty {
                        self?.categories = filteredCategories.enumerated().map { (index, item) in
                            CategoryItem(id: String(index), name: item.name)
                        }
                    }
                    
                    // MARK: Insert into DB
                    self?.addCategories()
                }
            } else if case .failure(let error) = response {
                Logger.log(type: .error, "[Categories][Request] failed: \(error.description)")
                DispatchQueue.main.async { [weak self] in
                    self?.isRequesting = false
                    
                    // MARK: Fetching from local storage if internet unavailable
                    if error.description == RequestError.networkNotAvailable.description {
                        self?.getCategories()
                        return
                    }
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
