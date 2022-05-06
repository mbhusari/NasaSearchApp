//
//  SearchDetailsViewController.swift
//  NasaSeachApp
//
//  Created by Milind Bhusari on 5/5/22.
//

import UIKit
import SDWebImage

class SearchDetailsViewController: UIViewController {
    var searchDataItem:Item?
    
    @IBOutlet weak var searchedImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var creationDateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let href = searchDataItem?.links[0].href {
            let imageUrl = URL(string: href)
            self.searchedImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"))
        }
    
        self.titleLabel.text = searchDataItem?.data[0].title
        creationDateLabel.text = searchDataItem?.data[0].dateCreated
        descriptionLabel.text = searchDataItem?.data[0].datumDescription
    }
}
