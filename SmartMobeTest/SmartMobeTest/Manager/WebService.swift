
import UIKit
import Reachability
import Foundation
import Alamofire
import SwiftyJSON
import SystemConfiguration

//test url
let bURL = "http://www.splashbase.co"
let baseURL = bURL+"/api/v1/"


enum APIConfig{
    case GetProducts
    
    func urlPath() -> String {
        
        switch self{
            
        case .GetProducts:
            return baseURL+"images/latest"
        }
    }
}

class WebService: NSObject {

    class func GetAt(
        url:String,
        parameters: [String: AnyObject]? = nil,
        successBlock:@escaping ((_ response:JSON?) -> Void),
        failureBlock:@escaping ((_ message:String) -> Void)){
        if Reachablity.isNetworkReachable(){
            Alamofire.request(
                url,
                method: .get,
                parameters: parameters,
                encoding: JSONEncoding.default,
                headers: nil)
                //.validate(contentType: ["application/json"])
                .responseJSON { response in
                    
                    switch(response.result){
                        
                        
                    case .success:
                        let responcedata = response.result.value
                        print(responcedata)
                        let responcejson = JSON(responcedata!)
                        successBlock(responcejson)
                    case .failure(let error):
                        failureBlock(error as! String)
                        break
                    }
            }
        }else{
            failureBlock("no internet connection")
        }
    }
    
}





class Reachablity{
    
    class func isNetworkReachable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
}

