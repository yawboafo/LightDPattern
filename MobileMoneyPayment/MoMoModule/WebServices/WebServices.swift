//
//  WebServices.swift
//  MobileMoneyPayment
//
//  Created by Engineer 144 on 08/09/2018.
//  Copyright © 2018 Engineer 144. All rights reserved.
//

import Foundation
import SwiftyJSON
struct URLString {
    var url: String?
    var urlType: RequestType?
}


enum RequestType {
    case momorequest
    
}

class WebServices {
    
    
    static func makeCall(_ urlString: URLString,
                         usingheader header : [String:String],
                         usingHttpMethod httpMethod: String,
                         withParameters parameters: JSON,
                         andRegisterRequestDelegate delegate: WebServiceDelegates!) {
        
        
        guard let url = URL(string: urlString.url!) else {
            print("Error: cannot create URL")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = httpMethod
        urlRequest.allHTTPHeaderFields = header
       
        
        
        
        
        if let jsonData =  try? parameters.rawData(options: .prettyPrinted) {
            urlRequest.httpBody = jsonData
        }
        
        
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
       
        
        
        if delegate != nil{
            
            DispatchQueue.main.async {
                WebServiceDispatcher.resquestBegan(requestType: urlString.urlType!, delegate: delegate)
            }
            
            
            print("REQUEST URL : \(urlString)")
            print("REQUEST METHOD : \(httpMethod)")
            print("REQUEST PAYLOAD : \(String(describing: parameters ))")
            print("REQUEST HEADERS : \(header)")
        }
        
        // make the request
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            
            
            
            print("raw data \(data)")
            print("raw data JSON \(JSON(data))")
            print("response data \(response?.description)")
            print("errror data \(error.debugDescription)")
            
            
            DispatchQueue.main.async {
                WebServiceDispatcher.responseDispatcher(requestType: urlString.urlType!, response: JSON(data as Any), delegate: delegate)
            }
            
            
            
            
        }
        task.resume()
    }
    
    
    
    static func payMomo(withPayload payload: [String:Any], andRegisteredRequestHandler handler: WebServiceDelegates){
        
        let urlString: URLString = {
            var urlString = URLString()
            urlString.url = "https://posystemapi.herokuapp.com/momo/pay"
            urlString.urlType = .momorequest
            
            
            return urlString
        }()
        
        
        let headers: [String:String] = {
            var header = [String:String]()
            header["Content-Type"] = "application/json"
            
            
            return header
        }()
        
        makeCall(urlString, usingheader: headers, usingHttpMethod: "POST", withParameters: JSON(payload), andRegisterRequestDelegate: handler)
        
        
    }
}
