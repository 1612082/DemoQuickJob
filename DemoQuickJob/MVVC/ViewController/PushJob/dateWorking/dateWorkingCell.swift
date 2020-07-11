//
//  dateWorkingCell.swift
//  DemoQuickJob
//
//  Created by HongDang on 5/25/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class dateWorkingCell: UITableViewCell {

    @IBOutlet weak var tfDeadline: UITextField!
    @IBOutlet weak var seg: UISegmentedControl!
    var datePicker : UIDatePicker!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        datePicker = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.frame.width, height: 200))
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(changeDate), for: .valueChanged)
        tfDeadline.inputView = datePicker
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @objc func changeDate(datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        tfDeadline.text = dateFormatter.string(from: datePicker.date)
        PushJobViewModel.result!.start_date = tfDeadline.text ?? ""
        PushJobViewModel.result!.end_date = tfDeadline.text ?? ""
    }
    @IBAction func ChangeJobTyoe(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            PushJobViewModel.result?.job_type = "1"
        }else{
            PushJobViewModel.result?.job_type = "0"
        }
    }
    func bindData(_ data:TYPEJOBDETAIL){
        if data.job_type == true{
            seg.selectedSegmentIndex = 0
        }else{
            seg.selectedSegmentIndex = 1
        }
        tfDeadline.text = data.start_date
    }
}
