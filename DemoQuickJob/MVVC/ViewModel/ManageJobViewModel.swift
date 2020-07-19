//
//  ManageJobViewModel.swift
//  DemoQuickJob
//
//  Created by HongDang on 6/26/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import Foundation
import Alamofire
class ManageJobViewModel{
    var token:String = ""{
        didSet{}
    }
    var page:String = ""{
        didSet{}
    }
    var idJob:String = "0"{
        didSet{}
    }
    var id_job:String = ""{
        didSet{}
    }
    var job_title:String = ""{
        didSet{}
    }
    var id_user:String = ""{
        didSet{}
    }
    var status:String = ""{ // 0 - đang chờ duyệt, 1 - đã tuyển
        didSet{}
    }
    func GetAllPostJob(completion:@escaping GetAllJobPostHandel){
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(self.token)",
            "Accept": "application/json"
        ]
        let param = [
            "page": "1",
            "take": "15",
            "isASC":"true",
            "status":"9"
        ]

        ManageJobAPI.shared.getAllJobPost(parameters: param, headers: headers) { (model) in
            guard let model = model else {
                completion(nil)
                return
            }
            completion(model)
        }
    }
    func GetAllApplicant(completion:@escaping GetAllApplicantHandel){
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(self.token)",
            "Accept": "application/json"
        ]
        let param = [
            "page": "1",
            "take": "15",
            "isASC":"true",
            "status":"9"
        ]

        ManageJobAPI.shared.getAllApplicant(parameters: param, headers: headers) { (model) in
            guard let model = model else {
                completion(nil)
                return
            }
            completion(model)
        }
    }
    func GetAllCandidate(completion:@escaping GetAllCandidateHandel){
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(self.token)",
            "Accept": "application/json"
        ]
        let param = [
            "page": "1",
            "take": "20",
            "isASC": "1",
            "id": self.idJob,
            "id_status": self.status
            ]

        ManageJobAPI.shared.getAllCandidate(parameters: param, headers: headers) { (model) in
            guard let model = model else {
                completion(nil)
                return
            }
            completion(model)
        }
    }
    func formatDate(_ s:String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"

        if let date = dateFormatterGet.date(from: s) {
            return dateFormatterPrint.string(from: date)
        } else {
           return "loi parse date"
        }
    }
    func getDate(_ s:String) -> Date{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatterGet.date(from: s)!
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        let finalDate = calendar.date(from:components)!
        return finalDate
    }
    func CancelApply(completion:@escaping CancelApplyHandel){
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(self.token)",
            "Accept": "application/json"
        ]
        let param = [
            "id_job": self.id_job,
            "id_user": self.id_user,
            "email":"",
            "job_title":""
            ]

        ManageJobAPI.shared.sendCancelApply(parameters: param, headers: headers) { (model) in
            guard let model = model else {
                completion(nil)
                return
            }
            completion(model)
        }
    }

    func DeleteJob(completion:@escaping DeleteJobHandel){
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(self.token)",
            "Accept": "application/json"
        ]
        let param = [
        "id_job": self.id_job
        ]
        ManageJobAPI.shared.deleteJob(parameters: param, headers: headers) { (model) in
            guard let model = model else {
                completion(nil)
                return
            }
            completion(model)
        }
    }
    func StopApply(completion:@escaping StopApplyHandel){
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(self.token)",
            "Accept": "application/json"
        ]
        let param = [
        "id_job": self.id_job
        ]
        ManageJobAPI.shared.stopApply(parameters: param, headers: headers) { (model) in
            guard let model = model else {
                completion(nil)
                return
            }
            completion(model)
        }
    }
    func DoneJob(completion:@escaping DeleteJobHandel){
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(self.token)",
            "Accept": "application/json"
        ]
        let param = [
        "id_job": self.id_job,
        "job_title": self.job_title
        ]
        ManageJobAPI.shared.doneJob(parameters: param, headers: headers) { (model) in
            guard let model = model else {
                completion(nil)
                return
            }
            completion(model)
        }
    }
}
