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
    
    func GetDistrict(parameters:[String:Any]?, headers:HTTPHeaders?, completion:@escaping GetDistrictlHandel){
        let url = "https://dev-online-gateway.ghn.vn/shiip/public-api/master-data/district"
        
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

    }
    func GetWard(parameters:[String:Any]?, headers:HTTPHeaders?, completion:@escaping GetWardlHandel){
        let url = "https://dev-online-gateway.ghn.vn/shiip/public-api/master-data/ward?district_id"
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
