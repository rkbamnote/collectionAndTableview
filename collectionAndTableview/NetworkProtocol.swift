//
//  NetworkProtocol.swift
//  eNam
//
//  Created by TBS on 5/13/19.
//  Copyright © 2019 micropro. All rights reserved.
//

import Foundation
import Alamofire
import SystemConfiguration

protocol NetworkProtocol {
    func isInternetAvailable() -> Bool
}

extension NetworkProtocol where Self: BaseViewController {
    func isInternetAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
    //fetch Or Send Data without parameter
    func fetchOrSendWithoutParameter(url: String, withCompletionHandler completionHandler: @escaping ((_ result: NSDictionary, _ success: Bool, _ message: String)->Void)) {
        AF.request(url, method: .post, encoding: JSONEncoding.default).responseJSON { (response) in
            
            switch response.result {
            case .success:
                if let JSON = response.value {
                    print(response.value)
                    let result = response.value as! NSDictionary

                    completionHandler(result, true, "successful")
                   
                }
            case .failure( _):
                let res: NSDictionary? = [:]
                completionHandler(res!, false, "Network error!")
            }
        }
    }

    
    //fetch Or Send Data with header
    
//    func fetchOrSendWithWithoutParameter(url: String, withCompletionHandler completionHandler: @escaping ((_ result: NSDictionary, _ success: Bool, _ message: String)->Void)) {
//        AF.request(url, method: .post, encoding: JSONEncoding.default).responseJSON { (response) in
//
//            switch response.result {
//            case .success:
//                if let JSON = response.value {
//                    print(response.value)
//                    let result = response.value as! NSDictionary
//
//                    completionHandler(result, true, "successful")
//
//                }
//            case .failure( _):
//                let res: NSDictionary? = [:]
//                completionHandler(res!, false, "Network error!")
//            }
//        }
//    }
    
    //fetch Or Send Data header
    
    func fetchOrSendWithHeaderData(url: String, Parameter:Parameters, withCompletionHandler completionHandler: @escaping ((_ result: NSDictionary, _ success: Bool, _ message: String)->Void)) {
        AF.request(url, method: .post, parameters: Parameter, encoding: JSONEncoding.default).responseJSON { (response) in
            
            switch response.result {
            case .success:
                if let JSON = response.value {
                    print(response.value)
                    let result = response.value as! NSDictionary

                    completionHandler(result, true, "successful")
                   
                }
            case .failure( _):
                let res: NSDictionary? = [:]
                completionHandler(res!, false, "Network error!")
            }
        }
    }

    
    
    func fetchGetWithHeaderData(url: String, type:String, Headers:HTTPHeaders, withCompletionHandler completionHandler: @escaping ((_ result: NSDictionary, _ success: Bool, _ message: String)->Void)) {
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers:Headers).responseJSON { response in
            print(AF.request)
            switch response.result {
            case .success:
             if let JSON = response.value {
                    let results = JSON as! NSDictionary
                    completionHandler(results, true, "successful")
                }
            case .failure( _):
                let res: NSDictionary? = [:]
                completionHandler(res!, false, "Network error!")
            }
            
        }
    }
}
