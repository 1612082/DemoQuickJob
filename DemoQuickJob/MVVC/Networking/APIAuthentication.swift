//
//  APIAuthentication.swift
//  DemoQuickJob
//
//  Created by HongDang on 6/5/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import Foundation
import Alamofire
typealias UserSuccessHandel = ((_ model: UserResponse?)->Void)
typealias ProfileSuccessHandel = ((_ model: ProfileResponse?)->Void)
typealias SignupHandel = ((_ model: SignupResponse?)->Void)
typealias UpdateInfoHandel = ((_ model: dataResponse?)->Void)
typealias ForgotHandel = ((_ model: dataResponse?)->Void)
typealias ChangePassHandel = ((_ model: dataResponse?)->Void)

class AuthenAPI {
    
    static var shared = AuthenAPI()
    
    let APILogin = "/login"
    let APIToken = ""
    let urlProfile = "/users/me"
    let urlSignup = "/signup"
    let urlUpdateProfile = "/users/editPersonalInfo"
    let urlForgotPasss = "/forget"
    let urlChangePass = "/users/changePassword"
    func Login(parameters:[String:String]?, headers:HTTPHeaders?, completion:@escaping UserSuccessHandel){
        let url = SERVER + APILogin
        RequestService.shared.AFRequestWith(url: url, method: .post, parameters: parameters, headers: headers, objectType: UserResponse.self) { (result, data, error) in
            if result {
                guard let model = data as? UserResponse else{
                    completion(nil)
                    return
                }
                completion(model)
            } else {
                print(error?.localizedDescription ?? "error at response data")
                completion(nil)
            }
            
        }
    }
    func CheckToken(parameters:[String:String]?, headers:HTTPHeaders?, completion:@escaping UserSuccessHandel){
        let url = SERVER + APIToken
        RequestService.shared.AFRequestWith(url: url, method: .post, parameters: parameters, headers: headers, objectType: UserResponse.self) { (result, data, error) in
            if result {
                guard let model = data as? UserResponse else{
                    completion(nil)
                    return
                }
                completion(model)
            } else {
                print(error?.localizedDescription ?? "error at response data")
                completion(nil)
            }
            
        }
    }
    func AuthProfile(parameters:[String:String]?, headers:HTTPHeaders?, completion:@escaping ProfileSuccessHandel){
        let url = SERVER + urlProfile
        RequestService.shared.AFRequestWith(url: url, method: .get, parameters: parameters, headers: headers, objectType: ProfileResponse.self) { (result, data, error) in
            if result {
                guard let model = data as? ProfileResponse else{
                    completion(nil)
                    return
                }
                completion(model)
            } else {
                print(error?.localizedDescription ?? "error at response data")
                completion(nil)
            }
            
        }
    }
    func Signup(parameters:[String:String]?, headers:HTTPHeaders?, completion:@escaping SignupHandel){
        let url = SERVER + urlSignup
        RequestService.shared.AFRequestWith(url: url, method: .post, parameters: parameters, headers: headers, objectType: SignupResponse.self) { (result, data, error) in
            if result {
                guard let model = data as? SignupResponse else{
                    completion(nil)
                    return
                }
                completion(model)
            } else {
                print(error?.localizedDescription ?? "error at response data")
                completion(nil)
            }
        }
    }
    func UpdateProfile(parameters:[String:String]?, headers:HTTPHeaders?, completion:@escaping UpdateInfoHandel){
        let url = SERVER + urlUpdateProfile
        RequestService.shared.AFRequestWith(url: url, method: .put, parameters: parameters, headers: headers, objectType: dataResponse.self) { (result, data, error) in
            if result {
                guard let model = data as? dataResponse else{
                    completion(nil)
                    return
                }
                completion(model)
            } else {
                print(error?.localizedDescription ?? "error at response data")
                completion(nil)
            }
        }
    }
    func ForgotPasss(parameters:[String:String]?, headers:HTTPHeaders?, completion:@escaping ForgotHandel){
        let url = SERVER + urlForgotPasss
        RequestService.shared.AFRequestWith(url: url, method: .put, parameters: parameters, headers: headers, objectType: dataResponse.self) { (result, data, error) in
            if result {
                guard let model = data as? dataResponse else{
                    completion(nil)
                    return
                }
                completion(model)
            } else {
                print(error?.localizedDescription ?? "error at response data")
                completion(nil)
            }
        }
    }
    func ChangePass(parameters:[String:String]?, headers:HTTPHeaders?, completion:@escaping ChangePassHandel){
        let url = SERVER + urlChangePass
        RequestService.shared.AFRequestWith(url: url, method: .put, parameters: parameters, headers: headers, objectType: dataResponse.self) { (result, data, error) in
            if result {
                guard let model = data as? dataResponse else{
                    completion(nil)
                    return
                }
                completion(model)
            } else {
                print(error?.localizedDescription ?? "error at response data")
                completion(nil)
            }
        }
    }
}

