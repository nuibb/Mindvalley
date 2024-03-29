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
    var id: String
    let name : String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id) ?? ""
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
    }
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}
