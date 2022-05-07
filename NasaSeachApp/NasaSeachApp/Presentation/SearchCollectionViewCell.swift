//
//  SearchCollectionViewCell.swift
//  NasaSeachApp
//
//  Created by Milind Bhusari on 5/5/22.
//

import UIKit
import SDWebImage

class SearchCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var searchItemImage: UIImageView!
    @IBOutlet weak var searchItemLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    func fill(_ searchObj: Item) {
        let imageUrl = URL(string: searchObj.links[0].href)
        self.searchItemImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"))
        self.searchItemLabel.text = searchObj.data[0].title
        self.locationLabel.text = searchObj.data[0].location
    }
}
