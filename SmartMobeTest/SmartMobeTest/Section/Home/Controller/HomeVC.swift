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
    
    var homedata = [HomeModel]()
    lazy var searchBar:UISearchBar = UISearchBar()
    var isSearch = true
    
    override func loadView() {
        super.loadView()
       HomeApiCall()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        Util.setupNavigationBar(leftButtonIcon: "", Tittle: "Home", rightButtonIcon: "\u{1F50D}", parent: self)
    }
    
    func setupGradientBackground(BGView:UIView) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.blue.cgColor,UIColor.orange.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        
        BGView.layer.addSublayer(gradientLayer)
    }
    func setUpSearchbar() {
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isHidden = false
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self as UISearchBarDelegate
        navigationItem.titleView = searchBar
       //  UINavigationBar.addSubview(searchBar)

    }
    func RemoveSearchbar() {
        self.searchBar.endEditing(true)
        self.searchBar.isHidden = true
         navigationItem.titleView = nil
        navigationItem.title = "home"
    }
    override func navRightButtonTapped() {
        print("searchicon pressed")
        
        if isSearch{
            Util.setupNavigationBar(leftButtonIcon: "", Tittle: "Home", rightButtonIcon: "   \u{2716}", parent: self)
            setUpSearchbar()
        }else{
            RemoveSearchbar()
        }
        
        isSearch = !isSearch
    }
    
}
//MARK: searchbar delegate
extension HomeVC: UISearchBarDelegate{
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("searchText \(searchText)")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchText \(String(describing: searchBar.text))")
      //  self.view.endEditing(true)
        self.searchBar.endEditing(true)
        Handler.makeToast(message: "search text --\(searchBar.text!)")
    }
    
}
//MARK: uicollecytionview delegate/ data source
extension HomeVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homedata.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCell
        setupGradientBackground(BGView: cell.CellbackGround)
        let indexdata = homedata[indexPath.row]
        cell.configureCell(celldata: indexdata)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (UIDevice.current.model == "iPhone"){
            switch UIDevice.current.modelName {
            case "iPhone 5":
                print("iphone 5,5s,SE,5c")
               return  CGSize(width: self.view.frame.width/2.3, height: 200)
               
                break
            default:
                 print("iphone defult")
                // for all device exclusive small iphone and include simulator so in simultor iphone 5/se single row is shown
                return  CGSize(width: self.view.frame.width/2.2, height: 200)
            }
        }else{
           return  CGSize(width: 200, height: 200)
        }
        
        
    }
}

//MARK:- API call
extension HomeVC{
    func HomeApiCall() {
        
        WebService.GetAt(url: APIConfig.GetProducts.urlPath(), parameters: nil, successBlock: { (responceObject) in
            
            let rdata = responceObject?["images"].arrayObject
            print(rdata!)
            do {
                let responceData = try JSONSerialization.data(withJSONObject: rdata as Any, options: .prettyPrinted)
                //     let convertedString = String(data: responceData, encoding: String.Encoding.utf8) // the data will be converted to the string
                let jsonDecoder = JSONDecoder()
                self.homedata = try! jsonDecoder.decode([HomeModel].self, from: responceData)
                print(self.homedata)
                self.collectionview.reloadData()
            } catch let myJSONError {
                print(myJSONError)
            }
        }) { (error) in
            Handler.makeToast(message: error)
        }
    }
}
