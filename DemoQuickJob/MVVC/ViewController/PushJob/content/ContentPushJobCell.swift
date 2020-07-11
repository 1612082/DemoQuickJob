//
//  ContentPushJobCellCell.swift
//  DemoQuickJob
//
//  Created by HongDang on 5/18/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class ContentPushJobCell: UITableViewCell,UITextViewDelegate {

    @IBOutlet weak var content: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        content.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func textViewDidChange(_ textView: UITextView) {
        PushJobViewModel.result!.description = content.text
        
    }
    func bindData(_ data:TYPEJOBDETAIL){
        content.text = data.description
    }
}
