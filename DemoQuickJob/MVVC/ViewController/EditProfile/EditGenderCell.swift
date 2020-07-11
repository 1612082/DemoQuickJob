//
//  EditGenderCell.swift
//  DemoQuickJob
//
//  Created by HongDang on 6/10/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class EditGenderCell: UITableViewCell {

    @IBOutlet weak var stateGender: UISegmentedControl!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func bindData(_ i:Bool){
        if i{
            stateGender.selectedSegmentIndex = 0
        } else{
            stateGender.selectedSegmentIndex = 1

        }
    }

}
