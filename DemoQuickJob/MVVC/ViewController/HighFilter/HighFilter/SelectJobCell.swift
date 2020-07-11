//
//  SelectJobCell.swift
//  DemoQuickJob
//
//  Created by HongDang on 6/18/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class SelectJobCell: UITableViewCell,UITextFieldDelegate {

    @IBOutlet weak var tfJob: UITextField!
    var didShowJobs:(()->Void)! = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let view1 = UIView()
        let imageview = UIImageView(image: UIImage(named: "down"))
        view1.addSubview(imageview)
        view1.widthAnchor.constraint(equalToConstant: 30).isActive = true
        view1.heightAnchor.constraint(equalToConstant: 18).isActive = true

        self.tfJob.rightViewMode = .always
        self.tfJob.rightView = view1
        tfJob.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        if didShowJobs != nil {
            didShowJobs()
        }
        
    }

}
