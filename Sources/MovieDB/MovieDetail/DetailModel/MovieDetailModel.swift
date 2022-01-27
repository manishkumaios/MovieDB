//
//  MovieDetailModel.swift
//  
//
//  Created by MANISH KUMAR on 1/26/22.
//

import Foundation

struct MovieDetailModel: Decodable {
    private(set) var title: String?
    private(set) var status: String?
    private(set) var tagline: String?
    private(set) var releaseDate: String?
    private(set) var productionCompanies: [ProductionCompanies]?
    private(set) var spokenLanguages: [SpokenLanguages]?
    
    private enum CodingKeys: String, CodingKey {
        case title
        case status
        case tagline
        case releaseDate = "release_date"
        case productionCompanies = "production_companies"
        case spokenLanguages = "spoken_languages"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try? container.decodeIfPresent(String.self, forKey: .title)
        status = try? container.decodeIfPresent(String.self, forKey: .status)
        tagline = try? container.decodeIfPresent(String.self, forKey: .tagline)
        releaseDate = try? container.decodeIfPresent(String.self, forKey: .releaseDate)
        productionCompanies = try? container.decodeIfPresent([ProductionCompanies].self, forKey: .productionCompanies)
        spokenLanguages = try? container.decodeIfPresent([SpokenLanguages].self, forKey: .spokenLanguages)
    }
}

struct ProductionCompanies: Decodable {
    private(set) var id: Int?
    private(set) var logoPath: String?
    private(set) var name: String?
    private(set) var originCountry: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try? container.decodeIfPresent(Int.self, forKey: .id)
        logoPath = try? container.decodeIfPresent(String.self, forKey: .logoPath)
        name = try? container.decodeIfPresent(String.self, forKey: .name)
        originCountry = try? container.decodeIfPresent(String.self, forKey: .originCountry)
    }
}

struct SpokenLanguages: Decodable {
    private(set) var englishName: String?
    private enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        englishName = try? container.decodeIfPresent(String.self, forKey: .englishName)
    }
}
