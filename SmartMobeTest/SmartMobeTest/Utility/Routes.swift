
import Foundation
import UIKit

struct Routes {
    
    static var mainBoard           = UIStoryboard(name: "Main", bundle: nil)
    static func GetHomeVC() -> UIViewController {
        let HomeVc = mainBoard.instantiateViewController(withIdentifier: "HomeView") as! HomeVC
        return HomeVc
    }
    static func GetHomeDetailVC(img:String,titlletext:String) -> UIViewController {
        let HomeDVc = mainBoard.instantiateViewController(withIdentifier: "HomeDetailViews") as! HomeDetailVC
        HomeDVc.imgurl = img
        HomeDVc.titletext = titlletext
        return HomeDVc
    }
    
}
