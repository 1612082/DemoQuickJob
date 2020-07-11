//
//  SearchResultModel.swift
//  DemoQuickJob
//
//  Created by HongDang on 6/18/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import Foundation

public struct SearchReponse:Codable {

        public var code : String
        public var data : DataSearch
        public var message : String
        
}
public struct DataSearch:Codable {

        public var jobList : [TYPEJOBPOST?]

        
}
//public struct JobList:Codable {
//
//        public var address : String
//        public var area_district : Int
//        public var area_province : Int
//        public var benefit : String
//        public var dealable : Bool
//        public var description : String
//        public var district : String
//        public var employer : Int
//        public var expire_date : String
//        public var id_job : Int
//        public var id_status : Int
//        public var img : String?
//        public var isCompany : Bool
//        public var isOnline : Bool
//        public var job_topic : Int
//        public var job_type : Bool
//        public var lat : Float
//        public var lng : Float
//        public var post_date : String
//        public var province : String
//        public var requirement : String
//        public var salary : Int
//        public var title : String
//        public var vacancy : Int
//
//}
public struct TAGTYPE:Codable {

        public var id_tag : Int
        public var tag_name : String
        
}
public struct ProviceResponse:Codable {

        public var code : String
        public var data : [Provice]
        public var message : String
        
}
public struct Provice:Codable {

        public var id_province : Int
        public var name : String
        
}
public struct DistricResponse:Codable {

        public var code : String
        public var data : [District]
        public var message : String
        
}
public struct District:Codable {

        public var id_district : Int
        public var id_province : Int
        public var name : String
        
}
