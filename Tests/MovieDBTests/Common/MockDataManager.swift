//
//  MockDataManager.swift
//  
//
//  Created by MANISH KUMAR on 1/27/22.
//

import Foundation

@testable import MovieDB
@testable import CorePackage

protocol ApiDecoding {
    func decode<T: Decodable>(from response: Data, type: T.Type) throws -> T?
}

class TestApiDecoder: ApiDecoding {
    func decode<T: Decodable>(from response: Data, type: T.Type) throws -> T? {
        let jsonDecoder =  JSONDecoder()
        return try jsonDecoder.decode(T.self, from: response)
    }
    
    func getJsonResponse<T: Decodable>(fileName: String) -> T? {
        let bundle = Bundle.module
        
        guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
            fatalError("\(fileName).json not found")
        }
       
        let jsonData = try! Data(contentsOf: url)
        
        let decodedData = try? TestApiDecoder().decode(from: jsonData, type: T.self)
        return decodedData
    }
}




class MockDataManager: MovieDataManaging {
    func fetchRecentPopularMovies(page: Int, callback: @escaping (ApiStatus, MovieList?) -> Void) {
        callback(.success, TestApiDecoder().getJsonResponse(fileName: "MovieList"))
        
    }
    
    func fetchMovieDetails(id: String, callback: @escaping (ApiStatus, MovieDetailModel?) -> Void) {
        callback(.success, TestApiDecoder().getJsonResponse(fileName: "MovieDetail"))
    }
    
    func fetchMoviePoster(size: String, imagePosterUrl: String, callback: @escaping (ApiStatus, Data?) -> Void) {
        callback(.success, Data())
    }
    
    
}
