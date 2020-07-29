//
//  AddInfoProfileCell.swift
//  DemoQuickJob
//
//  Created by HongDang on 5/12/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class AddInfoProfileCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var content: UITextView!
    @IBOutlet weak var btnAddInfo: UIButton!
    var didSelect:(()->Void)! = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        btnAddInfo.layer.cornerRadius = 20
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindData(_ s:PROFILECELL){
        title.text = s.title
        content.text = s.content
        btnAddInfo.setTitle(s.btnTitle, for: .normal)
        btnAddInfo.layer.cornerRadius = 5
    }
    @IBAction func addInfo(_ sender: Any) {
        if didSelect != nil {
            didSelect()
        }
    }
    
}
