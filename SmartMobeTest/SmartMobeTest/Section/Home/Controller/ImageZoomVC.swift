//
//  ImageZoomVC.swift
//  SmartMobeTest
//
//  Created by Arun kumar Sah on 4/11/19.
//  Copyright © 2019 Arun kumar Sah. All rights reserved.
//

import UIKit

class ImageZoomVC: UIViewController,UIScrollViewDelegate {
    
    var contentScrollView: UIScrollView!
    var imageMainView     = UIView()
    var zoomedImageView   = UIImageView()
    var closeIcon         = UIButton()
    var imgPath = ""
    
    override func loadView() {
        super.loadView()
        imageMainView = UIView()
        imageMainView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        imageMainView.ignoresInvertColors = true
        self.view.addSubview(imageMainView)
        
        self.contentScrollView = UIScrollView()
        self.contentScrollView.keyboardDismissMode = .interactive
        self.contentScrollView.alwaysBounceVertical = false
        self.contentScrollView.alwaysBounceHorizontal = false
        contentScrollView.bounces = false
        self.contentScrollView.zoomScale = 1.0
        self.contentScrollView.maximumZoomScale = 4.0
        self.contentScrollView.minimumZoomScale = 1.0
        self.contentScrollView.delegate = self as! UIScrollViewDelegate
        imageMainView.addSubview(self.contentScrollView)
        
        zoomedImageView = UIImageView()
        if let imageURL = URL(string:imgPath) {
            zoomedImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "user"))
        }
        zoomedImageView.contentMode = .scaleToFill
        imageMainView.addSubview(zoomedImageView)
        contentScrollView.addSubview(zoomedImageView)
        
        closeIcon = UIButton()
        closeIcon.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        closeIcon.setTitle("\u{2716}", for: .normal)
        closeIcon.setTitleColor(UIColor.white, for: .normal)
        imageMainView.addSubview(closeIcon)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        closeIcon.addTarget(self, action: #selector(self.handleClose), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        var xOffset:CGFloat = 0
        let viewWidth:CGFloat = self.view.frame.width - (2 * xOffset)
        let viewHeight:CGFloat = 440
        var yOffset:CGFloat = (self.view.frame.height - viewHeight)/3
        
        contentScrollView.frame = CGRect(x: xOffset, y: 60, width: self.view.frame.width, height: 630)
        
        imageMainView.frame = CGRect(x: xOffset, y: 30, width: viewWidth, height:viewHeight)
        
        xOffset = viewWidth - 40
        yOffset = 10
        closeIcon.frame = CGRect(x: xOffset, y: yOffset, width: 40, height: 40)
        
        xOffset = 0
        yOffset = 0
        zoomedImageView.frame = CGRect(x: xOffset, y: yOffset, width: viewWidth, height: 630)
        
        contentScrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func handleClose(){
        self.dismiss(animated: false) {
        }
        
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return zoomedImageView
    }
}

