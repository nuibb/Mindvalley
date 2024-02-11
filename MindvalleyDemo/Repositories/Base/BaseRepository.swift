//
//  BaseRepository.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 11/2/24.
//

import Foundation
import CoreData

protocol BaseRepository {
    associatedtype T
    
    func create(record: T) async -> StorageStatus
    func fetchAll() async -> [T]
    func fetch(byIdentifier id: String) async -> T?
    func update(record: T) async -> StorageStatus
    func delete(byIdentifier id: String) async -> StorageStatus
}
