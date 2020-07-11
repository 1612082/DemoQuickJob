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
    var DistrictID:Int = 1452{
        didSet{}
    }
    var email:String = ""{
        didSet{}
    }
    var password:String = ""{
        didSet{}
    }
    
    func GetDistrict(completion:@escaping GetDistrictlHandel){
        let param = [
            "token": "TokenStaging"
        ]
        APIAddress.shared.GetDistrict(parameters: param, headers: nil) { (model) in
            guard let model = model else {
                completion(nil)
                return
            }
            completion(model)
        }
    }
    func GetWard(completion:@escaping GetWardlHandel){
        let param = [
            "token": "TokenStaging",
            "DistrictID": DistrictID
            ] as [String : Any]
        APIAddress.shared.GetWard(parameters: param, headers: nil) { (model) in
            guard let model = model else {
                completion(nil)
                return
            }
            completion(model)
        }
        
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
}
