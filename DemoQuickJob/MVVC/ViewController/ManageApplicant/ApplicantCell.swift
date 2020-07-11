//
//  ApplicantCell.swift
//  DemoQuickJob
//
//  Created by HongDang on 6/28/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class ApplicantCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var dial: UILabel!
    @IBOutlet weak var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func bindData(_ data:Candidate){
        name.text = data.fullname
        email.text = data.email
        dial.text = data.dial
        price.text = "\(data.proposed_price)"
    }

}
