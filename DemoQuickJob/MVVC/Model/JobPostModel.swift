//
//  JobPostModel.swift
//  DemoQuickJob
//
//  Created by HongDang on 5/27/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import Foundation

public struct JobPostsResponse:Codable {

        public var code : String
        public var data : [TYPEJOBPOST]
        public var message : String
        
}

public struct TYPEJOBPOST:Codable {
        public var address : String?
        public var dealable : Bool
        public var description : String?
        public var district : String
        public var expire_date : String
        public var id_job : Int
        public var id_status : Int
        public var img : String?
        public var isCompany : Bool
        public var isOnline : Bool
        public var job_topic : Int
        public var job_type : Bool
        public var lat : Float
        public var lng : Float
        public var post_date : String
        public var province : String
        public var salary : Int
        public var tags : [TAGTYPE?]
        public var title : String
        public var vacancy : Int
        
}
