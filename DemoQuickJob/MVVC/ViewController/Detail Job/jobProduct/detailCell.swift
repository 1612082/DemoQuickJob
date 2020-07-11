//
//  detailCell.swift
//  DemoQuickJob
//
//  Created by HongDang on 4/24/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class detailCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var tf: UITextView!
    @IBOutlet weak var tfAddr: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func bindData(_ P:TYPEJOBDETAIL){
        title.text = P.title
        tf.text = P.description
        tfAddr.text = "Địa chỉ: \(P.address)"
    }

}
