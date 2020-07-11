//
//  JobTypeSearchCell.swift
//  DemoQuickJob
//
//  Created by HongDang on 6/27/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class JobTypeSearchCell: UITableViewCell {
    var didChangeState:((_ state:Int)->Void)! = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func changeJobType(_ sender: UISegmentedControl) {
        if didChangeState != nil{
            didChangeState(sender.selectedSegmentIndex)
        }
    }
    
}
