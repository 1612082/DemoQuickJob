//
//  ChatCell.swift
//  DemoQuickJob
//
//  Created by HongDang on 7/5/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        avatar.layer.cornerRadius = 50
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func bindData(_ data:NSArray){
        for i in data{
            let temp = i as! NSDictionary
            let t = temp.dictionaryWithValues(forKeys: ["email"]) as? [String:String]
            let text:String = t!["email"]!
            if text == currentUser?.email{
                
            }else{
                let t = temp.dictionaryWithValues(forKeys: ["fullname"]) as? [String:String]
                name.text = t!["fullname"]!
                let img = temp.dictionaryWithValues(forKeys: ["img"]) as? [String:String]
                let imgString:String = img!["img"]!
                let dataDecoded:NSData = NSData(base64Encoded: imgString, options: NSData.Base64DecodingOptions(rawValue: 0))!
                let decodedimage:UIImage = UIImage(data: dataDecoded as Data)!
                avatar.image = decodedimage
            }
        }
    }

}
