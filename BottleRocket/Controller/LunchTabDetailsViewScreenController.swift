//
//  LunchTabDetailsViewScreen.swift
//  BottleRocket
//
//  Created by Kenneth Adams on 4/16/21.
//

import UIKit
import MapKit

class LunchTabDetailsViewController: UIViewController {
    
    
    var restaurant: RestaurantClass?
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var socialOne: UILabel!
    @IBOutlet weak var socialTwo: UILabel!
    @IBOutlet weak var socialThree: UILabel!
    
    override func viewDidLoad(){
        
        super.viewDidLoad()
        guard let r = self.restaurant else {return}
        self.setUpTitle()
        self.setUpDetails(r: r)
    }
    
    func setUpTitle(){
        
        navigationItem.title = "Lunch Tyme"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Avenir Next Demi Bold", size: 17) as Any]
        let backButton = UIBarButtonItem(image: UIImage(named: "ic_webBack"), style: .plain, target: self, action: #selector(backSelected))
        backButton.tintColor = .white
        navigationItem.setLeftBarButton(backButton, animated: false)
    }
    
    func setUpDetails(r: RestaurantClass){
        
        name.font = UIFont(name: "Avenir Next Demi Bold", size: 16)
        name.text = r.name
        
        category.font = UIFont(name:"Avenir Next Regular", size: 12)
        category.text = r.category
        
        address.font = UIFont(name: "Avenir Next Regular", size: 16)
        address.text = r.location.formattedAddress?.joined(separator: " ")
        
        socialOne.font = UIFont(name: "Avenir Next Regular", size: 16)
        socialOne.text = r.contact.formattedPhone
        
        socialTwo.font = UIFont(name: "Avenir Next Regular", size: 16)
        socialTwo.text = "@\(r.contact.twitter ?? "")"
        
        socialThree.font = UIFont(name: "Avenir Next Regular", size: 16)
        socialThree.text = r.contact.facebookUserName
        
        let lat = r.location.lat
        let long = r.location.lng
        let initialLocation = CLLocation(latitude: lat!, longitude: long!)
        
        map.centerToLocation(initialLocation)
    }
    
    
    @objc func backSelected() {
        self.navigationController?.popViewController(animated: true)
    }
    
    static func create(ref: RestaurantClass) -> LunchTabDetailsViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "detailsVC") as? LunchTabDetailsViewController
        
        vc?.restaurant = ref
        
        return vc
    }
}

extension LunchTabDetailsViewController: UICollectionViewDelegate {
    
    func collectionView(_ colelctionView: UICollectionView, cellForRowAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let p = self.restaurant else {return UICollectionViewCell()}
        guard let cell = UICollectionView().dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? LunchTabCollectionViewCell else {return LunchTabCollectionViewCell()}
        return cell
    }
    
}

private extension MKMapView {
    func centerToLocation(
        _ location: CLLocation,
        regionRadius: CLLocationDistance = 100
    ) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}
