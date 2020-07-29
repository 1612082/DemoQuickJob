//
//  LoginViewModel.swift
//  DemoQuickJob
//
//  Created by HongDang on 6/5/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import Foundation
class LobbyViewModel {
    var idLobby:String = ""{
        didSet{}
    }
    
    var email:String = ""{
        didSet{}
    }
    var password:String = ""{
        didSet{}
    }
    
    
    func Login(completion:@escaping UserSuccessHandel){
        let param = [
            "email": self.email,
            "password": self.password
        ]
        AuthenAPI.shared.Login(parameters: param, headers: nil) { (model) in
            guard let model = model else {
                completion(nil)
                return
            }
            completion(model)
        }
    }
    func ForgotPass(completion:@escaping ForgotHandel){
        let param = [
            "email": self.email
        ]
        AuthenAPI.shared.ForgotPasss(parameters: param, headers: nil) { (model) in
            guard let model = model else {
                completion(nil)
                return
            }
            completion(model)
        }
    }
}
