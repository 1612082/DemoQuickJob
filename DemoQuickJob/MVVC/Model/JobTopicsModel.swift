//
//  JobTopicsModel.swift
//  DemoQuickJob
//
//  Created by HongDang on 5/27/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import Foundation

public struct JobTopicResponse:Codable {

        public var code : String
        public var data : [JOBTOPIC]
        public var message : String
        
}

public struct JOBTOPIC:Codable {

        public var count : Int
        public var id_jobtopic : Int
        public var name : String
        
}

