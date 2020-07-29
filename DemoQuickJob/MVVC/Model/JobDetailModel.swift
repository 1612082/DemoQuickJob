//
//  JobDetailModel.swift
//  DemoQuickJob
//
//  Created by HongDang on 6/1/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import Foundation

public struct JobDetailResponse:Codable {

    public var code : String
    public var data : TYPEJOBDETAIL
    public var message : String
        
}
public struct TYPEJOBDETAIL:Codable {
    public var address : String
    public var area_district : Int
    public var area_province : Int
    public var benefit : String?
    public var deadline : String?
    public var dealable : Bool
    public var dealers : [Dealer?]
    public var description : String?
    public var dial : String
    public var district_name : String
    public var email : String
    public var employer : Int
    public var end_date : String?
    public var expire_date : String
    public var id_job : Int
    public var id_status : Int
    public var imgs : [String]
    public var isCompany : Bool
    public var isOnline : Bool
    public var job_topic : Int
    public var job_type : Bool
    public var lat : Float
    public var lng : Float
    public var name_employer : String
    public var name_status : String
    public var post_date : String
    public var province_name : String
    public var requirement : String
    public var salary : Int
    public var salary_type : Int?
    public var start_date : String?
    public var tags : [String?]
    public var title : String
    public var topic_name : String
    public var vacancy : Int
    

        
}
public struct Dealer:Codable  {
    public var dial : String
    public var email : String
    public var fullname : String
    public var id_job : Int
    public var id_user : Int
    public var proposed_price : Int
}
