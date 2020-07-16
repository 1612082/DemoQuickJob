//
//  PushJob.swift
//  DemoQuickJob
//
//  Created by HongDang on 6/14/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import Foundation
import  UIKit
import Alamofire
class PushJobViewModel {
    
    static var result:TYPEPUSHJOB?

    var employer:String = ""{
           didSet{}
    }
    var title:String = ""{
           didSet{}
    }
    var salary:String = ""{
           didSet{}
    }
    var jobTopic:String = ""{
           didSet{}
    }
    var address:String = ""{
           didSet{}
    }
    var area_province:String = ""{
           didSet{}
    }
    var area_district:String = ""{
           didSet{}
    }
    var lat:String = ""{
           didSet{}
    }
    var lng:String = ""{
           didSet{}
    }
    var description:String = ""{
           didSet{}
    }
    var expire_date:String = ""{
           didSet{}
    }
    var dealable:String = ""{
           didSet{}
    }
    var job_type:String = ""{
           didSet{}
    }
    var vacancy:String = ""{
           didSet{}
    }
    var isOnline:String = ""{
           didSet{}
    }
    var isCompany:String = "0"{
           didSet{}
    }
    var requirement:String = ""{
           didSet{}
    }
    var images:[String] = []{
           didSet{}
    }
    var start_date:String = ""{
           didSet{}
    }
    var end_date:String = ""{
           didSet{}
    }
    var benefit:String = ""{
           didSet{}
    }
    
    var tags:[[String:Any]] = []
    var arrT:[TAG] = []{
        didSet{
            tags = arrT.map { (i:TAG) in
                return [
                    "id_tag":i.id_tag,
                    "name":i.name,
                    "status":i.status
                ]
            }
        }
    }
    func pushJob(completion:@escaping PushJobHandel){
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Accept": "application/json"
        ]
        let param = [
            "employer":self.employer,
            "title":self.title,
            "salary":self.salary,
            "job_topic":self.job_type,
            "address":self.address,
            "area_province":self.area_province,
            "area_district":self.area_district,
            "lat":self.lat,
            "lng":self.lng,
            "description":self.description,
            "expire_date":self.expire_date,
            "dealable":self.dealable,
            "job_type":self.job_type,
            "vacancy":self.vacancy,
            "isOnline":self.isOnline,
            "isCompany":self.isCompany,
            "requirement":self.requirement,
            "tags":self.tags,
            "images":self.images,
            "start_date":self.start_date,
            "end_date":self.end_date,
            "benefit":self.benefit
            ] as [String : Any]
        APIPushJob.share.pushJob(parameters: param, headers: headers) { (model) in
            guard let model = model else {
                completion(nil)
                return
            }
            completion(model)
        }
    }
    

    
    func passData(_ data:TYPEPUSHJOB){
        self.employer = "\(data.employer)"
        self.title = data.title
        self.salary = data.salary
        self.jobTopic = data.job_topic
        self.address = data.address
        self.area_province = data.area_province
        self.area_district = data.area_district
        self.lat = "\(data.lat)"
        self.lng = "\(data.lng)"
        self.description = data.description
        self.expire_date = data.expire_date
        self.dealable = "\(data.dealable)"
        self.job_type = data.job_type
        self.vacancy = data.vacancy
        self.isOnline = "\(data.isOnline)"
        self.isCompany = "0"
        self.requirement = data.requirement
        
        if data.images.count != 0{
            self.images = data.images.map({ (img:UIImage)  in
                let imageData:NSData = img.pngData()! as NSData
                let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
                return strBase64
            })
        }
        if data.tags.count > 0{
            arrT = data.tags.map({ (id:Int)  in
                return listTag[id]
            })
        }

        self.start_date = data.start_date
        self.end_date = data.end_date
        self.benefit = data.benefit
    }
}
