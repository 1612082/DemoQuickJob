//
//  PersonalPushJobCell.swift
//  DemoQuickJob
//
//  Created by HongDang on 5/18/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class TitlePushJobCell: UITableViewCell {

    @IBOutlet weak var title: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func change(_ sender: Any) {
        PushJobViewModel.result!.title = title.text ?? ""
    }
    func bindData(_ data:TYPEJOBDETAIL){
        title.text = data.title
    }
}
