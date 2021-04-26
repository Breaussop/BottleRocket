//
//  LunchTabCollectionViewCell.swift
//  BottleRocket
//
//  Created by Kenneth Adams on 4/15/21.
//

import UIKit

class LunchTabCollectionViewCell: UICollectionViewCell {
    
 @IBOutlet   var imageView: UIImageView!
 @IBOutlet   var restaurantLabel: UILabel!
 @IBOutlet   var categoryLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure(with image: UIImage, name: String, category: String){
        
        
        imageView.image = image
        
        restaurantLabel.font = UIFont(name: "Avenir Next Demi Bold", size: 16)
        restaurantLabel.text = name
        
        categoryLabel.font = UIFont(name: "Avenir Next Regular", size: 12)
        categoryLabel.text = category
        
        
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "LunchTabCollectionViewCell", bundle: nil)
    }

}
