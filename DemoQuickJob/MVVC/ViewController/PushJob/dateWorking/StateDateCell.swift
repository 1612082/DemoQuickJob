//
//  StateDateCell.swift
//  DemoQuickJob
//
//  Created by HongDang on 6/23/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class StateDateCell: UITableViewCell {

    @IBOutlet weak var Seg: UISegmentedControl!
    var didChangeStateDate: ((_ state:Int)->Void)! = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func changeState(_ sender: UISegmentedControl) {
        if didChangeStateDate != nil {
            didChangeStateDate(sender.selectedSegmentIndex)
        }
    }
    func bindData(_ data:TYPEJOBDETAIL){
        if data.start_date == data.end_date{
            Seg.selectedSegmentIndex = 0
        } else {
            Seg.selectedSegmentIndex = 1
        }
    }
}
