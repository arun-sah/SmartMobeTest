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
    
    @IBOutlet weak var ImagetransparentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var CallBtnIcon: UIButton!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var dateLbl: PaddingLabel!
    @IBOutlet weak var DetailLbl: PaddingLabel!
    @IBOutlet weak var NavigationTittleLbl: PaddingLabel!
    @IBOutlet weak var HTitle: PaddingLabel!
    var imgurl = ""
    var titletext = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        navigationController?.navigationBar.isHidden = true
        // navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        menuBtn.addTarget(self, action: #selector(navLeftButtonTapped), for: .touchUpInside)
         CallBtnIcon.addTarget(self, action: #selector(navRightButtonTapped), for: .touchUpInside)
        CallBtnIcon.isHidden = false
        menuBtn.setTitle("\u{2190}", for: .normal)
        CallBtnIcon.setTitle("\u{1F4DE}", for: .normal)
        CallBtnIcon.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        if (UIDevice.current.model == "iPhone"){
            CallBtnIcon.layer.cornerRadius = 25
            menuBtn.layer.cornerRadius = 25
        }
        else{
            CallBtnIcon.layer.cornerRadius = 40
            menuBtn.layer.cornerRadius = 40
        }
        
        let tap = UITapGestureRecognizer()
        ImagetransparentView.isUserInteractionEnabled = true
        tap.addTarget(self, action: #selector(self.UserDetailImageZoom(tapGesture:)))
        ImagetransparentView.addGestureRecognizer(tap)
        
        let tapLbl = UITapGestureRecognizer()
        tapLbl.addTarget(self, action: #selector(self.UserDetailImageZoom(tapGesture:)))
        NavigationTittleLbl.isUserInteractionEnabled = true
        NavigationTittleLbl.addGestureRecognizer(tapLbl)
        
        if let imageURL = URL(string:imgurl) {
            image.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "smartmobe"))
        }
        
        NavigationTittleLbl.text = titletext
        
        DetailLbl.text = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget m dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed conm dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget sequat, leo eget bibendum sodales, augue velit cursus nunc,"
       
       
        
        
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
        
    @objc func UserDetailImageZoom(tapGesture: UITapGestureRecognizer) {
        let zoom = ImageZoomVC()
        zoom.imgPath = imgurl
        zoom.modalPresentationStyle = .custom
        self.navigationController?.present(zoom, animated: true, completion: nil)
    }
}
extension HomeDetailVC:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        print(self.scrollView.contentOffset.y)
        if (self.scrollView.contentOffset.y > 115.0){
            self.navigationController?.navigationBar.isHidden = false
            Util.setupLeftButton("\u{2190}", parent: self)
            Util.setupRightButton("\u{1F4DE}", parent: self)
            Util.setTitle(titletext, parent: self)
            CallBtnIcon.isHidden = true
        }else{
            self.navigationController?.navigationBar.isHidden = true
             CallBtnIcon.isHidden = false
        }
    }
    
    
}
