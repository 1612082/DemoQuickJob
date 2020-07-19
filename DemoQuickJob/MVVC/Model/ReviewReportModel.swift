//
//  ReviewReportModel.swift
//  DemoQuickJob
//
//  Created by HongDang on 7/20/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import Foundation
public struct ReviewReponse:Codable {

        public var code : String
        public var data : ReviewResult?
        public var message : String
        
}
public struct ReviewResult:Codable {

        public var code : Int
        public var review : Review?
        
}
public struct Review:Codable {

        public var feedback_fromEmployee : String?
        public var feedback_fromEmployer : String?
        public var id_applicant : Int?
        public var id_job : Int?
        public var rating_fromEmployee : Int?
        public var rating_fromEmployer : Int?
        
}
public struct ReportReponse:Codable {

        public var code : String
        public var data : OneReport?
        public var message : String
        
}
public struct OneReport:Codable {

        public var code : Int
        public var report : Report?
        
}
public struct Report:Codable {

        public var content : String?
        public var id_applicant : Int?
        public var id_job : Int?
        public var id_report : Int?
        public var id_user1 : Int?
        public var id_user2 : Int?
        public var report_date : String?
        public var role1 : Int?
        public var role2 : Int?
        public var solution : String?
        public var status : Int?
        public var type : Int?
        
}
