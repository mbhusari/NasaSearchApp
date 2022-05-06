//
//  AppFlowDependencyContainer.swift
//  NasaSeachApp
//
//  Created by Milind Bhusari on 5/5/22.
//

import Foundation


class AppFlowDependencyContainer {
    static let shared = AppFlowDependencyContainer()
    
    lazy var networkService: DefaultNetworkService = {
        return DefaultNetworkService()
    }()
}
