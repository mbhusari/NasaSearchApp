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
    
    func fill(_ imageURLString: String,_ labelTitle: String) {
        let imageUrl = URL(string: imageURLString)
        self.searchItemImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"))
        self.searchItemLabel.text = labelTitle
    }
}
