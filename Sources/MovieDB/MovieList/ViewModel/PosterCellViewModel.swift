//
//  File.swift
//  
//
//  Created by MANISH KUMAR on 1/26/22.
//

import Foundation
import UIKit
import CorePackage



class PosterCellViewModel: ImageProviding {
    private(set) var movie: Movie
    private var dataManager: MovieDataManaging
    init(movie: Movie, dataManager: MovieDataManaging) {
        self.movie = movie
        self.dataManager = dataManager
    }
    
    func fetchImage(callback: @escaping (ApiStatus, Data?) -> Void) {
        guard let posterPath = movie.posterPath else {
            callback(.error(.unexpected), nil)
            return }
        self.fetchImage(size: "w500", path: posterPath, dataManager: dataManager) { status, data in
            callback(status, data)
        }
    }
}
