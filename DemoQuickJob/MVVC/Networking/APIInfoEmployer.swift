//
//  APIInfoEmployer.swift
//  DemoQuickJob
//
//  Created by HongDang on 6/26/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import Foundation
import Alamofire
typealias GetInfoEmployerHandel = ((_ model: InfoEmployerResponse?)->Void)
struct InfoEmployerAPI {
    let urlGetInfoEmployer = "/getUserInfoNotPrivate/"
    
    static var shared = InfoEmployerAPI()
    
    func GetInfoEmployer(urlID:String ,parameters:[String:String]?, headers:HTTPHeaders?, completion:@escaping GetInfoEmployerHandel){
        let url = SERVER + urlGetInfoEmployer + urlID
        RequestService.shared.AFRequestWith(url: url, method: .get, parameters: parameters, headers: headers, objectType: InfoEmployerResponse.self) { (result, data, error) in
            if result {
                guard let model = data as? InfoEmployerResponse else{
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
