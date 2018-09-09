//
//  WebServiceDelegates.swift
//  MobileMoneyPayment
//
//  Created by Engineer 144 on 08/09/2018.
//  Copyright © 2018 Engineer 144. All rights reserved.
//

import Foundation

import SwiftyJSON
import Disk


protocol WebServiceDelegates {
    
    func momopaymentRequestBegan()
    func momopaymentRequestFailedWithError(error: MomoErrorResponse )
    func momopaymentRequestCompleted(response: MoMoResponse)
    func momopaymentRequestFailedtoProcessResponse()
    
    
}
