//
//  EditAddrCell.swift
//  DemoQuickJob
//
//  Created by HongDang on 6/10/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class EditAddrCell: UITableViewCell,UITextFieldDelegate {

    @IBOutlet weak var tfProvice: UITextField!
    @IBOutlet weak var tfDistrict: UITextField!
    @IBOutlet weak var tfWard: UITextField!


    var didChangeAddr:((_ id:Int)->Void)! = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tfProvice.delegate = self
        tfDistrict.delegate = self
        tfWard.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
       
        if didChangeAddr != nil {
            switch textField {
            case tfProvice:
                didChangeAddr(0)
            case tfDistrict:
                didChangeAddr(1)
            default:
                didChangeAddr(2)
            }
        }

    }
    func changeProvice(_ s:String){
        tfProvice.text = s
    }
    func changeDistrict(_ s:String){
        tfDistrict.text = s
    }
    func changeWard(_ s:String){
        tfWard.text = s
    }

}
