//
//  HomeVC.swift
//  SmartMobeTest
//
//  Created by Arun kumar Sah on 4/10/19.
//  Copyright © 2019 Arun kumar Sah. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    @IBOutlet var BackGroundView: UIView!
    
    @IBOutlet weak var collectionview: UICollectionView!
    
    override func loadView() {
        super.loadView()
       // setupGradientBackground()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        Util.setupNavigationBar(leftButtonIcon: "a", Tittle: "Home", rightButtonIcon: "A", parent: self)
    }
    
    func setupGradientBackground(BGView:UIView) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.blue.cgColor,UIColor.orange.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        
        BGView.layer.addSublayer(gradientLayer)
    }
    
}
//MARK: uicollecytionview delegate/ data source
extension HomeVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCell
        setupGradientBackground(BGView: cell.CellbackGround)
    
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (UIDevice.current.model == "iPhone"){
            switch UIDevice.current.modelName {
            case "iPhone 5":
               return  CGSize(width: self.view.frame.width/2.3, height: 200)
                print("iphone 5,5s,SE,5c")
                break
            default:
                // for all device exclusive small iphone and include simulator so in simultor iphone 5/se single row is shown
                return  CGSize(width: self.view.frame.width/2.2, height: 200)
                print("iphone defult")
                break
            }
        }else{
           return  CGSize(width: self.view.frame.width/2.2, height: 200)
        }
        
        
    }
    
    
}
