//
//  APIApplyJob.swift
//  DemoQuickJob
//
//  Created by HongDang on 6/22/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import Foundation
import Alamofire
typealias ApplicantHandel = ((_ model: ApplicantReponse?)->Void)
struct ApplicantAPI {
    let urlAddApplicant = "/applicants/addApplicant"
    static var shared = ApplicantAPI()
    func addApplicant(parameters:[String:String]?, headers:HTTPHeaders?, completion:@escaping ApplicantHandel){
        let url = SERVER + urlAddApplicant
        RequestService.shared.AFRequestWith(url: url, method: .post, parameters: parameters, headers: headers, objectType: ApplicantReponse.self) { (result, data, error) in
            if result {
                guard let model = data as? ApplicantReponse else{
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
