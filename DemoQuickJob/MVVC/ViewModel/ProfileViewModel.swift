//
//  ProfileViewModel.swift
//  DemoQuickJob
//
//  Created by HongDang on 6/8/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import Foundation
import Alamofire
class ProfileViewModel {
    var token:String = ""{
        didSet{}
    }
    
    func GetProfile(completion:@escaping ProfileSuccessHandel){
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(self.token)",
            "Accept": "application/json"
        ]
        AuthenAPI.shared.AuthProfile(parameters: [:], headers: headers) { (model) in
            guard let model = model else {
                completion(nil)
                return
            }
            completion(model)
        }
    }
}
