//
//  ApplyModel.swift
//  DemoQuickJob
//
//  Created by HongDang on 6/22/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import Foundation

public struct ApplicantRequest:Codable {
    public var id_user:Int
    public var id_job: Int
    public var proposed_price: Int
    public var introduction_string:String
}
public struct ApplicantReponse:Codable {

        public var code : String
        public var data : appliRes?
        public var message : String
        
}
public struct appliRes:Codable {

        public var affectedRows : Int
        public var changedRows : Int
        public var fieldCount : Int
        public var insertId : Int
        public var message : String
        public var protocol41 : Bool
        public var serverStatus : Int
        public var warningCount : Int
        
}
