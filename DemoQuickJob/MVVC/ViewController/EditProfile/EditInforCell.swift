//
//  EditInforCell.swift
//  DemoQuickJob
//
//  Created by HongDang on 6/10/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class EditInforCell: UITableViewCell {

    @IBOutlet weak var tfInfo: UITextField!
    var type:Int?
    var didChangeData:((_ text:String, _ type:Int)->Void)! = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tfInfo.layer.cornerRadius = 10
        tfInfo.addTarget(self, action: #selector(getdata), for: .editingDidEnd)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func bindData(_ s:String, typedata:Int){
        tfInfo.text = s
        self.type = typedata
    }
    @objc func getdata(){
        if didChangeData != nil{
            didChangeData(tfInfo.text!, self.type!)
        }
    }

}
