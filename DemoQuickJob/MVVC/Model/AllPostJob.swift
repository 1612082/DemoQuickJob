//
//  AllPostJob.swift
//  DemoQuickJob
//
//  Created by HongDang on 6/24/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import Foundation
public struct AllPostJobReponse:Codable {

        public var code : String
        public var data : DataAllPost
        public var message : String
        
}

public struct DataAllPost:Codable {

        public var jobList : [JobAllPost]
        public var page : Int
        public var total : Int
        
}

public struct JobAllPost:Codable{

        public var address : String
        public var area_district : Int
        public var area_province : Int
        public var benefit : String
//        public var candidates : Int
        public var deadline : String?
        public var dealable : Bool
        public var description : String
        public var district : String
        public var employer : Int
        public var end_date : String?
        public var expire_date : String?
        public var id_job : Int
        public var id_status : Int
        public var isCompany : Bool
        public var isOnline : Bool
        public var job_topic : Int
        public var job_type : Bool
        public var lat : Float
        public var lng : Float
        public var post_date : String?
        public var province : String
        public var requirement : String
        public var salary : Int
        public var salary_type : Int?
        public var start_date : String?
        public var title : String
        public var vacancy : Int
    
        
}
