//
//  InfoEmployerModel.swift
//  DemoQuickJob
//
//  Created by HongDang on 6/26/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import Foundation
public struct InfoEmployerResponse:Codable {

        public var code : String
        public var data : DataEmployer
        public var message : String
        
}
public struct DataEmployer:Codable {
    public var employee : Employee
    public var employer : Employer
    public var personal : InfoEmployer
        
}
public struct InfoEmployer:Codable {
    public var address : String
    public var avatarImg : String
    public var dial : String
    public var dob : String
    public var email : String
    public var fullname : String
    public var gender : Bool
    public var id_user : Int
    public var identity : String?
    public var isBusinessUser : Bool
        
}
public struct Employer:Codable {

        public var employee_job : Int
        public var employer_rating : Float
        
}
public struct Employee:Codable {

        public var employee_rating : Float
        public var employer_job : Int
        
}
