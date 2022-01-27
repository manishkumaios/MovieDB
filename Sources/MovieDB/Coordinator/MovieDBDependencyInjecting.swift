//
//  MovieDBDependencyInjecting.swift
//  
//
//  Created by MANISH KUMAR on 1/26/22.
//

import Foundation

public protocol MovieDBDependencyProviding {
    var networkProvider: NetworkDependencyInjecting { get }
    var supportedLanguage: String { get }
}
