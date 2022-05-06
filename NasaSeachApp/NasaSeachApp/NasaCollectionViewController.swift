//
//  NasaCollectionViewController.swift
//  NasaSeachApp
//
//  Created by Milind Bhusari on 5/4/22.
//

import UIKit

private let reuseIdentifier = "searchCellIdentifier"
var searchImagesViewModel : SearchImagesViewModel!

class NasaCollectionViewController: UICollectionViewController, SearchImagesViewModelDelegate, UISearchBarDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchImagesViewModel = SearchImagesViewModel(AppFlowDependencyContainer.shared.networkService, self)
        self.title = searchImagesViewModel.title
    }
    
    override func viewWillAppear(_ animated: Bool) {
        searchImagesViewModel.fetchSearchData()
    }
}

extension NasaCollectionViewController {
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

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
        cell.fill(searchObj.links[0].href,searchObj.data[0].title)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let searchView: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "searchViewIdentifier", for: indexPath)
        return searchView
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(searchBar.text!)
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
        }
    }
    
    func handleError() {
        print("Error")
    }
}

