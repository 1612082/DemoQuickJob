//
//  LoginViewModel.swift
//  DemoQuickJob
//
//  Created by HongDang on 6/5/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import Foundation
import Alamofire
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
    var provinceID:Int = 1452{
        didSet{}
    }
    func GetDistrict(completion:@escaping GetDistrictlHandel){
        let headers: HTTPHeaders = [
            "token": "95c31521-c667-11ea-8ce4-7a1dae48308a",
            "Accept": "application/json"
        ]
        let param = [
            "province_id":self.provinceID
        ]
        APIAddress.shared.GetDistrict(parameters: param, headers: headers) { (model) in
            guard let model = model else {
                completion(nil)
                return
            }
            completion(model)
        }
    }
    func GetWard(completion:@escaping GetWardlHandel){
        let headers: HTTPHeaders = [
            "token": "95c31521-c667-11ea-8ce4-7a1dae48308a",
            "Accept": "application/json"
        ]
        let param = [
            "district_id": DistrictID
            ] as [String : Any]
        APIAddress.shared.GetWard(parameters: param, headers: headers) { (model) in
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
