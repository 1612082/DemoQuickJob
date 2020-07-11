//
//  APIManageJob.swift
//  DemoQuickJob
//
//  Created by HongDang on 6/26/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import Foundation
import  Alamofire
typealias GetAllApplicantHandel = ((_ model: AllApplicantReponse?)->Void)
typealias GetAllJobPostHandel = ((_ model: AllPostJobReponse?)->Void)
typealias GetAllCandidateHandel = ((_ model: listCandidateResponse?)->Void)
typealias CancelApplyHandel = ((_ model: dataResponse?)->Void)
typealias DeleteJobHandel = ((_ model: dataResponse?)->Void)
typealias StopApplyHandel = ((_ model: dataResponse?)->Void)

struct ManageJobAPI {
    let urlAllJobPost = "/jobs/getJobsByEmployerId"
    let urlAllApplicant = "/jobs/getJobsByApplicantId"
    let urlAllCandidate = "/applicants/getByJobId"
    let urlCancelApply = "/jobs/rejectApplicant"
    let urlDeletejob = "/jobs/deleteJob"
    let urlStopApply = "/jobs/cancelRecruit"
    
    static var shared = ManageJobAPI()
    func getAllJobPost(parameters:[String:String]?, headers:HTTPHeaders?, completion:@escaping GetAllJobPostHandel){
        let url = SERVER + urlAllJobPost
        RequestService.shared.AFRequestWithRawData(url: url, method: .post, parameters: parameters, headers: headers, objectType: AllPostJobReponse.self) { (result, data, error) in
            if result {
                guard let model = data as? AllPostJobReponse else{
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
    func getAllApplicant(parameters:[String:String]?, headers:HTTPHeaders?, completion:@escaping GetAllApplicantHandel){
        let url = SERVER + urlAllApplicant
        RequestService.shared.AFRequestWithRawData(url: url, method: .post, parameters: parameters, headers: headers, objectType: AllApplicantReponse.self) { (result, data, error) in
            if result {
                guard let model = data as? AllApplicantReponse else{
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
    func getAllCandidate(parameters:[String:String]?, headers:HTTPHeaders?, completion:@escaping GetAllCandidateHandel){
        let url = SERVER + urlAllCandidate
        RequestService.shared.AFRequestWith(url: url, method: .post, parameters: parameters, headers: headers, objectType: listCandidateResponse.self) { (result, data, error) in
            if result {
                guard let model = data as? listCandidateResponse else{
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
    func sendCancelApply(parameters:[String:String]?, headers:HTTPHeaders?, completion:@escaping CancelApplyHandel){
        let url = SERVER + urlCancelApply
        RequestService.shared.AFRequestWithRawData(url: url, method: .post, parameters: parameters, headers: headers, objectType: dataResponse.self) { (result, data, error) in
            if result {
                guard let model = data as? dataResponse else{
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
    func deleteJob(parameters:[String:String]?, headers:HTTPHeaders?, completion:@escaping CancelApplyHandel){
        let url = SERVER + urlDeletejob
        RequestService.shared.AFRequestWithRawData(url: url, method: .post, parameters: parameters, headers: headers, objectType: dataResponse.self) { (result, data, error) in
            if result {
                guard let model = data as? dataResponse else{
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
    func stopApply(parameters:[String:String]?, headers:HTTPHeaders?, completion:@escaping StopApplyHandel){
        let url = SERVER + urlStopApply
        RequestService.shared.AFRequestWith(url: url, method: .post, parameters: parameters, headers: headers, objectType: dataResponse.self) { (result, data, error) in
            if result {
                guard let model = data as? dataResponse else{
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

