//
//  MoMoResponse.swift
//  MobileMoneyPayment
//
//  Created by Engineer 144 on 08/09/2018.
//  Copyright © 2018 Engineer 144. All rights reserved.
//

import Foundation



struct MoMoResponse: Codable {
    let code, status, message: String
    let momo: Momo
}








struct MomoErrorResponse: Codable {
    let code, status, errorMessage: String
}

