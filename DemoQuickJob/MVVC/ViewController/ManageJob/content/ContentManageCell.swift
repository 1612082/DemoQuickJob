//
//  ContentManageCell.swift
//  DemoQuickJob
//
//  Created by HongDang on 5/5/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class ContentManageCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var state: UILabel!
    let ManageVm = ManageJobViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        title.textColor = .red
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func bindData(_ data:JobAllPost){
        title.text = data.title
        if data.id_status == 1{
            state.text = "Đang tuyển"
        } else if data.id_status == 2{
            state.text = "Đang thực hiện"
        } else if data.id_status == 3{
            state.text = "Hoàn thành"
        } else{
            state.text = "Hết hạn"
        }
    }

}
