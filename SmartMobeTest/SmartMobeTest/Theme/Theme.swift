
import Foundation
import UIKit


struct Theme {
    
    enum Colors {
        case WhiteColor
        case ViewBackgroundcolor
        case navigationBarColor
        var color: UIColor {
            switch self {
            case .WhiteColor: return UIColor.white
            case .ViewBackgroundcolor: return UIColor(red: 236/255, green: 236/255, blue: 236/255, alpha: 1)
            case .navigationBarColor: return UIColor.blue
            }
        }
    }
    
}

extension UIFont {
    
    class func primaryRegularFontOfSize(size: CGFloat) ->UIFont {
        return UIFont(name: "Roboto-Regular", size: size)!
    }
    
    class func primaryBoldFontOfSize(size: CGFloat) ->UIFont {
        return UIFont(name: "Roboto-Bold", size: size)!
    }
    
    class func primaryLightFontOfSize(size: CGFloat) ->UIFont {
        return UIFont(name: "Roboto-Light", size: size)!
    }
    
}
extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}

public extension UIDevice {
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPhone3,1", "iPhone3,2", "iPhone3,3", "iPhone4,1":
            return "iPhone 4"
            
        case "iPhone5,1", "iPhone5,2", "iPhone5,3", "iPhone5,4", "iPhone6,1", "iPhone6,2", "iPhone8,4":
            return "iPhone 5"
            
        case "iPhone7,2", "iPhone8,1", "iPhone9,1", "iPhone9,3", "iPhone10,1", "iPhone10,4":
            return "iPhone 6,7,8"
            
        case "iPhone7,1", "iPhone8,2", "iPhone9,2", "iPhone9,4", "iPhone10,2", "iPhone10,5":
            return "iPhone Plus"
            
        case "iPhone10,3", "iPhone10,6":
            return "iPhone X"
            
        case "iPad6,3", "iPad6,4":
            return "iPad 9.7 Inch"
            
        case "iPad6,7", "iPad6,8","iPad7,1", "iPad7,2":
            return "iPad 12.9 Inch"
            
        case "iPad7,3", "iPad7,4":
            return "iPad Pro 10.5 Inch"
            
        case "i386", "x86_64":
            return "Simulator"
        default:
            return identifier
        }
    }
}

