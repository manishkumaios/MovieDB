//
//  MovieDetailViewModel.swift
//  
//
//  Created by MANISH KUMAR on 1/26/22.
//

import Foundation
import UIKit

enum CellType {
    case title
    case status
    case tagLine
    case releaseDate
    case productionCompanies
    case spokenLanguages
    
    func getDescription(from model: MovieDetailModel, for cellType: Self) -> (title: String, detail: String) {
        switch cellType {
        case .title:
            return ("Title", model.title ?? "")
        case .status:
            return ("Status", model.status ?? "Unavailable")
        case .tagLine:
            return ("TagLine", model.tagline ?? "Unavailable")
        case .releaseDate:
            return ("Release date", model.releaseDate ?? "Unavailable")
        case .productionCompanies:
            let companies = model.productionCompanies
            var companiesSupport = ""
            //            companies.map { company in
            //                companiesSupport = companiesSupport + company.name + ", "
            //            }
            return ("Production Companies", companiesSupport)
        case .spokenLanguages:
            let languages = model.spokenLanguages
            var languageSupport = ""
            //            languages.map { languages in
            //                languageSupport = languageSupport + languages.englishName + ", "
            //            }
            return ("Luanguages released", languageSupport)
        }
        
    }
}

final class MovieDetailViewModel: ViewModeling {
    
    private(set) var dataManager: MovieDataManaging
    var uiCallback: ((VMCallback) -> Void)?
    private var movieId: Int?
    private(set) var dataSource: [CellType] = []
    
    required init(dataManager: MovieDataManaging) {
        self.dataManager = dataManager
    }
    
    required convenience init(id: Int, dataManager: MovieDataManaging) {
        self.init(dataManager: dataManager)
        self.movieId = id
    }
    
    var numberOfRows: Int {
        return dataSource.count
    }
    
    var screenTitle: String {
        return "Movie Detail"
    }
    
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
        //First reset
        dataSource.removeAll()
        if !(processModel.title?.isEmpty ?? false) {
            dataSource.append(.title)
        }
        
        if !(processModel.status?.isEmpty ?? false) {
            dataSource.append(.status)
        }
        
        if !(processModel.tagline?.isEmpty ?? false) {
            dataSource.append(.tagLine)
        }
        
        if !(processModel.releaseDate?.isEmpty ?? false) {
            dataSource.append(.releaseDate)
        }
        
        if !(processModel.productionCompanies?.isEmpty ?? false) {
            dataSource.append(.productionCompanies)
        }
        
        if !(processModel.spokenLanguages?.isEmpty ?? false) {
            dataSource.append(.spokenLanguages)
        }
    }
}
