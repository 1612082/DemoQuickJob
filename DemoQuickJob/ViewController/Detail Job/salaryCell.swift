//
//  salaryCell.swift
//  DemoQuickJob
//
//  Created by HongDang on 4/20/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class salaryCell: UITableViewCell {

    @IBOutlet weak var salary: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func bindData(_ data:JobTime){
        salary.text = data.j.Sallary
    }
}
