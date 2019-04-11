//
//  HomeCell.swift
//  SmartMobeTest
//
//  Created by Arun kumar Sah on 4/11/19.
//  Copyright © 2019 Arun kumar Sah. All rights reserved.
//

import UIKit
import SDWebImage

class HomeCell: UICollectionViewCell {
    
    @IBOutlet weak var CellImage: UIImageView!
    @IBOutlet weak var CellbackGround: UIView!
    
    func configureCell(celldata:HomeModel) {
        if let imageURL = URL(string:celldata.url!) {
            CellImage.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "smartmobe"))
        }
    }
}
