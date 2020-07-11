//
//  filterJobCell.swift
//  DemoQuickJob
//
//  Created by HongDang on 4/27/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class filterJobCell: UITableViewCell,UITextFieldDelegate {

    @IBOutlet weak var tfFilter: UITextField!
    var didShowAddr:(()->Void)! = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let view1 = UIView()
        let imageview = UIImageView(image: UIImage(named: "down"))
        view1.addSubview(imageview)
        view1.widthAnchor.constraint(equalToConstant: 30).isActive = true
        view1.heightAnchor.constraint(equalToConstant: 18).isActive = true

        self.tfFilter.rightViewMode = .always
        self.tfFilter.rightView = view1
        tfFilter.delegate = self
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        if didShowAddr != nil {
            didShowAddr()
        }
        
    }

  
}
