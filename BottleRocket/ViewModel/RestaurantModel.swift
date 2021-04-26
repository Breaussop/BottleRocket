//
//  RestaurantModel.swift
//  BottleRocket
//
//  Created by Kenneth Adams on 4/15/21.
//

import UIKit


class RestaurantModel {
    
    let url = "https://s3.amazonaws.com/br-codingexams/restaurants.json"
    let amount = 14
    var restaurants: [Restaurant] = []
    var finalRestaurants: [RestaurantClass] = []
    let networkManager = NetworkManager.shared
    
    var updateHandler: (() -> ())?
    
    init() {
        
    }
    
    func bind(updateHandler: @escaping () -> ()) {
        self.updateHandler = updateHandler
    }
    
    func fetchRestaurants(url: String) {
        networkManager.fetchData(url: url ) { [weak self] (result: Result<Restaurants,MyError>) in
            guard let self = self else {return}
            switch result {
            case .success(let restaurantlist):
                self.restaurants = restaurantlist.restaurants
                
                let group = DispatchGroup()
                for num in 0..<self.restaurants.count {
                    group.enter()
                    self.networkManager.fetchImage(url: restaurantlist.restaurants[num].backgroundImageURL){[weak self](result: Result<UIImage, MyError>) in
                        guard let self = self else {return}
                        switch result {
                        case .success(let image):
                            self.finalRestaurants.append((RestaurantClass(restaurant: self.restaurants[num], image: image)))
                        case .failure(let error):
                            print(error)
                        }
                        group.leave()
                    }
                    
                }
                group.notify(queue: .global()) {
                    self.updateHandler?()
                }
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func image(for index: Int) -> UIImage {
        return self.finalRestaurants[index].backgroundImage
    }
    
 
}


