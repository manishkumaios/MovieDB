//
//  MovieDetailViewModel.swift
//  
//
//  Created by MANISH KUMAR on 1/26/22.
//

import Foundation
import UIKit

final class MovieDetailViewModel: ViewModeling {
    
    private(set) var dataManager: MovieDataManaging
    var uiCallback: ((VMCallback) -> Void)?
    private var movieId: Int?
    private var detailModel: MovieDetailModel?
    
    required init(dataManager: MovieDataManaging) {
        self.dataManager = dataManager
    }
    
    required convenience init(id: Int, dataManager: MovieDataManaging) {
        self.init(dataManager: dataManager)
        self.movieId = id
    }
    
    var numberOfRows: Int {
        guard let detailModel = detailModel else {
            return 0
        }

        return 1
    }
    
    var screenTitle: String {
        return "Movie Detail"
    }
    
   lazy var cellViewModel: MovieDetailCellViewModel = {
       return MovieDetailCellViewModel.init(movie: detailModel! , dataManager: dataManager)
    }()
    
    
    func fetchMovieDetail() {
        guard let movieId = movieId else {
            return
        }

        uiCallback?(.startApi)
        dataManager.fetchMovieDetails(id: "\(movieId)") {[weak self] (status, responseModel) in
            guard let self = `self` else { return }
            self.uiCallback?(.endApi)
            switch status {
            case .success:
                guard let model = responseModel else {return}
                self.processModel(processModel: model)
            case .error(let apiError):
                self.uiCallback?(.error(apiError))
            }
        }
    }
    
    private func processModel(processModel: MovieDetailModel) {
        defer {
            self.uiCallback?(.reload)
        }
        self.detailModel = processModel
    }
}
