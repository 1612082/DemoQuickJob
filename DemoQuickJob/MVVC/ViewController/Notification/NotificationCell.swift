//
//  contentficationCell.swift
//  DemoQuickJob
//
//  Created by HongDang on 7/5/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class NotificationCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var content: UILabel!
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
        switch no!["type"] {
        case 0:
            content.text = "Đã từ chối đơn xin của bạn vào công việc \(jo?["job"] ?? "")"
        case 1:
            content.text = "Đã chấp nhận đơn xin của bạn vào công việc  \(jo?["job"] ?? "")"
        case 2:
            content.text = "Công việc  \(jo?["job"] ?? "") đã kết thúc"
        case 3:
            content.text = "Chúng tôi đã thanh toán tiền cho công việc  \(jo?["job"] ?? "")"
        case 4:
            content.text = "Công việc  \(jo?["job"] ?? "") đã bị buộc dừng"
        case 5:
            content.text = "Công việc  \(jo?["job"] ?? "") chuyển sang giai đoạn thực hiện"
        case 6:
            content.text = "Công việc  \(jo?["job"] ?? "") đã được khôi phục lại"
        case 7:
            content.text = "Báo cáo nhân viên trong công việc  \(jo?["job"] ?? "") đã được xử lý"
        case 8:
            content.text = "Yêu cầu yêu cầu sa thải nhân viên trong công việc  \(jo?["job"] ?? "") của bạn không được hoàn tiền"
        case 9:
            content.text = "Yêu cầu sa thải nhân viên trong công việc \(jo?["job"] ?? "") của bạn được hoàn % tiền"
        case 10:
            content.text = "Công việc \(jo?["job"] ?? "") đã bị gỡ hoàn toàn khỏi hệ thống"
        case 11:
            content.text = "Tài khoản của bạn đã được xác thực"
        case 12:
            content.text = """
            Tài khoản của bạn đã được chuyển sang trạng thái "chờ xác thực"
            """
        case 13:
            content.text = "Tài khoản của bạn được đánh giá không đủ điều kiện để xác thực, vui lòng kiểm tra lại."
        case 14:
            content.text = "Công việc \(jo?["job"] ?? "") mà bạn tham gia đã được chủ chỉnh sửa thông tin."
        case 15:
            content.text = "Vừa có nhân viên ứng tuyển vào công việc \(jo?["job"] ?? "")"
        case 16:
            content.text = "Nhân viên vừa bổ sung hồ sơ ứng tuyển cho công việc \(jo?["job"] ?? "")"
        case 17:
            content.text = "Nhân viên vừa rút ứng tuyển khỏi công việc \(jo?["job"] ?? "")"
        case 18:
            content.text = "Công việc \(jo?["job"] ?? "") đã được thực hiện và bạn không được tuyển."
        case 19:
            content.text = "Quyết định sa thải bạn trong Công việc  \(jo?["job"] ?? "") đã được thông qua và bạn được hoàn lại % thỏa thuận ban đầu."
        case 20:
            content.text = "Vừa khiếu nại bạn"
        case 21:
            content.text = "Vừa yêu cầu sa thải bạn"
        case 22:
            content.text = "Vừa đánh giá bạn cho công việc \(jo?["job"] ?? "")"
        case 23:
            content.text = "Vừa đánh giá bạn cho công việc \(jo?["job"] ?? "")"

            
        default:
            content.text = ""
        }
    }
    
}
