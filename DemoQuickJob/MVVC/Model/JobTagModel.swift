//
//  JobTagModel.swift
//  DemoQuickJob
//
//  Created by HongDang on 6/14/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import Foundation
public struct JobTagResponse:Codable {

        public var code : String
        public var data : [TAG]
        public var message : String
        
}
public struct TAG:Codable {
    
    public var id_tag : Int
    public var name : String
    public var status : Int
}

