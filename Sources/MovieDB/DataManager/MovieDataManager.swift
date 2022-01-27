//
//  MovieDataManager.swift
//  
//
//  Created by MANISH KUMAR on 1/25/22.
//

import Foundation
import CorePackage

struct ApiContants {
    static let baseURL = "https://api.themoviedb.org/3/movie"
    static let baseImageURL  = "https://image.tmdb.org/t/p"
    static let listApiPath = "%@/popular?api_key=%@&language=%@&page=%d"
    static let imageDownloadPath = "%@/%@/%@"
    static let detailApiPath = "%@/%@?api_key=%@&language=%@"
}

struct MovieDataManager: MovieDataManaging {
    private var networkDependencyProvider: NetworkDependencyInjecting
    
    init(networkProvider: NetworkDependencyInjecting) {
        self.networkDependencyProvider = networkProvider
    }
    // "https://api.themoviedb.org/3/movie/popular?api_key=4c2ec074327865890d22380b7bef0152&language=en-US&page=1
    func fetchRecentPopularMovies(page: Int, callback: @escaping (ApiStatus, MovieList?) -> Void) {
        let networkProvider = NetworkApiProvider(dataSource: self)
        guard let apiKey = networkDependencyProvider.apiKey, let locale = networkDependencyProvider.supportedLocale else {
            callback(.error(.unexpected), nil)
            return
        }
        
        let popularImageURL = String(format: ApiContants.listApiPath,ApiContants.baseURL, apiKey,locale, page)
        
        networkProvider.request(url: popularImageURL, params: nil, requestType: .get) { data, status, model in
            callback(status, model)
        }
    }
    
    //https://api.themoviedb.org/3/movie/524434?api_key=4c2ec074327865890d22380b7bef0152&language=en-US
    func fetchMovieDetails(id: String, callback: @escaping (ApiStatus, MovieDetailModel?) -> Void) {
        let networkProvider = NetworkApiProvider(dataSource: self)
        guard let apiKey = networkDependencyProvider.apiKey, let locale = networkDependencyProvider.supportedLocale else {
            callback(.error(.unexpected), nil)
            return
        }
        
        let movieDetailURL = String(format:ApiContants.detailApiPath ,ApiContants.baseURL,id, apiKey, locale)
        networkProvider.request(url: movieDetailURL, params: nil, requestType: .get) { data, status, model in
            callback(status, model)
        }
    }
    
    //https://image.tmdb.org/t/p/w185/oifhfVhUcuDjE61V5bS5dfShQrm.jpg
    func fetchMoviePoster(size: String, imagePosterUrl: String, callback: @escaping (ApiStatus, Data?) -> Void) {
        let networkProvider = NetworkApiProvider(dataSource: self)
        let downloadImageURL = String(format: ApiContants.imageDownloadPath, ApiContants.baseImageURL, size,imagePosterUrl)
        networkProvider.downloadImages(url: downloadImageURL, params: nil) { (data, status) in
            callback(status, data)
        }
    }

}

extension MovieDataManager: CorePackageDataManaging {
    var shouldUseOwnNetworkInterface: Bool {
        networkDependencyProvider.shouldUseExternalNetworkLib
    }
    
    var shouldUseExternalImageDownloader: Bool {
        networkDependencyProvider.shouldUseExternalImageDownloader
    }
}
