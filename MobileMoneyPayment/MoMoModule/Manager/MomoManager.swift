//
//  MomoManager.swift
//  MobileMoneyPayment
//
//  Created by Engineer 144 on 08/09/2018.
//  Copyright © 2018 Engineer 144. All rights reserved.
//

import Foundation
import Disk



protocol MomoManagerDelegate {
    func  momopayBegan()
    func  momopaymentFailed(error: String)
    func  momopaymentFailed()
    func  momopaymentSuccess(response: MoMoResponse)
    func  phoneNumberAuthentication(value: Bool)
}


class MomoManager: NSObject, WebServiceDelegates{
    
    
    var transporter: MomoManagerDelegate?
    
    // WebServiceDelegates protocol methods to track request to payment webservice
    
    func momopaymentRequestBegan() {
        print("payment began")
        transporter?.momopayBegan()
    }
    
    func momopaymentRequestFailedWithError(error: MomoErrorResponse) {
        print("error :  \(error)")
        transporter?.momopaymentFailed(error: error.errorMessage)
    }
    
    func momopaymentRequestCompleted(response: MoMoResponse) {
        print("response : \(response)")
        transporter?.momopaymentSuccess(response: response)
    }
    
    func momopaymentRequestFailedtoProcessResponse() {
        print("Mobile money payment failed ")
        transporter?.momopaymentFailed()
    }
    
    
    
    
    func payByMomo(payload: [String:Any])  {
        
        WebServices.payMomo(withPayload: payload, andRegisteredRequestHandler: self)
        
    }
  
    
    func validDatePhone(phone: String) {
        
        if phone.count == 10 {
            transporter?.phoneNumberAuthentication(value: true)
        }else{
           transporter?.phoneNumberAuthentication(value: false)
        }
    }
    
    
    
    func saveMomoResponse(momo: MoMoResponse){
        
        
        do {
            try  Disk.save(momo, to: .caches, as: "MoMoResponse.json")
        } catch let error as NSError {
            fatalError("""
                Domain: \(error.domain)
                Code: \(error.code)
                Description: \(error.localizedDescription)
                Failure Reason: \(error.localizedFailureReason ?? "")
                Suggestions: \(error.localizedRecoverySuggestion ?? "")
                """)
        }
        
        
    }
    
    func getMomoResponse()->MoMoResponse? {
        
        var items : MoMoResponse?
        
        if let retrievedPosts = try?  Disk.retrieve("MoMoResponse.json", from: .caches, as: MoMoResponse.self) {
            items = retrievedPosts
        }
    
        return items
        
    }
    
}
