//
//  SignupViewModel.swift
//  DemoQuickJob
//
//  Created by HongDang on 6/5/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import Foundation
import  UIKit

class SignupViewModel {
    var email:String = ""{
        didSet{}
    }
    var password:String = ""{
        didSet{}
    }
    var fullname:String = ""{
        didSet{}
    }
    var dob:String = ""{
        didSet{}
    }
    var dial:String = ""{
        didSet{}
    }
    var isBusinessUser:String = ""{
        didSet{}
    }
    var gender:String = ""{
        didSet{}
    }
    var address:String = ""{
        didSet{}
    }
    var confirm:String = ""{
        didSet{}
    }
    
    func setupBtn(_ btn:UIButton){
        btn.layer.borderWidth = 3
        btn.layer.borderColor = UIColor.white.cgColor
        btn.layer.cornerRadius = 20
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func signup(completion:@escaping SignupHandel){
        let param = [
            "email":self.email,
            "password":self.password,
            "fullname":self.fullname,
            "dob":self.dob,
            "dial":self.dial,
            "isBusinessUser":"0",
            "gender":self.gender,
            "address":self.address,
            "confirm":self.confirm
        ]
        AuthenAPI.shared.Signup(parameters: param, headers: nil) { (model) in
            guard let model = model else {
                completion(nil)
                return
            }
            completion(model)
        }
    }
    func passData(_ data:USERSIGNUP){
        self.email = data.email
        self.password = data.password
        self.fullname = data.fullname
        self.dob = data.dob
        self.dial = data.dial
        self.gender = "\(data.gender)"
        self.address = data.addr
        self.confirm = data.confirm
    }
    func showAlert(_ s:String, _ alert:UIAlertController){
        alert.message = s
        // change to desired number of seconds (in this case 5 seconds)
        let when = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: when){
            // your code with delay
            alert.dismiss(animated: true, completion: nil)
        }
    }
}
