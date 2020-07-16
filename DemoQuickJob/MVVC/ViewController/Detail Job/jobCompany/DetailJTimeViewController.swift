//
//  DetailJobViewController.swift
//  DemoQuickJob
//
//  Created by HongDang on 4/18/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class DetailJTimeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btn: UIButton!
    
//    var PostJob:TYPEJOBPOST?
    var idJob:Int?
    var decodedimage:UIImage?
    var CurrentJob:TYPEJOBDETAIL?
    var JobDetailVM = JobDetailViewModel()
    var ApplicantVM = ApplyJobViewModel()
    var CommonVC = CommonViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupVar()
        callAPI()
    }
    
    //MARK: - SETUP VAR
    func setupVar() {

    }
    
    //MARK: - SETUP UI
    func setupUI() {
        btn.layer.cornerRadius = 20
    }
    //MARK: - CALL API
    func callAPI() {
        
        fillData()
    }
    //MARK: - FILL AND BIND DATA
    func fillData() {
        self.JobDetailVM.idJob = idJob ?? -1
        self.JobDetailVM.GetDetailJob { (model) in
            guard let model = model else {
                return
            }
            if model.code == "200" {
                self.CurrentJob = model.data
                self.tableView.reloadData()
            }
        }
    }
    @IBAction func apply(_ sender: UIButton) {
        ApplicantVM.id_job = "\(CurrentJob!.id_job)"
        ApplicantVM.id_user = "\(currentUser!.id_user)"
        ApplicantVM.proposed_price = ""
        ApplicantVM.introduction_string = ""
        print(ApplicantVM.id_job , ApplicantVM.id_user)
        ApplicantVM.addApplicant { (model) in
             guard let model = model else {
                return
            }
            if model.code == "202"{
               // the alert view
                let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                self.CommonVC.showAlert( "Đăng ký thành công", alert)
                self.navigationController?.popToRootViewController(animated: true)

            }else if model.code == "-202"{
                let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                self.CommonVC.showAlert( "Đăng ký thất bại", alert)

               
            }else{
                let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                self.CommonVC.showAlert( "Lỗi hệ thống \(model.code)", alert)
            }
        }
    }
    
}
extension DetailJTimeViewController:UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 8
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if CurrentJob == nil {
            return 0
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderJobTimeCell", for: indexPath) as! HeaderJobTimeCell
            cell.selectionStyle = .none
            cell.bindData(CurrentJob!)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "salaryCell", for: indexPath) as! salaryCell
            cell.selectionStyle = .none
            cell.bindData(CurrentJob!)
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell", for: indexPath) as! addressCell
            cell.selectionStyle = .none
            cell.bindData(CurrentJob!)
            cell.didOpenMap = {
                if (Int.init(self.CurrentJob!.lng) != 0 && Int.init(self.CurrentJob!.lng) != 0){
                    let MapVC = Apply_Storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
                    MapVC.lon = Double.init(self.CurrentJob!.lng)
                    MapVC.lat = Double.init(self.CurrentJob!.lat)
                    MapVC.addr = "\(self.CurrentJob!.address), \(self.CurrentJob!.area_district), \(self.CurrentJob!.area_province)"
                    self.navigationController?.pushViewController(MapVC, animated: true)
                }
            }
            return cell
        default:
//            let image = UIColor.orange.image()
            let cell = tableView.dequeueReusableCell(withIdentifier: "JobTimeCell", for: indexPath) as! JobTimeCell
            if indexPath.section == 2{
                var a = "\(CurrentJob?.start_date ?? "")"
                if a != ""{
                    a = String(a.prefix(10))
                }
                var b = "\(CurrentJob?.end_date ?? "")"
                if a != ""{
                    b = String(b.prefix(10))
                }
                cell.bindData("\(a) - \(b)", #imageLiteral(resourceName: "calendar-1"), "Time to work")
            }else if indexPath.section == 4{
                cell.bindData(CurrentJob?.description ?? "", #imageLiteral(resourceName: "star"), "Description")
            }else if indexPath.section == 5{
                cell.bindData(CurrentJob?.benefit ?? "", #imageLiteral(resourceName: "star"), "Benefit")
            }else if indexPath.section == 6{
                cell.bindData(CurrentJob?.requirement ?? "", #imageLiteral(resourceName: "star"), "Require")
            } else {
                cell.bindData(CurrentJob?.name_employer ?? "", #imageLiteral(resourceName: "star"), "Employer")
            }
            cell.selectionStyle = .none
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.section == 3 {
//
//        }
    }
}
extension UIColor {
    func image(_ size: CGSize = CGSize(width: 0.2, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
