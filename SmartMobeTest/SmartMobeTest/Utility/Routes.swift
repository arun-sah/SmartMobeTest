//
//  Routes.swift
//  HPCIDBC
//
//  Created by Braindigit on 2/5/18.
//  Copyright © 2018 TechTonne. All rights reserved.
//

import Foundation
import UIKit

struct Routes {
    
    static var mainBoard           = UIStoryboard(name: "Main", bundle: nil)
    
    
    
    static func GetHomeVC() -> UIViewController {
        let HomeVc = mainBoard.instantiateViewController(withIdentifier: "HomeView") as! HomeVC
        return HomeVc
    }
    
}
