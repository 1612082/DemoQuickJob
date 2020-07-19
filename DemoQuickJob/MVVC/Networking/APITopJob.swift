//
//  APITopJob.swift
//  DemoQuickJob
//
//  Created by HongDang on 5/27/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import Foundation
import Alamofire
typealias GetTopJobHandel = ((_ model: JobPostsResponse?)->Void)

class APITopJob {
    
    static var shared = APITopJob()
    
    let APITopPersonalJob = "/getJobsTemporalRecent/?page=0&number=5"
    let APICompanyJob = "/getJobsCompanyRecent/?page=0&number=5"
    
    func GetTopPersonalJob(parameters:[String:String]?, headers:HTTPHeaders?, completion:@escaping GetTopJobHandel){
        let url = SERVER + APITopPersonalJob
        RequestService.shared.AFRequestWith(url: url, method: .get, parameters: parameters, headers: headers, objectType: JobPostsResponse.self) { (result, data, error) in
            if result {
                    guard let model = data as? JobPostsResponse else{
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
    func GetTopCompanyJob(parameters:[String:String]?, headers:HTTPHeaders?, completion:@escaping GetTopJobHandel){
        let url = SERVER + APICompanyJob
        RequestService.shared.AFRequestWith(url: url, method: .get, parameters: parameters, headers: headers, objectType: JobPostsResponse.self) { (result, data, error) in
            if result {
                guard let model = data as? JobPostsResponse else{
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


