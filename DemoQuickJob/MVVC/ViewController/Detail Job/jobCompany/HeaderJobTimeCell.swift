//
//  HeaderJobTimeCell.swift
//  DemoQuickJob
//
//  Created by HongDang on 4/20/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class HeaderJobTimeCell: UITableViewCell {

    @IBOutlet weak var nameCom: UILabel!
    @IBOutlet weak var Addr: UILabel!
    @IBOutlet weak var CateJob: UILabel!
    @IBOutlet weak var logoCompany: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        CateJob.backgroundColor = .lightGray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func bindData(_ P:TYPEJOBDETAIL){
        if P.imgs.count != 0 {
            let dataDecoded:NSData = NSData(base64Encoded: P.imgs.first!, options: NSData.Base64DecodingOptions(rawValue: 0))!
            let decodedimage:UIImage = UIImage(data: dataDecoded as Data)!
            logoCompany.image = decodedimage
            
        } else {
            logoCompany.image = #imageLiteral(resourceName: "avatar")
        }
        nameCom.text = P.title
        Addr.text = "\(P.district_name) \(P.province_name)"
//        CateJob.text = "part time"
//        logoCompany.image = img
    }

}
