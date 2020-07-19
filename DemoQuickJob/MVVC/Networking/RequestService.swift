//
//  RequestService.swift
//  DemoQuickJob
//
//  Created by HongDang on 5/24/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import Foundation
import Alamofire
// khai bao compleion co ten la CompletionHandleJSON tra ve 3 gia tri ket qua tra ve, data tra ve dang json, loi neu co
typealias CompletionHandleJSON = (_ result:Bool, _ json:Any?, _ error:Error?)->Void
struct RequestService {
    
    static var shared = RequestService()
    
    func AFRequestWith<T: Codable>(url: String, method: HTTPMethod, parameters: [String:String]?, headers: HTTPHeaders?, objectType: T.Type, completion:@escaping CompletionHandleJSON){
        AF.request(url,
                   method: method,
                   parameters: parameters,
                   encoder: URLEncodedFormParameterEncoder.default,
                   headers: headers,
                   interceptor: nil).response { (reponse) in
                    switch (reponse.result){
                    case .success(let data):
                        do {

                            print(parameters)
                            let json = try JSONDecoder.init().decode(objectType.self, from: data!)
                            // tra gia ra ben ngoai ham bang completion handeler
                            
                            completion(true, json, nil)
                        } catch {
                            //parse json khong dc
                            print("parse json khong dc")
                            completion (false,data,nil)
                        }
                    case .failure(let error):
                        print("res khong tra ve dc")
                        completion(false,nil,error)
                    }
                    
        }
    }
    
    
    func AFRequestWithRawData<T: Codable>(url: String, method: HTTPMethod, parameters: [String:Any]?, headers: HTTPHeaders?, objectType: T.Type, completion:@escaping CompletionHandleJSON){
        guard let url = URL(string: url) else {return}
        var request        = URLRequest(url: url)
        request.httpMethod = "POST"
        if headers != nil{
           request.headers = headers!
        }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            if parameters != nil{
                request.httpBody   = try JSONSerialization.data(withJSONObject: parameters as Any)
            }
        } catch let error {
            print("Error : \(error.localizedDescription)")
        }
        AF.request(request).response{ (response) in
            switch (response.result){
            case .success(let data):
                do {
                    let json = try JSONDecoder.init().decode(objectType.self, from: data!)
                    // tra gia ra ben ngoai ham bang completion handeler
                    print(parameters)
                    print(headers)
                    completion(true, json, nil)
                } catch {
                    //parse json khong dc
                    print("parse json faile")
                    print(headers)
                    print(parameters)
                    completion (false,data,nil)
                }
            case .failure(let error):
                print("res khong tra ve dc")
                completion(false,nil,error)
            }
        }
    }
    
}
