//
//  UserModel.swift
//  DemoQuickJob
//
//  Created by HongDang on 6/5/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import Foundation

public struct USERSIGNUP:Codable {
    var email:String
    var password:String
    var dob:String
    var fullname:String
    var dial:String
    var gender:Int
    var addr:String
    var isBusinessUser:Int = 0
    var confirm:String
    
}
//public struct UserResponse:Codable {
//    public var code:String
//    public var message:String
//}
public struct UserResponse:Codable {

    public var code : String
    public var data : DATA?
    public var message : String

}
public struct DATA:Codable {

        public var token : String
        public var user : USER
        
}
public struct USER:Codable {

        public var account_status : Int
        public var activationExpr : String?
        public var activationToken : String
        public var address : String?
        public var currentToken : String?
        public var dial : String
        public var dob : String?
        public var email : String
        public var fullname : String
        public var gender : Bool
        public var id_user : Int
        public var isBusinessUser : Bool
        public var password : String
        
}


public struct SignupResponse:Codable {

    public var code : String
    public var message : String

}
