//
//  Restaurant.swift
//  BottleRocket
//
//  Created by Kenneth Adams on 4/15/21.
//

import Foundation

struct Restaurants: Codable {
    var restaurants : [Restaurant]
    
    enum CodingKeys: String, CodingKey {
        case restaurants
        
    }
    
    
}

struct Restaurant: Codable {
    var name: String
    var backgroundImageURL : String
    var category : String
    var contact : Contact?
    var location: Location
    
    enum CodingKeys: String, CodingKey {
        
        case contact, location, backgroundImageURL, category, name
        
    }
    
     init() {
            self.name = ""
            self.backgroundImageURL = ""
            self.category = ""
            self.contact = Contact()
            self.location = Location()
        }
    
}


struct Contact : Codable {
    
    var phone: String?
    var formattedPhone: String?
    var twitter: String?
    var facebook: String?
    var facebookUserName: String?
    var facebookName: String?
    
    enum CodingKeys: String, CodingKey {
        
        case phone, formattedPhone, twitter, facebook, facebookUserName, facebookName
    }
    
    init(){
        self.phone = ""
        self.formattedPhone = " "
        self.twitter = ""
        self.facebook = ""
        self.facebookUserName = ""
        self.facebookName = ""
    }
}

struct Location : Codable {
    var address: String?
    var crossStreet: String?
    var lat: Double?
    var lng: Double?
    var postalCode: String?
    var cc: String?
    var city: String?
    var state: String?
    var country: String?
    var formattedAddress: [String]?
    
    enum CodingKeys: String, CodingKey {
        
        case address, crossStreet, lat, lng, postalCode, cc, city, state, country, formattedAddress
    }

    init(){
        self.address = ""
        self.crossStreet = ""
        self.lat = 0
        self.lng = 0
        self.postalCode = ""
        self.cc = ""
        self.city = ""
        self.state = ""
        self.country = ""
        self.formattedAddress = [""]
    }
}





