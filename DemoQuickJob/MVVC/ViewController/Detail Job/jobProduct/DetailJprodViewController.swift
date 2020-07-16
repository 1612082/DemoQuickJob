//
//  DetailJprodViewController.swift
//  DemoQuickJob
//
//  Created by HongDang on 4/18/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit
import Foundation

class DetailJprodViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btn: UIButton!
    
    //MARK: OTHER VARIABLES
    var idJob:Int?
    var CurrentJob:TYPEJOBDETAIL?
    var JobDetailVM = JobDetailViewModel()
    var ApplicantVM = ApplyJobViewModel()
    var CommonVC = CommonViewModel()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupVar()
        setupUI()
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
    @IBAction func ApplyJob(_ sender: UIButton) {
        if CurrentJob == nil {
            
        } else if CurrentJob!.dealable {
             let applyVC = Apply_Storyboard.instantiateViewController(withIdentifier: "ApplyPersonalJobViewController") as! ApplyPersonalJobViewController
            applyVC.idJob = CurrentJob?.id_job
            navigationController?.pushViewController(applyVC, animated: true)
        } else {
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
    
}
extension DetailJprodViewController:UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        if CurrentJob == nil {
            return 0
        } else if CurrentJob!.dealable {
            return 5
        }
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 4:
            return CurrentJob?.dealers.count ?? 0
        default:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch  section {
        case 2:
            return "Thông tin người đăng"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "imgdetailCell", for: indexPath) as! imgdetailCell
            cell.arrImg = CurrentJob?.imgs as! [String]
            cell.selectionStyle = .none

            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! detailCell
            cell.bindData(CurrentJob!)
            cell.selectionStyle = .none
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
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "timeCell", for: indexPath) as! timeCell
            cell.selectionStyle = .none
            cell.bindData(CurrentJob!)
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "listAuctionCell", for: indexPath) as! listAuctionCell
            cell.selectionStyle = .none

            cell.bindData(s: (CurrentJob?.dealers[indexPath.row])!)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailOwnerCell", for: indexPath) as! detailOwnerCell
            cell.bindData(CurrentJob!)
            cell.selectionStyle = .none
            cell.didGoInfoVC = {
                let detailVC = Home_Storyboard.instantiateViewController(identifier: "InfoPublicViewController") as InfoPublicViewController
                detailVC.id = "\((self.CurrentJob?.employer)!)"
                self.navigationController?.pushViewController(detailVC, animated: true)
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
