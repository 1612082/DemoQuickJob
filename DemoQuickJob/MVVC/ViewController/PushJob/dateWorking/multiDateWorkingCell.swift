//
//  multiDateWorkingCell.swift
//  DemoQuickJob
//
//  Created by HongDang on 6/23/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class multiDateWorkingCell: UITableViewCell {

    @IBOutlet weak var startDate: UITextField!
    @IBOutlet weak var endDate: UITextField!
    var datePickerStart : UIDatePicker!
    var datePickerEnd : UIDatePicker!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        datePickerStart = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.frame.width, height: 200))
        datePickerStart.datePickerMode = .date
        datePickerStart.addTarget(self, action: #selector(changeDateStart), for: .valueChanged)
        startDate.inputView = datePickerStart
        datePickerEnd = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.frame.width, height: 200))
        datePickerEnd.datePickerMode = .date
        datePickerEnd.addTarget(self, action: #selector(changeDateEnd), for: .valueChanged)
        endDate.inputView = datePickerEnd
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @objc func changeDateStart(datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        startDate.text = dateFormatter.string(from: datePicker.date)
        PushJobViewModel.result!.start_date = startDate.text ?? ""
    }
    @objc func changeDateEnd(datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        endDate.text = dateFormatter.string(from: datePicker.date)
        PushJobViewModel.result!.end_date = endDate.text ?? ""
    }
    func bindData(_ data:TYPEJOBDETAIL){
        startDate.text = data.start_date
        endDate.text = data.end_date
    }
}
