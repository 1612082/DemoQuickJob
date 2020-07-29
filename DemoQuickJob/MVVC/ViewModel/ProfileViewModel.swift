//
//  ProfileViewModel.swift
//  DemoQuickJob
//
//  Created by HongDang on 6/8/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import Foundation
import Alamofire
class ProfileViewModel {
    var token:String = ""{
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
    var address:String = ""{
        didSet{}
    }
    var gender:Int = 1{
        didSet{}
    }
    var avatarImg:String = ""{
        didSet{}
    }
    var portrait:String = ""{
        didSet{}
    }
    var frontIdPaper:String = ""{
        didSet{}
    }
    var backIdPaper:String = ""{
        didSet{}
    }
    var identity:String = ""{
        didSet{}
    }
    var old_password:String = ""{
        didSet{}
    }
    var new_password:String = ""{
        didSet{}
    }
    func GetProfile(completion:@escaping ProfileSuccessHandel){
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(self.token)",
            "Accept": "application/json"
        ]
        AuthenAPI.shared.AuthProfile(parameters: [:], headers: headers) { (model) in
            guard let model = model else {
                completion(nil)
                return
            }
            completion(model)
        }
    }
    func UpdateInfoUser(completion:@escaping UpdateInfoHandel){
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(self.token)",
            "Accept": "application/json"
        ]
        let param = [
            "fullname": self.fullname,
            "dob": self.dob,
            "dial": self.dial,
            "address": self.address,
            "gender": "\(self.gender)",
            "avatarImg": self.avatarImg
        ]
        AuthenAPI.shared.UpdateProfile(parameters: param, headers: headers) { (model) in
            guard let model = model else {
                completion(nil)
                return
            }
            completion(model)
        }
    }
    func AuthenIDCard(completion:@escaping UpdateInfoHandel){
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(self.token)",
            "Accept": "application/json"
        ]
        let param = [
            "identity": self.identity,
            "portrait":self.portrait,
            "frontIdPaper": self.frontIdPaper,
            "backIdPaper":self.backIdPaper
        ]
        AuthenAPI.shared.UpdateProfile(parameters: param, headers: headers) { (model) in
            guard let model = model else {
                completion(nil)
                return
            }
            completion(model)
        }
    }
    func changePass(completion:@escaping ChangePassHandel){
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(self.token)",
            "Accept": "application/json"
        ]
        let param = [
            "old_password": self.old_password,
            "new_password": self.new_password
        ]
        AuthenAPI.shared.ChangePass(parameters: param, headers: headers) { (model) in
            guard let model = model else {
                completion(nil)
                return
            }
            completion(model)
        }
    }
}
