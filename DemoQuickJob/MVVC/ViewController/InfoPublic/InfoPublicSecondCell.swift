//
//  InfoPublicSecondCell.swift
//  DemoQuickJob
//
//  Created by HongDang on 6/26/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class InfoPublicSecondCell: UITableViewCell {

    @IBOutlet weak var dob: UILabel!
    @IBOutlet weak var isCompany: UILabel!
    @IBOutlet weak var gender: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func bindData(_ data:InfoEmployer){
        dob.text = data.dob
        if data.isBusinessUser {
            isCompany.text = "Công ty"
        } else {
            isCompany.text = "Cá nhân"
        }
        if data.gender {
            gender.text = "Nam"
        } else {
            gender.text = "Nữ"
        }
    }

}
