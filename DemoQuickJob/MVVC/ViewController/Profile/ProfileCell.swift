//
//  ProfileCell.swift
//  DemoQuickJob
//
//  Created by HongDang on 5/12/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var state: UILabel!
    @IBOutlet weak var ID: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var btnAuthentication: UIButton!
    @IBOutlet weak var btdetail: UIButton!
    var avatar:UIImageView?
    var didChangeScreen:(()->Void)! = nil
    var didAuthenticate:(()->Void)! = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        state.textColor = .red

        
        img.layer.cornerRadius = img.frame.height/2
       
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func moreInfo(_ sender: Any) {
        if didChangeScreen != nil {
            if CurrentProfile != nil{
                didChangeScreen()
            }
            
        }
    }
    func bindData(_ P:Personal?){
        name.text = CurrentProfile?.fullname
        switch CurrentProfile?.account_status {
        case 1:
            state.text = "Chưa xác thực"
            btnAuthentication.isHidden = false
        default:
            state.text = "Đã xác thực"
            btnAuthentication.isHidden = true
        }
        ID.text = "\(CurrentProfile?.id_user ?? -1)"
        if P?.avatarImg != nil{
            let dataDecoded:NSData = NSData(base64Encoded: CurrentProfile!.avatarImg, options: NSData.Base64DecodingOptions(rawValue: 0))!
            let decodedimage:UIImage = UIImage(data: dataDecoded as Data)!
            img.image = decodedimage
        }

        
    }
    @IBAction func authentication(_ sender: Any) {
        if didAuthenticate != nil{
            didAuthenticate()
        }
    }
    
    
}
