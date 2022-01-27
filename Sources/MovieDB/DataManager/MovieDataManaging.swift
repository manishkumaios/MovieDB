//
//  MovieDataManaging.swift
//  
//
//  Created by MANISH KUMAR on 1/25/22.
//

import Foundation
import CorePackage

public protocol NetworkDependencyInjecting {
    var apiKey: String? { get }
    var shouldUseExternalNetworkLib: Bool { get }
    var shouldUseExternalImageDownloader: Bool { get }
    var supportedLocale: String? { get }
}

protocol MovieDataManaging {
    func fetchRecentPopularMovies(page: Int, callback: @escaping (ApiStatus, MovieList?) -> Void)
    func fetchMovieDetails(id: String, callback: @escaping (ApiStatus, MovieDetailModel?) -> Void)
    func fetchMoviePoster(size: String, imagePosterUrl: String, callback: @escaping (ApiStatus, Data?) -> Void)
}
