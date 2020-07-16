//
//  Address.swift
//  DemoQuickJob
//
//  Created by HongDang on 6/4/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import Foundation

public struct DistrictGHNResponse:Codable {

    public var code : Int
    public var data : [DISTRICTGHN]
    public var message : String
        
}
public struct DISTRICTGHN:Codable {

    public var Code : String
    public var DistrictID : Int
    public var DistrictName : String
    public var ProvinceID : Int
    public var SupportType : Int
    public var `Type` : Int
        
}

public struct WardGHNResponse:Codable {

        public var code : Int
        public var data : [WARDGHN]
        public var message : String
        
}

public struct WARDGHN:Codable {

        public var DistrictID : Int
        public var WardCode : String
        public var WardName : String
        
}

struct ADDRESS {
    var provice:String
    var district:String
    var ward:String
    var Stress:String
}
struct ArrAddress {
    var provice:String
    
}

//var listDtrict:[DISTRICT] = []
//var listWard:[WARD] = []


public struct ProvinceGHNResponse:Codable {

    public var code : Int
    public var data : [PROVINCEGHN]
    public var message : String
        
}
public struct PROVINCEGHN:Codable {

        public var Code : String
        public var ProvinceID : Int
        public var ProvinceName : String
        
}
