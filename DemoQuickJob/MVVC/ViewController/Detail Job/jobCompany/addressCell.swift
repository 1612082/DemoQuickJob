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
//        if didOpenMap != nil {
//            didOpenMap()
//        }
//        UIApplication.shared.openURL(NSURL(string: "http://maps.apple.com/?address=HoChiMinhCity")! as URL)
        let geocoder = CLGeocoder()
        let str = "Quan 1" // A string of the address info you already have
        geocoder.geocodeAddressString(str) { (placemarksOptional, error) -> Void in
          if let placemarks = placemarksOptional {
            print("placemark| \(String(describing: placemarks.first))")
            if let location = placemarks.first?.location {
              let query = "?ll=\(location.coordinate.latitude),\(location.coordinate.longitude)"
              let path = "http://maps.apple.com/" + query
              if let url = NSURL(string: path) {
                UIApplication.shared.open(url as URL)
              } else {
                // Could not construct url. Handle error.
              }
            } else {
              // Could not get a location from the geocode request. Handle error.
            }
          } else {
            // Didn't get any placemarks. Handle error.
          }
        }
    }
    
    func bindData(_ P:TYPEJOBDETAIL){
        img.image = #imageLiteral(resourceName: "place")
        lbTiitle.text = "Location"
        tfaddr.text = "\(P.address), \(P.area_district), \(P.area_province)"
    }
}
