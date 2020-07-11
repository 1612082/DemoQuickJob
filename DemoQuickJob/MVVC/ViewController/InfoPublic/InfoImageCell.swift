//
//  InfoImageCell.swift
//  DemoQuickJob
//
//  Created by HongDang on 6/26/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class InfoImageCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func bindData(_ data:InfoEmployer){
        if data.avatarImg == "" {
            img.image = #imageLiteral(resourceName: "avatar")
        } else {
            let dataDecoded:NSData = NSData(base64Encoded: data.avatarImg, options: NSData.Base64DecodingOptions(rawValue: 0))!
            let decodedimage:UIImage = UIImage(data: dataDecoded as Data)!
            img.image = decodedimage
        }
    }

}
