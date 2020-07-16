//
//  GetAddrViewModel.swift
//  DemoQuickJob
//
//  Created by TPS on 7/16/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import Foundation
import Alamofire
class GetAddrViewModel {
    var districtID:Int = 1452{
        didSet{}
    }
    var provinceID:Int = 1452{
        didSet{}
    }
    func GetProvince(completion:@escaping GetProvincelHandel){
        let headers: HTTPHeaders = [
            "token": "95c31521-c667-11ea-8ce4-7a1dae48308a",
            "Accept": "application/json"
        ]

        APIAddress.shared.GetProvince(parameters: nil, headers: headers) { (model) in
            guard let model = model else {
                completion(nil)
                return
            }
            completion(model)
        }
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
            "district_id": districtID
            ] as [String : Any]
        APIAddress.shared.GetWard(parameters: param, headers: headers) { (model) in
            guard let model = model else {
                completion(nil)
                return
            }
            completion(model)
        }
        
    }
}
