//
//  TopPostJobViewModel.swift
//  DemoQuickJob
//
//  Created by HongDang on 5/27/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import Foundation

class TopPostJobViewModel{
    func GetTopPersonalJob(completion:@escaping GetTopJobHandel){
        APITopJob.shared.GetTopPersonalJob(parameters: [:], headers: nil) { (model) in
            guard let model = model else {
                completion(nil)
                return
            }
            completion(model)
        }
    }
    func GetTopCompanyJob(completion:@escaping GetTopJobHandel){
        APITopJob.shared.GetTopCompanyJob(parameters: [:], headers: nil) { (model) in
            guard let model = model else {
                completion(nil)
                return
            }
            completion(model)
        }
    }
}
