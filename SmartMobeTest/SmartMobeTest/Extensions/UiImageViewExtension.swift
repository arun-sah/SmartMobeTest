//
//  UiImageViewExtension.swift
//  Panchakanya
//
//  Created by User on 7/20/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import UIKit


extension UIView {
    @IBInspectable var ignoresInvertColors: Bool {
        get {
            if #available(iOS 11.0, *) {
                return accessibilityIgnoresInvertColors
            }
            return false
        }
        set {
            if #available(iOS 11.0, *) {
                accessibilityIgnoresInvertColors = newValue
            }
        }
    }
}
