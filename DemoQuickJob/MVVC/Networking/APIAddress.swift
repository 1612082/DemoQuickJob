//
//  APIAddress.swift
//  DemoQuickJob
//
//  Created by HongDang on 6/5/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import Foundation
import Alamofire
typealias GetDistrictlHandel = ((_ model: DistrictResponse?)->Void)
typealias GetWardlHandel = ((_ model: WardResponse?)->Void)

class APIAddress {
    static var shared = APIAddress()
    
    func GetDistrict(parameters:[String:String]?, headers:HTTPHeaders?, completion:@escaping GetDistrictlHandel){
        let url = "https://dev-online-gateway.ghn.vn/apiv3-api/api/v1/apiv3/GetDistricts"
        
        RequestService.shared.AFRequestWithRawData(url: url, method: .post, parameters: parameters, headers: nil, objectType: DistrictResponse.self) { (result, data, error) in
            if result {
                guard let model = data as? DistrictResponse else{
                    completion(nil)
                    return
                }
                completion(model)
            } else {
                print(error?.localizedDescription ?? "error at response data")
                completion(nil)
            }
        }

//        guard let url = URL(string: urlString) else {return}
//        var request        = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        do {
//            request.httpBody   = try JSONSerialization.data(withJSONObject: param)
//        } catch let error {
//            print("Error : \(error.localizedDescription)")
//        }
//        AF.request(request).response { (reponse) in
//            switch (reponse.result){
//            case .success(let data):
//                do {
//
//
//                    let json = try JSONDecoder.init().decode(DistrictResponse.self, from: data!)
//                    // tra gia ra ben ngoai ham bang completion handeler
//                    print(json.msg)
////                    completion(true, json, nil)
//                } catch {
//                    //parse json khong dc
//                    print("parse json khong dc")
////                    completion (false,data,nil)
//                }
//
//            case .failure(let error):
//                print("res khong tra ve dc")
////                completion(false,nil,error)
//            }
//        }
    }
    func GetWard(parameters:[String:Any]?, headers:HTTPHeaders?, completion:@escaping GetWardlHandel){
        let url = "https://dev-online-gateway.ghn.vn/apiv3-api/api/v1/apiv3/GetWards"
        RequestService.shared.AFRequestWithRawData(url: url, method: .post, parameters: parameters, headers: nil, objectType: WardResponse.self) { (result, data, error) in
            if result {
                guard let model = data as? WardResponse else{
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
