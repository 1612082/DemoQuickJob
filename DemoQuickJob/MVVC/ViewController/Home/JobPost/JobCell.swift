//
//  JobCell.swift
//  DemoQuickJob
//
//  Created by HongDang on 4/18/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class JobCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var lbAddr: UILabel!
    @IBOutlet weak var lbSalary: UILabel!
    @IBOutlet weak var lbCate: UILabel!
    @IBOutlet weak var tvName: UITextView!
    
    let JobDetailVM = JobDetailViewModel()

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lbSalary.textColor = .orange
        lbAddr.textColor = .gray
        lbCate.textColor = .purple
        tvName.isUserInteractionEnabled = false
        lbAddr.isUserInteractionEnabled = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
        // Configure the view for the selected state
    }
    func bindData(_ data:TYPEJOBPOST){
        if data.img == nil  || data.img! == "" {
            avatar.image = #imageLiteral(resourceName: "avatar")
        } else {
            let dataDecoded:NSData = NSData(base64Encoded: data.img!, options: NSData.Base64DecodingOptions(rawValue: 0))!
            if UIImage(data: dataDecoded as Data) != nil{
                let decodedimage:UIImage = UIImage(data: dataDecoded as Data)!
                avatar.image = decodedimage
            }else {
                avatar.image = #imageLiteral(resourceName: "avatar")
            }
            
        }
        
        tvName.text = data.title
        let addr:String = data.address ?? ""
        lbAddr.text = "\(addr), \(data.district), \(data.province)"
        lbSalary.text = JobDetailVM.convertDoubleToCurrency(amount: data.salary)
        if data.job_type == true{
            lbCate.text = "Sản phẩm"
        } else {
            lbCate.text = "Thời vụ"
        }
        
    }
    func bindData2(_ data:JobAllApply){
        if data.avatarImg == "" {
            avatar.image = #imageLiteral(resourceName: "avatar")
        } else {
            let dataDecoded:NSData = NSData(base64Encoded: data.avatarImg, options: NSData.Base64DecodingOptions(rawValue: 0))!
            let decodedimage:UIImage = UIImage(data: dataDecoded as Data)!
            avatar.image = decodedimage
        }
        
        tvName.text = data.title
        lbAddr.text = "\(data.address), \(data.district), \(data.province)"
        lbSalary.text = JobDetailVM.convertDoubleToCurrency(amount: data.salary)
        if data.job_type == true{
            lbCate.text = "Sản phẩm"
        } else {
            lbCate.text = "Thời vụ"
        }
    }

}
