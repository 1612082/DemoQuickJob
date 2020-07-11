//
//  EventAndAdvertisementModel.swift
//  DemoQuickJob
//
//  Created by HongDang on 6/8/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import Foundation
import UIKit
struct EventAndAdvertisement {
    var id:String
    var img:UIImage
    var link:String
}
let arrBannerImg:[EventAndAdvertisement] = [
    EventAndAdvertisement(id: "1", img: #imageLiteral(resourceName: "event gear"), link: "https://gearvn.com/pages/man-hinh-summer-super-sale"),
    EventAndAdvertisement(id: "1", img: #imageLiteral(resourceName: "images"), link: "https://gearvn.com/pages/man-hinh-summer-super-sale"),
    EventAndAdvertisement(id: "1", img: #imageLiteral(resourceName: "tuyen-dung-agn-1170x780"), link: "https://gearvn.com/pages/man-hinh-summer-super-sale"),
    EventAndAdvertisement(id: "1", img: #imageLiteral(resourceName: "tuyendung2"), link: "https://gearvn.com/pages/man-hinh-summer-super-sale"),
]
