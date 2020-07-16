//
//  APIAddress.swift
//  DemoQuickJob
//
//  Created by HongDang on 6/5/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import Foundation
import Alamofire
typealias GetDistrictlHandel = ((_ model: DistrictGHNResponse?)->Void)
typealias GetWardlHandel = ((_ model: WardGHNResponse?)->Void)
typealias GetProvincelHandel = ((_ model: ProvinceGHNResponse?)->Void)

class APIAddress {
    static var shared = APIAddress()
    
    func GetProvince(parameters:[String:Any]?, headers:HTTPHeaders?, completion:@escaping GetProvincelHandel){
        let url = "https://online-gateway.ghn.vn/shiip/public-api/master-data/province"
        
        RequestService.shared.AFRequestWithRawData(url: url, method: .post, parameters: parameters, headers: headers, objectType: ProvinceGHNResponse.self) { (result, data, error) in
            if result {
                guard let model = data as? ProvinceGHNResponse else{
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
    
    func GetDistrict(parameters:[String:Any]?, headers:HTTPHeaders?, completion:@escaping GetDistrictlHandel){
        let url = "https://online-gateway.ghn.vn/shiip/public-api/master-data/district"
        
        RequestService.shared.AFRequestWithRawData(url: url, method: .post, parameters: parameters, headers: headers, objectType: DistrictGHNResponse.self) { (result, data, error) in
            if result {
                guard let model = data as? DistrictGHNResponse else{
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
        let url = "https://online-gateway.ghn.vn/shiip/public-api/master-data/ward?district_id"
        RequestService.shared.AFRequestWithRawData(url: url, method: .post, parameters: parameters, headers: headers, objectType: WardGHNResponse.self) { (result, data, error) in
            if result {
                guard let model = data as? WardGHNResponse else{
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
