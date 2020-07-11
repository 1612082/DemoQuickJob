//
//  listAuctionCell.swift
//  DemoQuickJob
//
//  Created by HongDang on 4/24/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class listAuctionCell: UITableViewCell {

    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    
    let JobDetailVM = JobDetailViewModel()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func bindData(s:Dealer){
        lbName.text = s.fullname
        lbPrice.text = JobDetailVM.convertDoubleToCurrency(amount: s.proposed_price) 
    }

}
