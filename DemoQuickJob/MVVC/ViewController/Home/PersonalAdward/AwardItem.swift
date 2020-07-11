//
//  AwardItem.swift
//  DemoQuickJob
//
//  Created by HongDang on 5/17/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class AwardItem: UICollectionViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var tf: UITextView!
    func binhData(_ s:AWARD){
        img.image = s.avatar
        img.layer.cornerRadius = 40
        tf.text = s.cate
    }
}
