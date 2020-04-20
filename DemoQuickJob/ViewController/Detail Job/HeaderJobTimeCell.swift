//
//  HeaderJobTimeCell.swift
//  DemoQuickJob
//
//  Created by HongDang on 4/20/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class HeaderJobTimeCell: UITableViewCell {

    @IBOutlet weak var nameCom: UILabel!
    @IBOutlet weak var Addr: UILabel!
    @IBOutlet weak var CateJob: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        CateJob.backgroundColor = .lightGray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func bindData(_ data:JobTime){
        nameCom.text = data.j.Name
        Addr.text = data.j.Addr
        switch data.j.Cate {
        case 0:
            CateJob.text = ""
        case 1:
            CateJob.text = "full time"
        case 2:
            CateJob.text = "part time"
        default:
            CateJob.text = "product"
        }
        
    }

}
