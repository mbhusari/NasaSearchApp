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
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let href = searchDataItem?.links[0].href {
            let imageUrl = URL(string: href)
            self.searchedImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"))
        }
    
        if let titleString = searchDataItem?.data[0].title {
            self.titleLabel.text = titleString
        }
        
        if let dateCreated = searchDataItem?.data[0].dateCreated {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy'/'MM'-'dd'T'HH':'mm':'ssZZZ"
            if let date = dateFormatter.date(from: dateCreated) {
                creationDateLabel.text = dateFormatter.string(from: date)
            }
        }
        
        if let imageDescription = searchDataItem?.data[0].datumDescription {
            descriptionTextView.text = imageDescription
        }
    }
}
