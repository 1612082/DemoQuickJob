//
//  APIReviewReport.swift
//  DemoQuickJob
//
//  Created by HongDang on 7/16/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import Foundation
import Alamofire
typealias ReviewReportHandel = ((_ model: dataResponse?)->Void)

struct APIReviewReport{
    
    static var shared = APIReviewReport()
    
    func reviewFromEmployee(parameters:[String:Any]?, headers:HTTPHeaders?, completion:@escaping ReviewReportHandel){
        let url = "https://f2l-client.herokuapp.com/accepted/reviewFromEmployee"
        RequestService.shared.AFRequestWithRawData(url: url, method: .post, parameters: parameters, headers: nil, objectType: dataResponse.self) { (result, data, error) in
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
    func reviewFromEmployer(parameters:[String:Any]?, headers:HTTPHeaders?, completion:@escaping ReviewReportHandel){
        let url = "https://f2l-client.herokuapp.com/accepted/reviewFromEmployer"
        RequestService.shared.AFRequestWithRawData(url: url, method: .post, parameters: parameters, headers: nil, objectType: dataResponse.self) { (result, data, error) in
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
    func report(parameters:[String:Any]?, headers:HTTPHeaders?, completion:@escaping ReviewReportHandel){
        let url = "https://f2l-client.herokuapp.com/users/addReport"
        RequestService.shared.AFRequestWithRawData(url: url, method: .post, parameters: parameters, headers: nil, objectType: dataResponse.self) { (result, data, error) in
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
