//
//  JobCell.swift
//  DemoQuickJob
//
//  Created by HongDang on 4/18/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class JobCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbAddr: UILabel!
    @IBOutlet weak var lbSalary: UILabel!
    @IBOutlet weak var lbCate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lbSalary.textColor = .orange
        lbAddr.textColor = .gray
        lbCate.textColor = .purple
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func bindData(_ data:Job){
        avatar.image = data.Avatar
        lbName.text = data.Name
        lbAddr.text = data.Addr
        lbSalary.text = data.Sallary
        switch data.Cate {
        case 0:
            lbCate.text = ""
        case 1:
            lbCate.text = "full time"

        case 2:
            lbCate.text = "part time"
        default:
            lbCate.text = "product"
        }
    }

}
