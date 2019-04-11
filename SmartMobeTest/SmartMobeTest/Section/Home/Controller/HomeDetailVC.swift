//
//  NewsDetailVC.swift
//  Panchakanya
//
//  Created by Arun kumar Sah on 7/2/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class HomeDetailVC: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var dateLbl: PaddingLabel!
    @IBOutlet weak var newsDetailLbl: PaddingLabel!
    @IBOutlet weak var newsTitle: PaddingLabel!
    var imgurl = ""
    var titletext = ""
    
   
    override func loadView() {
        super.loadView()
       
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        navigationController?.navigationBar.isHidden = true
        // navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        menuBtn.addTarget(self, action: #selector(navLeftButtonTapped), for: .touchUpInside)
         shareBtn.addTarget(self, action: #selector(navRightButtonTapped), for: .touchUpInside)
        shareBtn.isHidden = false
        
        if let imageURL = URL(string:imgurl) {
            image.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "smartmobe"))
        }
        
        newsDetailLbl.text = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,"
       
       
        
        
    }
    override func navLeftButtonTapped() {
            navigationController?.popViewController(animated: true)
        
    }
    override func navRightButtonTapped() {
            let number = 9807753090
            print(number)
            if let url = URL(string: "tel://\(number)") {
                UIApplication.shared.openURL(url)
        }
    }
        
    
    func setdata(){
       
    }
    
}
extension HomeDetailVC:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        print(self.scrollView.contentOffset.y)
        if (self.scrollView.contentOffset.y > 115.0){
            self.navigationController?.navigationBar.isHidden = false
            Util.setupLeftButton("a", parent: self)
            Util.setupRightButton("B", parent: self)
            Util.setTitle("Notice Detail", parent: self)
            shareBtn.isHidden = true
        }else{
            self.navigationController?.navigationBar.isHidden = true
             shareBtn.isHidden = false
        }
    }
    
    
}
