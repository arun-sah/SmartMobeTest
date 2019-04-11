//
//  Util.swift
//  HPCIDBC
//
//  Created by Braindigit on 2/12/18.
//  Copyright © 2018 TechTonne. All rights reserved.
//

import UIKit

class Util: NSObject {
    
    class func setupNavigationBar( leftButtonIcon:String? = nil,Tittle:String? = nil, rightButtonIcon:String? = nil,parent:UIViewController){
        Util.setTitle(Tittle, parent: parent)
        Util.setupRightButton(rightButtonIcon, parent: parent)
        Util.setupLeftButton(leftButtonIcon, parent: parent)
        
    }
    
    class func setTitle(_ title:String?, parent:UIViewController){
        guard let navTitle = title else {
            return
        }
        
//        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: UIFont.primaryRegularFontOfSize(size: 20),NSAttributedString.Key.foregroundColor : UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20),NSAttributedString.Key.foregroundColor : UIColor.white]
        parent.navigationItem.title = navTitle
    }
    
    class func setupRightButton(_ buttonIcon:String? = nil, parent:UIViewController){
        
        guard let icon = buttonIcon else{
            return
        }
        let btnMenu = UIButton();
        btnMenu.frame = CGRect(x: 0, y: 0, width: 27, height: 40)
        btnMenu.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btnMenu.titleLabel?.textAlignment = .right
        btnMenu.setTitle(icon, for: UIControl.State())
        btnMenu.titleLabel?.textColor = UIColor.white
        btnMenu.setTitleColor(UIColor.white, for: UIControl.State())
        btnMenu.addTarget(parent, action: #selector(parent.navRightButtonTapped), for: .touchUpInside)
        let rightBarButtonItem = UIBarButtonItem(customView: btnMenu)
        parent.navigationItem.rightBarButtonItem = rightBarButtonItem
        
        
    }
    class func setupLeftButton(_ buttonIcon:String? = nil, parent:UIViewController){
        
        guard let icon = buttonIcon else{
            return
        }
        
        let btnMenu = UIButton();
        btnMenu.frame = CGRect(x: 0, y: 0, width: 27, height: 40)
        btnMenu.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btnMenu.titleLabel?.textAlignment = .left
        btnMenu.setTitle(icon, for: UIControl.State())
        btnMenu.setTitleColor(UIColor.white, for: UIControl.State())
        btnMenu.addTarget(parent, action: #selector(parent.navLeftButtonTapped), for: .touchUpInside)
        let leftBarButtonItem = UIBarButtonItem(customView: btnMenu)
        parent.navigationItem.leftBarButtonItem = leftBarButtonItem
        
        
    }
}
extension UIViewController{
    @objc func navRightButtonTapped(){ }
    @objc func navLeftButtonTapped(){ }
}

