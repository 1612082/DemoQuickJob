//
//  timeCell.swift
//  DemoQuickJob
//
//  Created by HongDang on 4/24/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class timeCell: UITableViewCell {
    
    @IBOutlet weak var budget: UILabel!
    @IBOutlet weak var counter: UILabel!
    @IBOutlet weak var yourPrice: UILabel!
    let JobDetailVM = JobDetailViewModel()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func bindData(_ P:TYPEJOBDETAIL){
        let salary = JobDetailVM.convertDoubleToCurrency(amount: P.salary)
        budget.text = "\(salary)"
        yourPrice.text = JobDetailVM.FindYourPrice(P.dealers)
        
        counter.text = JobDetailVM.DateFormater(P.end_date ?? "2020-10-01 00:00:00")
    }
}
