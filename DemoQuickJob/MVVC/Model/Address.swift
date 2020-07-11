//
//  Address.swift
//  DemoQuickJob
//
//  Created by HongDang on 6/4/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import Foundation

public struct DistrictResponse:Codable {

        public var code : Int
        public var data : [DISTRICT]
        public var msg : String
        
}
public struct DISTRICT:Codable {

    public var Code : String
    public var Description : String
    public var DistrictID : Int
    public var DistrictName : String
    public var IsRepresentative : Bool
    public var MiningText : String
    public var Priority : Int
    public var ProvinceID : Int
    public var ProvinceName : String
    public var SupportType : Int
    public var `Type` : Int
        
}

public struct WardResponse:Codable {

        public var code : Int
        public var data : ARRWARD
        public var msg : String
        
}

public struct ARRWARD:Codable {

        public var Wards : [WARD]
        
}

public struct WARD:Codable {

        public var DistrictCode : String
        public var DistrictID : Int
        public var ProvinceID : Int
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
struct PROVICE {
    var name:String
    var id:Int
}
let arrProvice =
    [
        PROVICE(name:"Hà Nội", id: 201),
        PROVICE(name:"TP HCM", id: 202),
        PROVICE(name:"Đà Nẵng", id: 203),
        PROVICE(name:"Hải Phòng", id: 224),
        PROVICE(name:"Cần Thơ", id: 220),
        PROVICE(name:"An Giang", id: 217),
        PROVICE(name:"Bà Rịa - Vũng Tàu", id: 206),
        PROVICE(name:"Bắc Giang", id: 248),
        PROVICE(name:"Bắc Kạn", id: 245),
        PROVICE(name:"Bạc Liêu", id: 253),
        PROVICE(name:"Bắc Ninh", id: 249),
        PROVICE(name:"Bến Tre", id: 213),
        PROVICE(name:"Bình Định", id: 262),
        PROVICE(name:"Bình Dương", id: 205),
        PROVICE(name:"Bình Phước", id: 239),
        PROVICE(name:"Bình Thuận", id: 258),
        PROVICE(name:"Cà Mau", id: 252),
        PROVICE(name:"Cao Bằng", id: 246),
        PROVICE(name:"Đắk Lắk", id: 210),
        PROVICE(name:"Đắk Nông", id: 241),
        PROVICE(name:"Điện Biên", id: 265),
        PROVICE(name:"Đồng Nai", id: 204),
        PROVICE(name:"Đồng Tháp", id: 216),
        PROVICE(name:"Gia Lai", id: 207),
        PROVICE(name:"Hà Giang", id: 227),
        PROVICE(name:"Hà Nam", id: 232),
        PROVICE(name:"Hà Tĩnh", id: 236),
        PROVICE(name:"Hải Dương", id: 225),
        PROVICE(name:"Hậu Giang", id: 250),
        PROVICE(name:"Hòa Bình", id: 267),
        PROVICE(name:"Hưng Yên", id: 268),
        PROVICE(name:"Khánh Hòa", id: 208),
        PROVICE(name:"Kiên Giang", id: 219),
        PROVICE(name:"Kon Tum", id: 259),
        PROVICE(name:"Lai Châu", id: 264),
        PROVICE(name:"Lâm Đồng", id: 209),
        PROVICE(name:"Lạng Sơn", id: 247),
        PROVICE(name:"Lào Cai", id: 269),
        PROVICE(name:"Long An", id: 211),
        PROVICE(name:"Nam Định", id: 231),
        PROVICE(name:"Nghệ An", id: 235),
        PROVICE(name:"Ninh Bình", id: 233),
        PROVICE(name:"Ninh Thuận", id: 261),
        PROVICE(name:"Phú Thọ", id: 229),
        PROVICE(name:"Quảng Bình", id: 237),
        PROVICE(name:"Quảng Nam", id: 243),
        PROVICE(name:"Quảng Ngãi", id: 242),
        PROVICE(name:"Quảng Ninh", id: 230),
        PROVICE(name:"Quảng Trị", id: 238),
        PROVICE(name:"Sóc Trăng", id: 218),
        PROVICE(name:"Sơn La", id: 266),
        PROVICE(name:"Tây Ninh", id: 240),
        PROVICE(name:"Thái Bình", id: 226),
        PROVICE(name:"Thái Nguyên", id: 244),
        PROVICE(name:"Thanh Hóa", id: 234),
        PROVICE(name:"Thừa Thiên Huế", id: 223),
        PROVICE(name:"Tiền Giang", id: 212),
        PROVICE(name:"Trà Vinh", id: 214),
        PROVICE(name:"Tuyên Quang", id: 228),
        PROVICE(name:"Vĩnh Long", id: 215),
        PROVICE(name:"Vĩnh Phúc", id: 221),
        PROVICE(name:"Yên Bái", id: 263),
        PROVICE(name:"Phú Yên", id: 260 ),
 
    ]
var listDtrict:[DISTRICT] = []
var listWard:[WARD] = []


