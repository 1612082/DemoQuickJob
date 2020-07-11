//
//  HighFilterViewModel.swift
//  DemoQuickJob
//
//  Created by HongDang on 6/8/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import Foundation

class HighFilterViewModel {
    var title:String = ""{
        didSet{}
    }
    var idProvince:String = ""{
        didSet{}
    }
    var idDistrict:String = ""{
        didSet{}
    }
    var job_type:String = ""{ // 0 theo thoi gian, 1 theo san pham
        didSet{}
    }
    var arrTag:[Int] = []{
        didSet{}
    }
    var idTopic:String = ""{
        didSet{}
    }
    func Gettopic(completion:@escaping TopicSuccessHandel){
        APISearch.share.getTopic(parameters: [:], headers: nil) { (model) in
            guard let model = model else {
                completion(nil)
                return
            }
            completion(model)
        }
    }
    func Gettag(completion:@escaping TagSuccessHandel){
        APISearch.share.getTag(parameters: [:], headers: nil) { (model) in
            guard let model = model else {
                completion(nil)
                return
            }
            completion(model)
        }
    }
    func Search(completion:@escaping SearchHandel){
        let query = [
            "title": self.title,
            "employer": "",
            "job_topic": self.idTopic,
            "expire_date": "",
            "area_province": self.idProvince,
            "job_type": self.job_type,
            "tags":self.arrTag
            
            ] as [String : Any]
        let param = [
            "page": "1",
            "take": "5",
            "isASC":"true",
            "query": query
            ] as [String : Any]
        
        APISearch.share.search(parameters: param, headers: nil) { (model) in
            guard let model = model else {
                completion(nil)
                return
            }
            completion(model)
        }
        
    }
    func GetDistrict(completion:@escaping GetDistrictSuccessHandel){
        APISearch.share.getDistrict(urlID: idDistrict, parameters: [:], headers: nil) { (model) in
            guard let model = model else {
                completion(nil)
                return
            }
            completion(model)
        }
    }
    func GetProvice(completion:@escaping GetProviceSuccessHandel){
        APISearch.share.getProvice(parameters: [:], headers: nil) { (model) in
            guard let model = model else {
                completion(nil)
                return
            }
            completion(model)
        }
    }
}
