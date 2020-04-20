//
//  DetailJobViewController.swift
//  DemoQuickJob
//
//  Created by HongDang on 4/18/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class DetailJTimeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


}
extension DetailJTimeViewController:UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 8
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderJobTimeCell", for: indexPath) as! HeaderJobTimeCell
            cell.bindData(arrJobTime[0])
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "salaryCell", for: indexPath) as! salaryCell
            cell.bindData(arrJobTime[0])
            return cell
        default:
            let image = UIColor.orange.image()
            let cell = tableView.dequeueReusableCell(withIdentifier: "JobTimeCell", for: indexPath) as! JobTimeCell
            if indexPath.section == 2{
                cell.bindData(arrJobTime[0].timeWork, #imageLiteral(resourceName: "calendar-1"), "Time to work")
            } else if indexPath.section == 3{
                cell.bindData(arrJobTime[0].placeWork, #imageLiteral(resourceName: "place"), "Location")
            }else if indexPath.section == 4{
                cell.bindData(arrJobTime[0].detail, image, "Description")
            }else if indexPath.section == 5{
                cell.bindData(arrJobTime[0].benefit, image, "Benefit")
            }else if indexPath.section == 6{
                cell.bindData(arrJobTime[0].require, image, "Require")
            } else {
                cell.bindData(arrJobTime[0].owner, image, "Employer")
            }
            
            return cell
        }
    }
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
   }

   func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {

    return UITableView.automaticDimension
   }
    
}
extension UIColor {
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
