//
//  APIMomo.swift
//  DemoQuickJob
//
//  Created by HongDang on 7/10/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import Foundation
import  Alamofire
public struct ReponseMomo:Codable {
    
    public var status : Int
    public var message : String
    public var amount : Int
    public var transid : String
    public var signature : String
    
}
public struct HashMomoResponse:Codable {
    
    public var data : String
    public var code : String
    public var message : String
    
}
public struct SignatureMomoResponse:Codable {
    
    public var data : String
    public var code : String
    public var message : String
    
}
public struct ConfirmMomoResponse:Codable {

//        public var data : MomoConfirm
        public var message : String
//        public var signature : String
        public var status : Int
        
}
public struct MomoConfirm:Codable {

        public var amount : Int
        public var momoTransId : String
        public var partnerCode : String
        public var partnerRefId : String
        
}
typealias GetHashHandel = ((_ model: HashMomoResponse?)->Void)
typealias GetMomoConfirmHandel = ((_ model: ConfirmMomoResponse?)->Void)
typealias GetSignHandel = ((_ model: SignatureMomoResponse?)->Void)
typealias AcceptApplicantHandel = ((_ model: dataResponse?)->Void)


struct APIMomo {
    static var shared = APIMomo()
    func GetHash(parameters:[String:Any]?, headers:HTTPHeaders?, completion:@escaping GetHashHandel){
        let url = "https://f2l-client.herokuapp.com/getHashMoMoInMobile"
        RequestService.shared.AFRequestWithRawData(url: url, method: .post, parameters: parameters, headers: nil, objectType: HashMomoResponse.self) { (result, data, error) in
            if result {
                guard let model = data as? HashMomoResponse else{
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
    func ConfirmMomo(parameters:[String:Any]?, headers:HTTPHeaders?, completion:@escaping GetMomoConfirmHandel){
        let url = "https://test-payment.momo.vn/pay/confirm"
        RequestService.shared.AFRequestWithRawData(url: url, method: .post, parameters: parameters, headers: headers, objectType: ConfirmMomoResponse.self) { (result, data, error) in
            if result {
                guard let model = data as? ConfirmMomoResponse else{
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
    func GetSign(parameters:[String:Any]?, headers:HTTPHeaders?, completion:@escaping GetSignHandel){
        let url = "https://f2l-client.herokuapp.com/getSignatureMoMoInMobile"
        RequestService.shared.AFRequestWithRawData(url: url, method: .post, parameters: parameters, headers: headers, objectType: SignatureMomoResponse.self) { (result, data, error) in
            if result {
                guard let model = data as? SignatureMomoResponse else{
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
    func AcceptApplicant(parameters:[String:Any]?, headers:HTTPHeaders?, completion:@escaping AcceptApplicantHandel){
        let url = "https://f2l-client.herokuapp.com/applicants/acceptApplicant"
        RequestService.shared.AFRequestWithRawData(url: url, method: .post, parameters: parameters, headers: headers, objectType: dataResponse.self) { (result, data, error) in
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
