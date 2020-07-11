//
//  CateJobItem.swift
//  DemoQuickJob
//
//  Created by HongDang on 4/27/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class CateJobItem: UICollectionViewCell {
    @IBOutlet weak var lb: UILabel!
    func bindData(text:String, selected:Bool){
        lb.text = text
//        if selected {
//            lb.backgroundColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.5)
//        } else {
//            lb.backgroundColor = .white
//        }
        
        
    }
}
