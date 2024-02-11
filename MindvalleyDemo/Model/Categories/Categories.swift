//
//  Categories.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 11/2/24.
//

import Foundation

struct CategoriesData: Decodable {
    let rawData : CategoriesRawData?

    enum CodingKeys: String, CodingKey {
        case rawData = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        rawData = try values.decodeIfPresent(CategoriesRawData.self, forKey: .rawData)
    }
}

struct CategoriesRawData: Decodable {
    let categories : [CategoryItem]

    enum CodingKeys: String, CodingKey {
        case categories = "categories"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        categories = try values.decodeIfPresent([CategoryItem].self, forKey: .categories) ?? []
    }

}

struct CategoryItem: Decodable {
    let id: String = UUID().uuidString + "\(Double.random(in: -1.0e100..<1.0e100))" + UUID().uuidString
    let name : String

    enum CodingKeys: String, CodingKey {
        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
    }
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}
