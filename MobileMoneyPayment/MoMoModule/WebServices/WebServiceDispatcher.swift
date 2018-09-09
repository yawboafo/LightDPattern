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
            
            // Notifies the manager class  that a particular module Resquest has began
            delegate.momopaymentRequestBegan()
       }
        
    }
    
    static func responseDispatcher(requestType: RequestType,response: JSON,delegate : WebServiceDelegates) {
        
        switch requestType {
            
        case . momorequest :
           
            //Received response Data from WebServicer:  we decode data from Json to a class object
            let momoResponse = try?  JSONDecoder().decode(MoMoResponse.self, from: response.rawData())
            if momoResponse != nil {
                
                //Notifies the Manager class via WebServiceDelegates of the request status
                delegate.momopaymentRequestCompleted(response: momoResponse!)
            }else{
                
                //Notifies the Manager class via WebServiceDelegates of the request errors
                
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
