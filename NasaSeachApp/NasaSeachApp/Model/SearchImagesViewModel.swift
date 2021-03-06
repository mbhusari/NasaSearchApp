//
//  SearchImagesViewModel.swift
//  NasaSeachApp
//
//  Created by Milind Bhusari on 5/5/22.
//

import Foundation

protocol SearchImagesViewModelInOut {
    func fetchSearchData(matching query: String,withCurrentPage page: Int)
    func fetchNextPageData(matching query: String,withCurrentPage page: Int)
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
    func fetchNextPageData(matching query: String, withCurrentPage page: Int) {
        
        let _ = networkService.fetchSearchData(with:.search(matching: query, page)) { [self] (result) in
             switch result {
             case .success(let elements):
                 var appendedList: [Any] = self.searchDataList
                 for element in elements {
                     appendedList.append(element)
                 }
                 self.searchDataList = appendedList
             case .failure(let err):
                 self.error = err
             }
         }
    }
    
    func fetchSearchData(matching query: String,withCurrentPage page: Int) {
       
       let _ = networkService.fetchSearchData(with:.search(matching: query, page)) { (result) in
            switch result {
            case .success(let elements):
                self.searchDataList = elements
            case .failure(let err):
                self.error = err
            }
        }
    }
}

