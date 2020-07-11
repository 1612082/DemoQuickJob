//
//  APIJobDetail.swift
//  DemoQuickJob
//
//  Created by HongDang on 6/1/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import Foundation
import Alamofire

typealias GetJobDetailHandel = ((_ model: JobDetailResponse?)->Void)

class APIJobDetail {
    static var shared = APIJobDetail()
    
    let URLJobDetail = "/getJobByID/"
    
    func GetDetailJob(_ ulr:String,parameters:[String:String]?, headers:HTTPHeaders?, completion:@escaping GetJobDetailHandel){
        let url = SERVER + URLJobDetail + ulr
        RequestService.shared.AFRequestWith(url: url, method: .get, parameters: parameters, headers: nil, objectType: JobDetailResponse.self) { (result, data, error) in
        if result {
                guard let model = data as? JobDetailResponse else{
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
