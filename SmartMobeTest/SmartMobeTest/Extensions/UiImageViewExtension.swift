
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


extension Array {
    func contains<T>(obj: T) -> Bool where T : Equatable {
        return self.filter({$0 as? T == obj}).count > 0
    }
}

extension Array where Element:Equatable {
    func removeDuplicates() -> [Element] {
        var result = [Element]()
        
        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }
        
        return result
    }
}
