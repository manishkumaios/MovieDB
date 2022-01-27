//
//  MovieListViewModel.swift
//  
//
//  Created by MANISH KUMAR on 1/26/22.
//

import Foundation
import CorePackage

enum VMCallback {
    case startApi
    case endApi
    case reload
    case error(ApiError)
}

class MovieListViewModel: ViewModeling {
    var dataManager: MovieDataManaging
    private var pageIndex = 1
    private var dataSource: [Movie] = []
    var uiCallback: ((VMCallback) -> Void)?
    
    required init(dataManager: MovieDataManaging) {
        self.dataManager = dataManager
    }
    
    var screenTitle: String {
        "Popular movies".lowercased()
    }
    
    var numberOfRows: Int {
        dataSource.count
    }
    
    func fetchCellViewModel(for indexPath: IndexPath) -> PosterCellViewModel {
        return PosterCellViewModel(movie: self.movie(for: indexPath), dataManager: dataManager)
    }
    
    private func movie(for indexPath: IndexPath) -> Movie {
        return dataSource[indexPath.row]
    }
    
    func fetchPopularMovies() {
        uiCallback?(.startApi)
        dataManager.fetchRecentPopularMovies(page: pageIndex) {[weak self](status, movies) in
            guard let self = `self` else { return }
            self.uiCallback?(.endApi)
            switch status {
            case .success:
                guard let movies = movies?.results else { return }
                self.pageIndex = self.pageIndex + 1
                self.dataSource = self.dataSource + movies
                self.uiCallback?(.reload)
            case .error(let apiError):
                self.uiCallback?(.error(apiError))
            }
        }
    }
    
}
