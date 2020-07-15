//
//  InfoPublicThirdCell.swift
//  DemoQuickJob
//
//  Created by HongDang on 6/26/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit
import Cosmos
class InfoPublicThirdCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var rate: UILabel!
    @IBOutlet weak var star: CosmosView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        star.settings.fillMode = .precise
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func bindData(_ data:Employer,_ tit:String){
        title.text = tit
        total.text = "\(data.employee_job)"
        rate.text = "\(data.employer_rating)"
        star.rating = Double(data.employer_rating)
    }
    func bindData2(_ data:Employee,_ tit:String){
        title.text = tit
        total.text = "\(data.employer_job)"
        rate.text = "\(data.employee_rating)"
        star.rating = Double(data.employee_rating)
    }

}
