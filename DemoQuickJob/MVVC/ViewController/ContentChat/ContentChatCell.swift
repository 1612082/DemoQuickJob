//
//  ContentChatCell.swift
//  DemoQuickJob
//
//  Created by HongDang on 7/5/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class ContentChatCell: UITableViewCell {

    @IBOutlet weak var lbContent: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lbContent.layer.masksToBounds = true
        lbContent.layer.cornerRadius = 10
        lbContent.font = UIFont.systemFont(ofSize: 20.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }

}

