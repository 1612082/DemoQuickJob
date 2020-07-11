//
//  NotificationCell.swift
//  DemoQuickJob
//
//  Created by HongDang on 7/5/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class NotificationCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var noti: UILabel!
    @IBOutlet weak var job: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func bindData(_ data:NSDictionary){
        let na = data.dictionaryWithValues(forKeys: ["fullname"]) as? [String:String]
        let jo = data.dictionaryWithValues(forKeys: ["job"]) as? [String:String]
        let no = data.dictionaryWithValues(forKeys: ["type"]) as? [String:NSNumber]
        name.text = na!["fullname"]!
        job.text = jo!["job"]!
        switch no!["type"] {
        case 0:
            noti.text = "Đã từ chối đơn xin của bạn vào công việc:"
        case 1:
            noti.text = "Đã chấp nhận đơn xin của bạn vào công việc:"
        case 2:
            noti.text = "Đã kết thúc công việc:"
        default:
            noti.text = "F2L đã thanh toán tiền cho công việc:"
        }
    }

}
