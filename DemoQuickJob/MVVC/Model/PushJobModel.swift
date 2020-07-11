//
//  PushJobModel.swift
//  DemoQuickJob
//
//  Created by HongDang on 6/14/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import Foundation
import UIKit
struct TYPEPUSHJOB {
    var employer:Int
    var title:String
    var salary:String
    var job_topic:String
    var area_province:String
    var area_district: String
    var address:String
    var start_date:String
    var end_date:String
    var lat: Double
    var lng: Double
    var description:String
    var expire_date:String
    var dealable: Int
    var job_type: String
    var isOnline: Int
    var isCompany: Int
    var requirement:String
    var vacancy: String
    var images:[UIImage]
    var tags:[Int]
    var benefit:String
}

//MARK: - RootClass
public struct PushJobResponse:Codable {

        public var code : String
        public var message : String
        
}
