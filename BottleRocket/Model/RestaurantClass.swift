//
//  RestaurantClass.swift
//  BottleRocket
//
//  Created by Kenneth Adams
//

import UIKit


class RestaurantClass {
    
    var name: String
    var backgroundImage: UIImage
    var category : String
    var contact : Contact
    var location: Location
    
    init(restaurant: Restaurant, image: UIImage) {
        self.name = restaurant.name
        self.backgroundImage = image
        self.category = restaurant.category
        self.contact = restaurant.contact ?? Contact()
        self.location = restaurant.location
    }
    
    init() {
        self.name = ""
        self.backgroundImage = UIImage()
        self.category = ""
        self.contact = Contact()
        self.location = Location()
    }
}
