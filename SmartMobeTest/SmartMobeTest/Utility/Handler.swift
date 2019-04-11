//
//  Handler.swift
//  PLInsurance
//
//  Created by Arun kumar Sah on 1/29/19.
//  Copyright © 2019 SourceCode. All rights reserved.
//

import UIKit
import  TTGSnackbar

class Handler: NSObject {
    class func makeToast ( message:String, duration:TimeInterval = 5.0){
        let snackbar = TTGSnackbar.init(message: message, duration: .middle)
        snackbar.messageTextFont = UIFont.systemFont(ofSize: 20)//UIFont.primaryRegularFontOfSize(size: 20)
        snackbar.messageTextAlign = .center
        snackbar.leftMargin = 10
        snackbar.rightMargin = 10
        snackbar.animationType = .slideFromBottomToTop
        snackbar.backgroundColor = UIColor(red:  0/255, green: 0/255, blue: 0/255, alpha: 0.8)//UIColor(colorLiteralRed: 0/255, green: 0/255, blue: 0/255, alpha: 0.3)
        snackbar.show()
    }
}
