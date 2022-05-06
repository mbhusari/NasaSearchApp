//
//  SearchImagesViewModel.swift
//  NasaSeachApp
//
//  Created by Milind Bhusari on 5/5/22.
//

import Foundation

protocol SearchImagesViewModelInOut {
   func fetchSearchData()
}

protocol SearchImagesViewModelOutput {
    var searchDataList : [Any] { get }
    var error: Error? { get }
}

protocol SearchImagesViewModelDelegate: AnyObject {
    func handleSearchDataFetch()
    func handleError()
}

class SearchImagesViewModel : SearchImagesViewModelOutput {
    var title: String = "Search Images"
    weak var delegate: SearchImagesViewModelDelegate?
    var networkService: DefaultNetworkService
    
    var searchDataList: [Any] = [] {
        didSet {
            delegate?.handleSearchDataFetch()
        }
    }
    
    var error: Error? {
        didSet {
            delegate?.handleError()
        }
    }
        
    init(_ networkService: DefaultNetworkService,_ delegate: SearchImagesViewModelDelegate?) {
        self.networkService = networkService
        self.delegate = delegate
    }
}

extension SearchImagesViewModel: SearchImagesViewModelInOut {
    func fetchSearchData() {
       
        let _ = networkService.fetchSearchData(with: EndPoint()) { (result) in
            switch result {
            case .success(let elements):
                self.searchDataList = elements
            case .failure(let err):
                self.error = err
            }
        }
    }

}

