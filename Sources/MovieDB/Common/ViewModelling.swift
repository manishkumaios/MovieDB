//
//  ViewModelling.swift
//  
//
//  Created by MANISH KUMAR on 1/26/22.
//

import Foundation

protocol ViewModeling {
    var dataManager: MovieDataManaging { get }
    var uiCallback: ((VMCallback) -> Void)? { get }
    var screenTitle: String { get }
    init(dataManager: MovieDataManaging)
    var numberOfRows: Int { get }
}
