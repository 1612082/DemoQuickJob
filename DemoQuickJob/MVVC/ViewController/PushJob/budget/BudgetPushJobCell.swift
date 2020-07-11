//
//  BudgetPushJobCell.swift
//  DemoQuickJob
//
//  Created by HongDang on 5/18/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class BudgetPushJobCell: UITableViewCell,UITextFieldDelegate {

    @IBOutlet weak var tfBudget: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tfBudget.delegate = self
        tfBudget.keyboardType = .numberPad
        tfBudget.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        PushJobViewModel.result!.salary = tfBudget.text ?? ""
    }
    func bindData(_ data:TYPEJOBDETAIL){
        tfBudget.text = "\(data.salary)"
    }
}
