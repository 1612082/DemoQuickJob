//
//  MomoViewModel.swift
//  DemoQuickJob
//
//  Created by HongDang on 7/10/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import Foundation
import Alamofire

class MomoViewModel{
    var partnerRefId:String = ""{
        didSet{}
    }
    var amount:Int = 0{
        didSet{
            
        }
    }
    var momoTransId:String = ""{
        didSet{}
    }
    var signature:String = ""{
        didSet{}
    }
    var customerNumber:String = ""{
        didSet{}
    }
    var requestId:Int = 0{
        didSet{}
    }
    var idApplicant:String = ""{
        didSet{}
    }
    func GetHash(completion:@escaping GetHashHandel){
        let params = [
            "partnerRefId": self.partnerRefId as String,
            "amount": self.amount
            ] as [String:Any]
        APIMomo.shared.GetHash(parameters: params, headers: nil) { (model) in
            guard let model = model else {
                completion(nil)
                return
            }
            completion(model)
        }
    }
    func GetSign(completion:@escaping GetSignHandel){
        let params = [
            "partnerRefId": self.partnerRefId as String,
            "requestId":"\(self.requestId)",
            "momoTransId": self.momoTransId
            ] as [String:Any]
        APIMomo.shared.GetSign(parameters: params, headers: nil) { (model) in
            guard let model = model else {
                completion(nil)
                return
            }
            completion(model)
        }
    }
    func Confirm(completion:@escaping GetMomoConfirmHandel){
        let params = [
        "partnerCode": "MOMODJRT20200622",
        "partnerRefId": self.partnerRefId as String,
        "requestType": "capture",
        "requestId": "\(self.requestId)",
        "momoTransId": self.momoTransId,
        "signature": self.signature,
        "customerNumber": self.customerNumber
        ] as [String:Any]
        
        APIMomo.shared.ConfirmMomo(parameters: params, headers: nil) { (model) in
            guard let model = model else {
                completion(nil)
                return
            }
            completion(model)
        }
    }
    func AcceptApplicant(completion:@escaping AcceptApplicantHandel){
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Accept": "application/json"
        ]
        let params = [
            "id_applicant": self.idApplicant
        ] as [String:Any]
        APIMomo.shared.AcceptApplicant(parameters: params, headers: headers) { (model) in
            guard let model = model else {
                completion(nil)
                return
            }
            completion(model)
        }
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
