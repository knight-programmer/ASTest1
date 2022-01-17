//
//  NewsViewCell.swift
//  CountryApp
//
//  Created by Akash Katoch on 16/01/22.
//

import UIKit

class NewsViewCell: UITableViewCell {

    @IBOutlet weak var sourceImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func cellConfiguration(article : Article){
        if let url = URL(string: article.urlToImage ?? "") , let data = try? Data(contentsOf: url){
            self.sourceImage.image =  UIImage(data: data)
        }
        self.titleLabel.text = article.title
        self.descriptionLabel.text = article.description
    }
    
}
