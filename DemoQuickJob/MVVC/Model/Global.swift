//
//  Global.swift
//  DemoQuickJob
//
//  Created by HongDang on 5/24/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import Foundation
import  UIKit
let SERVER = "https://f2l-client.herokuapp.com"
//let SERVER = "http://localhost:8000"
let Home_Storyboard:UIStoryboard = UIStoryboard.init(name: "Home", bundle: nil)
let Main_Storyboard:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
let PushJob_Storyboard:UIStoryboard = UIStoryboard.init(name: "PushJob", bundle: nil)
let Profile_Storyboard:UIStoryboard = UIStoryboard.init(name: "Profile", bundle: nil)
let Apply_Storyboard:UIStoryboard = UIStoryboard.init(name: "ApllyJob", bundle: nil)

//DATA
var listProductJob:[TYPEJOBPOST?] = []
var listTimeJob:[TYPEJOBPOST?] = []

var CurrentProfile:Personal?
var listTopic:[JOBTOPIC] = []
var listTag:[TAG] = []
var token:String = ""


//var isEdit:Bool?
let usLocale = Locale(identifier: "en_US")
let frenchLocale = Locale(identifier: "fr_FR")
let germanLocale = Locale(identifier: "de_DE")

var numOfDaysInMonth = [31,28,31,30,31,30,31,31,30,31,30,31]
var currentMonthIndex: Int = 0
var presentMonthIndex = 0
var presentYear = 0
var todaysDate = 0
var firstWeekDayOfMonth = 0

var day = calendar.component(.day, from: date)
var weekday = calendar.component(.weekday, from: date)
var month = calendar.component(.month, from: date)
var year = calendar.component(.year, from: date)

let NameMonth:[String] = ["Tháng 1","Tháng 2","Tháng 3","Tháng 4","Tháng 5","Tháng 6","Tháng 7","Tháng 8","Tháng 9","Tháng 10","Tháng 11","Tháng 12"]
let Days:[String] = ["T2","T3","T4","T5","T6","T7","CN"]
var currentMonth:String = ""
var numberOfEmptyBoxs:Int = 0
var NextNumberOfEmptyBoxs:Int = 0
var PreviousNumberOfEmptyBoxs:Int = 0
var Direction = 0
var PositionIndex = 0

//USER
var currentUser:USER?

//Struct
public struct dataResponse:Codable{
    public var code : String
}


//ADDR
var listProvince:[PROVINCEGHN] = []
