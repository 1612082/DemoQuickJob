//
//  ReviewAndReportViewModel.swift
//  DemoQuickJob
//
//  Created by HongDang on 7/16/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import Foundation
import Alamofire
class ReviewAndReportViewModel {
   var id_applicant:String = ""{
        didSet{}
    }
    var feedback:String = ""{
        didSet{}
    }
    var id_job:String = ""{
        didSet{}
    }
    var rating:Int = 0{
        didSet{}
    }
    var type:Int = 0{
        didSet{}
    }
    var reporterId:Int = 0{
        didSet{}
    }
    var yourRole:Int = 0{
        didSet{}
    }
    var contentReport:String = ""{
        didSet{}
    }
    var id_user1:String = ""{
        didSet{}
    }
    var id_user2:String = ""{
        didSet{}
    }


 
    func reviewFromEmployee(completion:@escaping ReviewReportHandel){
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Accept": "application/json"
        ]
        let params = [
            "id_applicant": self.id_applicant,
            "id_job": self.id_job,
            "feedback_fromEmployee": self.feedback,
            "rating_fromEmployee": self.rating
        ] as [String:Any]
        APIReviewReport.shared.reviewFromEmployee(parameters: params, headers: headers) { (model) in
            guard let model = model else {
                completion(nil)
                return
            }
            completion(model)
        }
    }
    func reviewFromEmployer(completion:@escaping ReviewReportHandel){
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Accept": "application/json"
        ]
        let params = [
            "id_applicant": self.id_applicant,
            "id_job": self.id_job,
            "feedback_fromEmployer": self.feedback,
            "rating_fromEmployer": self.rating
        ] as [String:Any]
        APIReviewReport.shared.reviewFromEmployer(parameters: params, headers: headers) { (model) in
            guard let model = model else {
                completion(nil)
                return
            }
            completion(model)
        }
    }
    func report(completion:@escaping ReviewReportHandel){
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Accept": "application/json"
        ]
        let params = [
            "id_applicant": self.id_applicant,
            "id_job": self.id_job,
            "content": self.contentReport,
            "type": self.type,
            "reporterId": self.reporterId,
            "yourRole": self.yourRole
        ] as [String:Any]
        APIReviewReport.shared.report(parameters: params, headers: headers) { (model) in
            guard let model = model else {
                completion(nil)
                return
            }
            completion(model)
        }
    }
    func loadReview(completion:@escaping GetReviewHandel){
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Accept": "application/json"
        ]
        let params = [
            "id_applicant": self.id_applicant,
        ] as [String:Any]
        APIReviewReport.shared.GetReview(parameters: params, headers: headers) { (model) in
            guard let model = model else {
                completion(nil)
                return
            }
            completion(model)
        }
    }
    
    func loadReport(completion:@escaping GetReportHandel){
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Accept": "application/json"
        ]
        let params = [
            "id_user1": self.id_user1,
            "id_user2": self.id_user2,
            "type": self.type,
            "applicantId": self.id_applicant,
            "jobId": self.id_job
        ] as [String:Any]
        APIReviewReport.shared.GetReport(parameters: params, headers: headers) { (model) in
            guard let model = model else {
                completion(nil)
                return
            }
            completion(model)
        }
    }
}
