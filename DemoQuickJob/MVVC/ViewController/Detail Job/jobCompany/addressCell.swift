//
//  addressCell.swift
//  DemoQuickJob
//
//  Created by HongDang on 5/3/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit
import  Foundation
import MapKit
class addressCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbTiitle: UILabel!
    
    @IBOutlet weak var tfaddr: UITextView!
    var didOpenMap:(()->Void)! = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func openMap(_ sender: Any) {
        
        if didOpenMap != nil {
            didOpenMap()
        }
        
    }
    
    func bindData(_ P:TYPEJOBDETAIL){
        img.image = #imageLiteral(resourceName: "place")
        lbTiitle.text = "Location"
        tfaddr.text = "\(P.address) \(P.district_name) \(P.province_name)"
    }
}
