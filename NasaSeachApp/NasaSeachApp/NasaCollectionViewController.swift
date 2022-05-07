//
//  NasaCollectionViewController.swift
//  NasaSeachApp
//
//  Created by Milind Bhusari on 5/4/22.
//

import UIKit

private let reuseIdentifier = "searchCellIdentifier"
var searchImagesViewModel : SearchImagesViewModel!
var page: Int = 1
var isPageRefreshing:Bool = false
let maxPageCount = 100
var query = ""

class NasaCollectionViewController: UICollectionViewController, SearchImagesViewModelDelegate, UISearchBarDelegate {
    
    @IBOutlet var searchBarView: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchImagesViewModel = SearchImagesViewModel(AppFlowDependencyContainer.shared.networkService, self)
        searchBarView.delegate = self
        navigationItem.titleView = searchBarView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        searchImagesViewModel.fetchSearchData(matching: query, withCurrentPage: page)
    }
}

extension NasaCollectionViewController {
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchImagesViewModel.searchDataList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
             withReuseIdentifier: reuseIdentifier,
             for: indexPath) as? SearchCollectionViewCell else {
                 return UICollectionViewCell()
             }
        
        let searchObj: Item = searchImagesViewModel.searchDataList[indexPath.row] as! Item
        cell.fill(searchObj)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let searchView: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "searchViewIdentifier", for: indexPath)
        return searchView
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastItem = searchImagesViewModel.searchDataList.count - 1
        if indexPath.row == lastItem {
            if !isPageRefreshing {
                isPageRefreshing = true
                page += 1
                if page <= maxPageCount {
                    searchImagesViewModel.fetchNextPageData(matching: query, withCurrentPage: page)
                }
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchQuery = searchBar.text {
            query = searchQuery
            page = 1
            searchImagesViewModel.fetchSearchData(matching: query, withCurrentPage: page)
        }
    }
}

extension NasaCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let viewController:SearchDetailsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchDetailsViewController") as? SearchDetailsViewController {
            viewController.searchDataItem = searchImagesViewModel.searchDataList[indexPath.row] as? Item
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

extension NasaCollectionViewController {
    func handleSearchDataFetch() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            isPageRefreshing = false
        }
    }
    
    func handleError() {
        print("Error")
    }
}

