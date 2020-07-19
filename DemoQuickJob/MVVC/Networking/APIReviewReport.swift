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
typealias GetReviewHandel = ((_ model: ReviewReponse?)->Void)
typealias GetReportHandel = ((_ model: ReportReponse?)->Void)
struct APIReviewReport{
    
    static var shared = APIReviewReport()
    
    func reviewFromEmployee(parameters:[String:Any]?, headers:HTTPHeaders?, completion:@escaping ReviewReportHandel){
        let url = "\(SERVER)/accepted/reviewFromEmployee"
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
    func reviewFromEmployer(parameters:[String:Any]?, headers:HTTPHeaders?, completion:@escaping ReviewReportHandel){
        let url = "\(SERVER)/accepted/reviewFromEmployer"
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
    func report(parameters:[String:Any]?, headers:HTTPHeaders?, completion:@escaping ReviewReportHandel){
        let url = "\(SERVER)/users/addReport"
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
    func GetReview(parameters:[String:Any]?, headers:HTTPHeaders?, completion:@escaping GetReviewHandel){
        let url = "\(SERVER)/getDetailReview"
        RequestService.shared.AFRequestWithRawData(url: url, method: .post, parameters: parameters, headers: headers, objectType: ReviewReponse.self) { (result, data, error) in
            if result {
                guard let model = data as? ReviewReponse else{
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
    func GetReport(parameters:[String:Any]?, headers:HTTPHeaders?, completion:@escaping GetReportHandel){
        let url = "\(SERVER)/getDetailReview"
        RequestService.shared.AFRequestWithRawData(url: url, method: .post, parameters: parameters, headers: headers, objectType: ReportReponse.self) { (result, data, error) in
            if result {
                guard let model = data as? ReportReponse else{
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
