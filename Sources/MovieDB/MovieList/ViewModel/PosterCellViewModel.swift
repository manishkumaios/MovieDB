//
//  File.swift
//  
//
//  Created by MANISH KUMAR on 1/26/22.
//

import Foundation
import UIKit
import CorePackage

protocol ImageInjecting {
    func injectImage(to view: UIView) 
}

class PosterCellViewModel {
    private(set) var movie: Movie
    private var dataManager: MovieDataManaging
    init(movie: Movie, dataManager: MovieDataManaging) {
        self.movie = movie
        self.dataManager = dataManager
    }
    
    //TODO: As per documentation - Size is dynamic and we need to get it from configuration api
    func fetchImage(callback: @escaping (ApiStatus, Data?) -> Void) {
        guard let posterPath = movie.posterPath else {
            callback(.error(.unexpected), nil)
            return }
        dataManager.fetchMoviePoster(size: "w500", imagePosterUrl: posterPath) { status, data in
            callback(status, data)
        }
    }
}
