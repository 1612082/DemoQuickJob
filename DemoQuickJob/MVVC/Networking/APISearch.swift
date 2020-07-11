//
//  APISearch.swift
//  DemoQuickJob
//
//  Created by HongDang on 6/8/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import Foundation
import Alamofire
typealias TopicSuccessHandel = ((_ model: JobTopicResponse?)->Void)
typealias TagSuccessHandel = ((_ model: JobTagResponse?)->Void)
typealias SearchHandel = ((_ model: SearchReponse?)->Void)
typealias GetDistrictSuccessHandel = ((_ model: DistricResponse?)->Void)
typealias GetProviceSuccessHandel = ((_ model: ProviceResponse?)->Void)

struct APISearch {
    static var share = APISearch()
    
    let urlTopic = "/allJobsTopics"
    let urlTag = "/getAllTags"
    let ulrSearch = "/getJobsList"
    let urlDistrict = "/getDistricts/"
    let urlProvince = "/getProvinces"
    
    func getTopic(parameters:[String:String]?, headers:HTTPHeaders?, completion:@escaping TopicSuccessHandel){
        let url = SERVER + urlTopic
        RequestService.shared.AFRequestWith(url: url, method: .get, parameters: parameters, headers: headers, objectType: JobTopicResponse.self) { (result, data, error) in
            if result {
                guard let model = data as? JobTopicResponse else{
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
    func getTag(parameters:[String:String]?, headers:HTTPHeaders?, completion:@escaping TagSuccessHandel){
        let url = SERVER + urlTag
        RequestService.shared.AFRequestWith(url: url, method: .get, parameters: parameters, headers: headers, objectType: JobTagResponse.self) { (result, data, error) in
            if result {
                guard let model = data as? JobTagResponse else{
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
    func search(parameters:[String:Any]?, headers:HTTPHeaders?, completion:@escaping SearchHandel){
        let url = SERVER + ulrSearch
        RequestService.shared.AFRequestWithRawData(url: url, method: .post, parameters: parameters, headers: nil, objectType: SearchReponse.self) { (result, data, error) in
            if result {
                guard let model = data as? SearchReponse else{
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
    func getProvice(parameters:[String:String]?, headers:HTTPHeaders?, completion:@escaping GetProviceSuccessHandel){
        let url = SERVER + urlProvince
        RequestService.shared.AFRequestWith(url: url, method: .get, parameters: parameters, headers: headers, objectType: ProviceResponse.self) { (result, data, error) in
            if result {
                guard let model = data as? ProviceResponse else{
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
    func getDistrict(urlID:String ,parameters:[String:String]?, headers:HTTPHeaders?, completion:@escaping GetDistrictSuccessHandel){
        let url = SERVER + urlDistrict + urlID
        RequestService.shared.AFRequestWith(url: url, method: .get, parameters: parameters, headers: headers, objectType: DistricResponse.self) { (result, data, error) in
            if result {
                guard let model = data as? DistricResponse else{
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
