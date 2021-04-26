//
//  LunchTabViewController.swift
//  BottleRocket
//
//  Created by Kenneth Adams on 4/15/21.
//

import Foundation
import UIKit

class Lunch: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    let lunchVM = RestaurantModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpTitle()
        self.setUpCollection()
        
        
    }
    
    func setUpTitle() {
        self.navigationItem.title = "Lunch Tyme"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Avenir Next Demi Bold", size: 17) as Any]
        
        
    }
    
    
    
    func setUpCollection() {
        
        lunchVM.fetchRestaurants(url: "https://s3.amazonaws.com/br-codingexams/restaurants.json")
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: collectionView.bounds.size.width, height: 180)
        collectionView.collectionViewLayout = layout
        
        collectionView.register(LunchTabCollectionViewCell.nib(), forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.lunchVM.bind {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        guard let flow = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        flow.invalidateLayout()
    }
    
    
}

extension Lunch: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        print("tapped")
        guard let vc = LunchTabDetailsViewController.create(ref: self.lunchVM.finalRestaurants[indexPath.item]) else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.lunchVM.finalRestaurants.count
    }
}


extension Lunch: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as! LunchTabCollectionViewCell

        cell.restaurantLabel.text = self.lunchVM.finalRestaurants[indexPath.item].name
        cell.categoryLabel.text = self.lunchVM.finalRestaurants[indexPath.item].category
        cell.imageView.image = self.lunchVM.image(for: indexPath.item)
        
        return cell
    }
}

extension Lunch: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            return CGSize(width: collectionView.bounds.size.width, height: 180)
        default:
            return CGSize(width: collectionView.bounds.size.width/2  - 5, height: 180)
            
        }
    }
}



func nullTextCell(cell: UILabel){
    cell.textColor = .white
    cell.text = ""
    cell.backgroundColor = .white
}
