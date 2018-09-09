//
//  WebServiceDispatcher.swift
//  MobileMoneyPayment
//
//  Created by Engineer 144 on 08/09/2018.
//  Copyright © 2018 Engineer 144. All rights reserved.
//

import Foundation
import SwiftyJSON

class WebServiceDispatcher: NSObject {
    
    
    static func resquestBegan(requestType: RequestType,delegate: WebServiceDelegates){
        
        switch requestType {
        case .momorequest:
            
            delegate.momopaymentRequestBegan()
       }
        
    }
    
    static func responseDispatcher(requestType: RequestType,response: JSON,delegate : WebServiceDelegates) {
        
        switch requestType {
            
        case . momorequest :
           
            //Received response Data from WebService:  we decode data from json to a class object and save in Cache
            let momoResponse = try?  JSONDecoder().decode(MoMoResponse.self, from: response.rawData())
            if momoResponse != nil {
                
                delegate.momopaymentRequestCompleted(response: momoResponse!)
            }else{
                let errorResponse = try?  JSONDecoder().decode(MomoErrorResponse.self, from: response.rawData())
                if errorResponse != nil {
                    delegate.momopaymentRequestFailedWithError(error: errorResponse!)
                }else{
                    delegate.momopaymentRequestFailedtoProcessResponse()
                }
                
            }
            
        }
        
    }
    
}
