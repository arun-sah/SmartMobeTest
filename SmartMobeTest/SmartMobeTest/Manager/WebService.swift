//
//  WebService.swift
//  PLInsurance
//
//  Created by mac on 3/12/19.
//  Copyright © 2019 SourceCode. All rights reserved.
//
//
//  WebService.swift
//  Nyef
//
//  Created by Arun kumar Sah on 6/10/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//


import UIKit
import Reachability
import Foundation
import Alamofire
import SwiftyJSON
import SystemConfiguration

//test url
let bURL = "http://ops.sourcecode.com.np"
let baseURL = bURL+"/api/v1/"
let PLheader:[String:AnyObject] = [ "secretKey":"PLOPS$#@1"as AnyObject]

enum APIConfig{
    case GetProducts
    
    func urlPath() -> String {
        
        switch self{
            
        case .GetProducts:
            return baseURL+"GetProducts"
        }
    }
}

class WebService: NSObject {

    class func postAt(
        url:String,
        parameters: [String: AnyObject]? = nil,
        successBlock:@escaping ((_ response:JSON?) -> Void),
        failureBlock:@escaping ((_ message:String) -> Void)){
        if Reachablity.isNetworkReachable(){
            Alamofire.request(
                url,
                method: .post,
                parameters: parameters,
                encoding: JSONEncoding.default,
                headers:  PLheader as? HTTPHeaders)
                //.validate(contentType: ["application/json"])
                .responseJSON { response in
                    print("URl:\(url)\n header:\(PLheader)\nparameters:-\(String(describing: parameters))\nResponce:-\(response)")
                    switch(response.result){
                        
                    case .success:
                        let responcedata = response.result.value
                        print(responcedata)
                        let responcejson = JSON(responcedata!)
                        print(responcejson)
                        let Responcedata = responcejson["data"]
                        let responcecode = responcejson["code"]
                         let responcMessage = responcejson["message"].stringValue
                        switch responcecode{
                        case 200:
                            successBlock(Responcedata)
                            break
                            
                        case 401:
                            failureBlock(responcMessage)
                        case 500:
                             failureBlock(responcMessage)
                        case 502:
                             failureBlock(responcMessage)
                        
                        default:
                            failureBlock(responcMessage)
                            print("error-----")
                        }
                        break
                    case .failure(let error):
                        failureBlock("error occured")
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

