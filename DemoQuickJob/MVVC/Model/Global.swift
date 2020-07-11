//
//  Global.swift
//  DemoQuickJob
//
//  Created by HongDang on 5/24/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import Foundation
import  UIKit
//let SERVER = "https://f2l-client.herokuapp.com"
let SERVER = "http://localhost:8000"

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

let NameMonth:[String] = ["January","February","March","April","May","June","July","August","September","October","November","December"]
let Days:[String] = ["Monday","Tuesday","Wednesday","Thusday","Friday","Saturday","Sunday"]
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


//PUBLIC key Momo
let publicKeyMomo = "MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA6yFnbg8ZwTlBaX/trMLnFCeUo/xluMQCIyCcNu6XAj0Cls0VuIxdWrDgakveaaDoTdlyzAmp9S0Y1uL+wERkvaNM0CItVDubUZsCyI4nqdQtl1EaP+cjDcNJnEm9jXVpYQE5ZSZMecC6zAsbQBAnLHKgEaR5iJKvA5xza9MLRudwavipuZgVZLkqfb3AFsOIMY7MDZpQk4if0GBfcsmDrrAGwtJcJpqo4tcalILq3GjLEeixpH2LrJwZF8ZoDr2MRtud5Y/pnNYUgi6Lf3Zm2rm9K3wSfYK2oitqvXddMk1lcyeLaeg6Kg9zv2QJN+6ve5der+wwSGsDSqG32R1Lhs38LifSkw4vR9Ywf5NxtPOnQTpUVQ3O/qm3I9cW+OljH0BKzSmg0dGzQL5UHTb8Pb4KUvqB2EhrwdK+FZrLhJ7sBCer7Sylwd8wSVC3IwO6uLn4G3bFRKb9ok6SRqH7PM0sQPQ6MP6Hx14C73OmdYJzkcbXLbl1iIzO3nvEGvv8L0vDF4Q9EfhKR9ymGgjDNnpvJG8Ev+xX1XL2elEyMO7WhhSAxFnP4FwgGtvDW7JuNYwihfEZq/C1ccWavKCn/6GecdNeBDkHtvHhdb8kX7lM3QG23UJ7/w4V05I88tytFWDgbFG7vzmXb21pl6HO+nBpVCn5jemSMKGT7IbTJmMCAwEAAQ=="

let dataHashDemo =  "nTZWwGdRKdkvY59O9CuSKVwfeDkvE36ttK11Z8G06QOe7raatUuF+B82/fpSx3Q1Njf2bKTdYczvPGwNUWSxcWqI7DWr3frVFeKoTQILo86p2jWefRjeDoBlBokAnP3bKUK/CYYV0+I/tgV1C2tHBgarM3xiZ/acEayY22AV9iMsv6Ed7zY3FF5PxJk0u0ioEqJzAQhFeG5oclLHVwj5NoHoqcf4Q9rXzW0Ng0IxWzh3dBlj7M8Wuxwi2A96KSZUex1+xkJiKgawVyB+Ay6UH9F2xY1JE8shWg/Yd2/tP9+lc/hQzTaQjEUIasa4BUT91DU1ZWeHo30UFGBAGB987t8CpxJGGctTbm7lzlGwuTk8Yj8YPR+GjNgfxvpfTP5ziOFf507rk/UCY3IhiSzVwHrQfYVdKerY+KUGhkR1MiCddgczY4oX2i3WNtXG8qJtkx4zrONZ/OFEdWo2zmVY7A6/+/1uqcK5FMiugEPvkWuZ0sv4wjGmoEmrS1gdDGKsQDTiU+SlgyH19f9F12Nj9vL08MCyZdlaKW2jRxkTAASu9J2Qc3I0Hpz14neOOuAJ2YZLODjccOuP4svsk/YIf4z3gFeZkUwTPyd6NrY5LjU8JvF2p6L8kMrL6QfD2Fe5xJBQfgQsiNZ4hLtloBF9MWBLGKG/00bzjZ1W4snMP/0="
