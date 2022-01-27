//
//  MovieDBMainCoordinator.swift
//  
//
//  Created by MANISH KUMAR on 1/25/22.
//

import Foundation
import UIKit

public struct MovieDBMainCoordinator: Coordinating {
    
    private let navigationController: UINavigationController
    private let dependencyProvider: MovieDBDependencyProviding
    
    public init(navigationController: UINavigationController, dependencyProvider: MovieDBDependencyProviding) {
        self.navigationController = navigationController
        self.dependencyProvider = dependencyProvider
    }
    
    public func start() {
        showListScreen()
    }
    
    func finish() {
        
    }
}

private extension MovieDBMainCoordinator {
    func showListScreen() {
        let dataManager = MovieDataManager.init(networkProvider: dependencyProvider.networkProvider)
        let listViewModel = MovieListViewModel.init(dataManager: dataManager)
        let controller = MovieListViewController.init(viewModel: listViewModel, callback: {(callback) in
            switch callback {
            case .movieDetail(let id):
                showDetailScreen(id: id)
            }
        })
        self.navigationController.setViewControllers([controller], animated: false)
    }
    
    func showDetailScreen(id: Int) {
        let dataManager = MovieDataManager.init(networkProvider: dependencyProvider.networkProvider)
        let detailViewModel = MovieDetailViewModel.init(dataManager: dataManager)
        let controller = MovieDetailViewController.init(viewModel: detailViewModel)
        self.navigationController.pushViewController(controller, animated: true)
    }
}
