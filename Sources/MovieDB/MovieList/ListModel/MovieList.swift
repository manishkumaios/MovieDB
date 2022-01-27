//
//  MovieList.swift
//  
//
//  Created by MANISH KUMAR on 1/26/22.
//

import Foundation

struct MovieList: Decodable {
    private(set) var page: Int?
    private(set) var results: [Movie]?
    
    private enum CodingKeys: String, CodingKey {
        case results
        case page
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        page = try? container.decodeIfPresent(Int.self, forKey: .page)
        results = try? container.decodeIfPresent([Movie].self, forKey: .results)
    }
}

struct Movie: Decodable {
    private(set) var posterPath: String?
    private(set) var id: Int?
    private(set) var title: String?
    
    private enum CodingKeys: String, CodingKey {
        case posterpath = "poster_path"
        case id, title
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        posterPath = try? container.decodeIfPresent(String.self, forKey: .posterpath)
        id = try? container.decodeIfPresent(Int.self, forKey: .id)
        title = try? container.decodeIfPresent(String.self, forKey: .title)
    }
}
