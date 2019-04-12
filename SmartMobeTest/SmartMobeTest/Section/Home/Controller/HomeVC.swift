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
    var refreshControl  : UIRefreshControl!
    
    var homedata = [HomeModel]()
    lazy var searchBar:UISearchBar = UISearchBar()
    var isSearch = true
    var nameArray = [String]()
     var FilterednameArray = [String]()
    var currentIndex = 0
    var Dheight:CGFloat = 0
    var Dwidth:CGFloat = 0
    
    override func loadView() {
        super.loadView()
        nameArray = ["Apple","banana","Cat","Dog","Elephnat","Frog","Girraf","hen"," Polar Bear","Hummingbird"]
       HomeApiCall()
        
        Dheight = self.collectionview.frame.height
        Dwidth = self.view.frame.width
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        Util.setupNavigationBar(leftButtonIcon: "", Tittle: "Home", rightButtonIcon: "\u{1F50D}", parent: self)
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(sender:)), for: UIControl.Event.valueChanged)
        self.collectionview.addSubview(refreshControl)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
        } else {
            print("Portrait")
        }
    }
    
    @objc func refresh(sender:AnyObject) {
       HomeApiCall()
        refreshControl.endRefreshing()
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
           // Util.setupNavigationBar(leftButtonIcon: "", Tittle: "Home", rightButtonIcon: "\u{2716}", parent: self)
             Util.setupRightButton("\u{2716}", parent: self)
            setUpSearchbar()
        }else{
            RemoveSearchbar()
            Util.setupRightButton("\u{1F50D}", parent: self)
            collectionview.reloadData()
        }
        
        isSearch = !isSearch
    }
    
}
//MARK: searchbar delegate
extension HomeVC: UISearchBarDelegate{
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("searchText \(searchText)")
         searchedArray(searchtext: searchBar.text!)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchText \(String(describing: searchBar.text))")
        self.view.endEditing(true)
        self.searchBar.endEditing(true)
        searchedArray(searchtext: searchBar.text!)

        
    }
    
    func searchedArray(searchtext:String) {
        FilterednameArray.removeAll()
        let lowercasearray = nameArray.map{$0.lowercased()}
        if lowercasearray.contains(searchtext.lowercased()){
            FilterednameArray.append(searchtext)
        }
        FilterednameArray.removeDuplicates()
        collectionview.reloadData()
//        for name in nameArray
//        {
//            if name == searchtext {
//                print("Found \(name) for index \(currentIndex)")
//                break
//            }
//
//            currentIndex += 1
   //     }
    }
    
}
//MARK: uicollecytionview delegate/ data source
extension HomeVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        
        if !isSearch {
            return FilterednameArray.count
        }else{
             return homedata.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCell
        setupGradientBackground(BGView: cell.CellbackGround)
        let indexdata = homedata[indexPath.row]
        
        var dtitle = ""
        if !isSearch {
            dtitle = FilterednameArray[indexPath.row]
        }else{
           dtitle = nameArray[indexPath.row]
        }
        cell.configureCell(celldata: indexdata, title: dtitle)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var tittleText = ""
        if !isSearch {
            tittleText = FilterednameArray[indexPath.row]
        }else{
            tittleText = nameArray[indexPath.row]
        }
        navigationController?.pushViewController(Routes.GetHomeDetailVC(img: homedata[indexPath.row].url!, titlletext: tittleText), animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (UIDevice.current.model == "iPhone"){
            return CGSize(width: Dwidth/2.22, height: 200)
//            switch UIDevice.current.modelName {
//            case "iPhone 5":
//                print("iphone 5,5s,SE,5c")
//               return  CGSize(width: self.view.frame.width/2.3, height: 200)
//
//                break
//            default:
//                 print("iphone defult")
//                // for all device exclusive small iphone and include simulator so in simultor iphone 5/se single row is shown
//                return  CGSize(width: self.view.frame.width/2.2, height: 200)
          //  }
        }else{
           return  CGSize(width: 230, height: 250)
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
