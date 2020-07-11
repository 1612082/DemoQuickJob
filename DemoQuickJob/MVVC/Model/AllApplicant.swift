//
//  AllApplicant.swift
//  DemoQuickJob
//
//  Created by HongDang on 6/24/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import Foundation
public struct AllApplicantReponse:Codable {
    public var code : String
    public var data : DataAllAppli
    public var message : String
        
}
public struct DataAllAppli:Codable {

    public var jobList : [JobAllApply?]
    public var page : Int
    public var total : Int
        
}
public struct JobAllApply:Codable {

    public var address : String
    public var area_district : Int
    public var area_province : Int
    public var avatarImg : String
    public var benefit : String
    public var deadline : String?
    public var dealable : Bool
    public var description : String
    public var dial : String
    public var district : String
    public var email : String
    public var employer : Int
    public var expire_date : String
    public var fullname : String
    public var id_job : Int
    public var id_status : Int
    public var isCompany : Bool
    public var isOnline : Bool
    public var job_topic : Int
    public var job_type : Bool
    public var lat : Float
    public var lng : Float
    public var post_date : String
    public var province : String
    public var requirement : String
    public var salary : Int
    public var title : String
    public var vacancy : Int
    public var start_date:String?
    public var end_date:String?
    public var salary_type:Int?
}


