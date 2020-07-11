//
//  ProfileModel.swift
//  DemoQuickJob
//
//  Created by HongDang on 6/8/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import Foundation

public struct ProfileResponse:Codable {

        public var code : String
        public var data : Datum
        public var message : String
        
}
public struct Datum:Codable {

        public var personal : Personal
        
}
public struct Personal:Codable {

        public var account_status : Int
        public var activationExpr : String?
        public var activationToken : String
        public var address : String
        public var avatarImg : String
        public var backIdPaper : String?
        public var createDate : String
        public var currentToken : String
        public var dial : String
        public var dob : String
        public var email : String
        public var frontIdPaper : String?
        public var fullname : String
        public var gender : Bool
        public var id_user : Int
        public var identity : String?
        public var isBusinessUser : Bool
        public var password : String
        public var portrait : String?
        
}
