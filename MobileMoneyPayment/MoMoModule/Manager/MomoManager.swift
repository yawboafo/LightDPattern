//
//  MomoManager.swift
//  MobileMoneyPayment
//
//  Created by Engineer 144 on 08/09/2018.
//  Copyright © 2018 Engineer 144. All rights reserved.
//

import Foundation
import Disk
class MomoManager{
    
    
  
    
    
    
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
