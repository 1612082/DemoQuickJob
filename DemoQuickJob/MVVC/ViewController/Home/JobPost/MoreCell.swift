//
//  MoreCell.swift
//  DemoQuickJob
//
//  Created by HongDang on 4/18/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class MoreCell: UITableViewCell {

    @IBOutlet weak var btnMore: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        btnMore.layer.cornerRadius = 5
        btnMore.layer.borderWidth = 1
        btnMore.layer.borderColor = UIColor.black.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func More(_ sender: Any) {
    }
    
    
}
