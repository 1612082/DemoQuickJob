//
//  ListCandidateModel.swift
//  DemoQuickJob
//
//  Created by HongDang on 6/28/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import Foundation
public struct listCandidateResponse:Codable {

        public var code : String
        public var data : listCandidate
        public var message : String
        
}
public struct listCandidate:Codable {

        public var applicantsList : [Candidate?]
        public var page : Int
        public var total : Int
        
}
public struct Candidate:Codable {
    
    public var attachment : String?
    public var dial : String?
    public var email : String
    public var employee_job : Int
    public var employer_rating : Float?
    public var fullname : String
    public var id_applicant : Int
    public var id_user : Int
    public var introduction_string : String?
    public var proposed_price : Int
    

}
