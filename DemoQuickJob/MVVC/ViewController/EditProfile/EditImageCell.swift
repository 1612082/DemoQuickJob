//
//  EditImageCell.swift
//  DemoQuickJob
//
//  Created by HongDang on 6/10/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class EditImageCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var btnEdit: UIButton!
    var didChangeAvatar:(()->Void)! = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func edit(_ sender: Any) {
        if didChangeAvatar != nil{
            didChangeAvatar()
        }
    }
    func bindData(_ img:[UIImage],_ hid:Bool){
        avatar.image = img.first
        if !hid{
            btnEdit.isHidden = true
        }
    }
    
}
