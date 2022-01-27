//
//  MovieDetailCellViewModel.swift
//  
//
//  Created by MANISH KUMAR on 1/27/22.
//

import Foundation
import CorePackage

struct MovieDetailCellViewModel: ImageProviding {
    private(set) var movie: MovieDetailModel
    private var dataManager: MovieDataManaging
    init(movie: MovieDetailModel, dataManager: MovieDataManaging) {
        self.movie = movie
        self.dataManager = dataManager
    }
    
    func fetchImage(callback: @escaping (ApiStatus, Data?) -> Void) {
        guard let posterPath = movie.posterPath else {
            callback(.error(.unexpected), nil)
            return }
        self.fetchImage(size: "w185", path: posterPath, dataManager: dataManager) { status, data in
            callback(status, data)
        }
    }
}
