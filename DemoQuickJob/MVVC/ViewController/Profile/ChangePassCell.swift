//
//  ChangePassCell.swift
//  DemoQuickJob
//
//  Created by HongDang on 6/10/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class ChangePassCell: UITableViewCell {
    var didChangePass:(()->Void)! = nil
    @IBOutlet weak var btn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        btn.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func ChangePass(_ sender: Any) {
       
        if didChangePass != nil {
            didChangePass()
        }
    }
    
}
