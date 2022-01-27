//
//  ImageProviding.swift
//  
//
//  Created by MANISH KUMAR on 1/27/22.
//

import Foundation
import CorePackage

protocol ImageProviding {
    func fetchImage(size: String, path:String, dataManager: MovieDataManaging, callback: @escaping (ApiStatus, Data?) -> Void)
}

extension ImageProviding {
    func fetchImage(size: String, path:String, dataManager: MovieDataManaging, callback: @escaping (ApiStatus, Data?) -> Void) {
        dataManager.fetchMoviePoster(size: size, imagePosterUrl: path) { status, data in
            callback(status, data)
        }
    }
}
