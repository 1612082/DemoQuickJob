//
//  ScheduleModule.swift
//  DemoQuickJob
//
//  Created by HongDang on 7/22/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import Foundation
public struct ScheduleReponse:Codable {

        public var code : String
        public var data : DataSchedule
        public var message : String
        
}
public struct DataSchedule:Codable {

        public var employeeShedule : [EmployeeShedule?]
        public var employerShedule : [EmployerShedule?]
        
}
public struct EmployerShedule:Codable {

        public var end : String
        public var id_job : Int
        public var title : String
        
}
public struct EmployeeShedule:Codable {

        public var end : String
        public var id_job : Int
        public var title : String
        
}
