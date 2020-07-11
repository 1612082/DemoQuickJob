//
//  InfoPublicFirstCell.swift
//  DemoQuickJob
//
//  Created by HongDang on 6/26/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class InfoPublicFirstCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var addr: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func bindData(_ data:InfoEmployer){
        id.text = "\(data.id_user)"
        name.text = "\(data.fullname)"
        email.text = "\(data.email)"
        addr.text = "\(data.address)"
    }

}
