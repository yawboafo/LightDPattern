//
//  MomoPaymentViewController.swift
//  MobileMoneyPayment
//
//  Created by Engineer 144 on 08/09/2018.
//  Copyright © 2018 Engineer 144. All rights reserved.
//

import Foundation
import  UIKit
import SnapKit
class MomoPaymentViewController: UIViewController,MomoManagerDelegate{
    
    
    func momopayBegan() {
        //Notify the view that momo payment request began
    }
    
    func momopaymentFailed(error: String) {
        //Notify the view that momo payment request failed with a known error
    }
    
    func momopaymentFailed() {
         //Notify the view that momo payment request failed with a unknown error
    }
    
    func momopaymentSuccess(response: MoMoResponse) {
         //Notify the view that momo payment request was successful
    }
    
    func phoneNumberAuthentication(value: Bool) {
        //Notify the User of phone number verification status
        
        if value {
            
            let params : [String:Any] = [
                
                "phone" : phoneNumberField.text!,
                "amount": amountField.text!
            ]
            
             momoManager.payByMomo(payload: params)
        }else {
            
            //phone number verification failed
            
        }
    }
    
    
    
    let momoManager = MomoManager()
    
    override func viewDidLoad() {
        
        self.title = "Momo Payment"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(phoneNumberField)
        self.view.addSubview(amountField)
        self.view.addSubview(payButton)
        setUpConstrains()
        
        momoManager.transporter = self
        
    }
    
    
    
    
    
    func setUpConstrains(){
        
        
        //Defind constains to layout views
        
        self.phoneNumberField.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset((self.navigationController?.navigationBar.frame.height)! + 80)
            make.height.equalTo(40)
            make.width.equalToSuperview().multipliedBy(0.8)
        }
        
        
        self.amountField.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(phoneNumberField.snp.bottom).offset(20)
            make.height.equalTo(40)
            make.width.equalToSuperview().multipliedBy(0.8)
        }
        
        
        self.payButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.amountField.snp.bottom).offset(20)
            make.height.equalTo(50)
            make.width.equalToSuperview().multipliedBy(0.8)
        }
    }
    
    
    
    //Define PhoneNumber Field
    
    var phoneNumberField : UITextField = {
        let view = UITextField()
        view.placeholder = "Enter Phone number"
        view.keyboardType = .phonePad
        return view
        
    }()
    
    
    var amountField : UITextField = {
        
        let view = UITextField()
        view.placeholder = "Enter Amount"
        view.keyboardType = .numberPad
        return view
        
    }()
    
    
    let payButton: UIButton = {
        let view = UIButton()
        view.setTitle("Pay", for: .normal)
        
        view.backgroundColor = UIColor.gray
        view.layer.cornerRadius = 5
        view.addTarget(self, action: #selector(payMoMo), for: .touchUpInside)
        
        return view
    }()
    
    @objc func payMoMo(){
        
     
        
        momoManager.validDatePhone(phone: phoneNumberField.text!)
        
        
       
        
        
    }
}
