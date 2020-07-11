//
//  detailOwnerCell.swift
//  DemoQuickJob
//
//  Created by HongDang on 4/24/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class detailOwnerCell: UITableViewCell {

    @IBOutlet weak var nameOwner: UIButton!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
    var didGoInfoVC:(()->Void)! = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func bindData (_ P:TYPEJOBDETAIL){
        nameOwner.setTitle(P.name_employer, for: .normal)
        email.text = P.email
        phone.text = P.dial
    }
    @IBAction func gotoInfo(_ sender: Any) {
        if  didGoInfoVC != nil {
            didGoInfoVC()
        }
        
    }
}
