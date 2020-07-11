//
//  APIPushJob.swift
//  DemoQuickJob
//
//  Created by HongDang on 6/14/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import Foundation
import Alamofire
typealias PushJobHandel = ((_ model: PushJobResponse?)->Void)

struct APIPushJob {
    static var share = APIPushJob()
    
    let urlPushJob = "/jobs/addJob"

    func pushJob(parameters:[String:Any]?, headers:HTTPHeaders?, completion:@escaping PushJobHandel){
        let url = SERVER + urlPushJob
        RequestService.shared.AFRequestWithRawData(url: url, method: .post, parameters: parameters, headers: headers, objectType: PushJobResponse.self) { (result, data, error) in
            if result {
                guard let model = data as? PushJobResponse else{
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
