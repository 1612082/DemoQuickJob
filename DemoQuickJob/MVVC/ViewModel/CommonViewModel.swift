//
//  CommonViewModel.swift
//  DemoQuickJob
//
//  Created by HongDang on 7/13/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import Foundation
import UIKit

class CommonViewModel {
    static var shared = CommonViewModel()
    
    func Loading(_ boxView:inout UIView, _ view:UIView) {
        // You only need to adjust this frame to move it anywhere you want
        boxView = UIView(frame: CGRect(x: view.frame.midX - 90, y: view.frame.midY - 25, width: 180, height: 50))
        boxView.backgroundColor = .white
        boxView.alpha = 0.8
        boxView.layer.cornerRadius = 10

        //Here the spinnier is initialized
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityView.startAnimating()

        let textLabel = UILabel(frame: CGRect(x: 60, y: 0, width: 200, height: 50))
        textLabel.textColor = .gray
        textLabel.text = "Tải dữ liệu"

        boxView.addSubview(activityView)
        boxView.addSubview(textLabel)

        view.addSubview(boxView)
    }
}
