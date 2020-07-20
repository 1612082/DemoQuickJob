//
//  ManageApplicantViewController.swift
//  DemoQuickJob
//
//  Created by HongDang on 6/28/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class ManageApplicantViewController: UIViewController {
    
    //MARK: IBOUTLETS
    @IBOutlet weak var tableView: UITableView!

    //MARK: OTHER VARIABLES
    var ManaJobVM = ManageJobViewModel()
    var ManaJobVM2 = ManageJobViewModel()
    var idJob:String = ""
    var applying:listCandidate = listCandidate(applicantsList: [], page: 0, total: 0)
    var applyed:listCandidate = listCandidate(applicantsList: [], page: 0, total: 0)
    var id_status = 0 //1 dang tuyen 2 dang thuc hien 3 hoan thanh
    var MomoVM = MomoViewModel()
    //MARK: VIEW LIFE CYCLE
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        callAPI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setupUI()
        setupVar()
        
    }
    
    //MARK: - SETUP VAR
    func setupVar() {
        print("a: ",idJob)
        
    }
    
    //MARK: - SETUP UI
    func setupUI() {
        
    }
    
    //MARK: - CALL API
    func callAPI() {
        
        fillData()
    }
    
    //MARK: - FILL AND BIND DATA
    func fillData() {
        
        ManaJobVM.idJob = self.idJob
        if id_status == 1{
            ManaJobVM.status = "0"
            ManaJobVM.token = token
            ManaJobVM.GetAllCandidate { (model) in
                guard let model = model else {
                    return
                }
                if model.code == "200"{
                    self.applying = model.data
                    self.tableView.reloadData()
                }
            }
        }
        
        ManaJobVM2.idJob = self.idJob
        ManaJobVM2.status = "1"
        ManaJobVM2.token = token
        ManaJobVM2.GetAllCandidate { (model) in
            guard let model = model else {
                return
            }
            if model.code == "200"{
                self.applyed = model.data
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: - BUTTON ACTIONS
    func appDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

 

}
extension ManageApplicantViewController:UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        switch id_status {
        case 1:
            return 3
        case 2:
            return 2
        default:
            return 2
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch  section {
        case 0:
             return "Tổng số ứng viên \(Int(applying.total) + Int(applyed.total))"
        case 1:
            switch id_status {
            case 1:
                return "Đang chờ duyệt"
            default:
                return "Danh sách ứng viên"
            }
        default:
            return "Đã tuyển"
        }
       
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            if id_status == 1{
                return 1
            }
            return applyed.applicantsList.count
        case 1:
            switch id_status {
            case 1:
                return applying.applicantsList.count
            default:
                return applyed.applicantsList.count
            }
            
        default:
            return applyed.applicantsList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch  indexPath.section {
        case 0:
            if id_status == 1{
                return UITableViewCell()
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "ApplicantCell", for: indexPath) as! ApplicantCell
                cell.bindData(applyed.applicantsList[indexPath.row]!)
                return cell
            }
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ApplicantCell", for: indexPath) as! ApplicantCell
            switch indexPath.section {
            case 1:
                switch id_status {
                case 1:
                    cell.bindData(applying.applicantsList[indexPath.row]!)
                default:
                    cell.bindData(applyed.applicantsList[indexPath.row]!)
                }
            default:
                cell.bindData(applyed.applicantsList[indexPath.row]!)
            }
            return cell
        }
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if indexPath.section == 1{
            let Accept = UITableViewRowAction(style: .normal, title: "Chấp nhận") { action, index in
                let MomoVC = Main_Storyboard.instantiateViewController(withIdentifier: "PayMomoController") as! PayMomoController
                MomoVC.idApplicant = self.applying.applicantsList[indexPath.row]?.id_applicant as! Int
                MomoVC.amount = self.applying.applicantsList[indexPath.row]?.proposed_price as! Int
                MomoVC.nameApplicant = self.applying.applicantsList[indexPath.row]?.fullname
                self.navigationController?.pushViewController(MomoVC, animated: true)
                
            }
            
            let Refuse = UITableViewRowAction(style: .destructive, title: "Từ chối") { action, index in
                
            }
            let Review = UITableViewRowAction(style: .default, title: "Đánh giá") { action, index in
                let ReviewVC = Home_Storyboard.instantiateViewController(withIdentifier: "ReviewViewController") as! ReviewViewController
                ReviewVC.idApplicant = self.applyed.applicantsList[indexPath.row]?.id_applicant
                ReviewVC.idJob = self.idJob
                ReviewVC.status = true
                self.navigationController?.pushViewController(ReviewVC, animated: true)
            }
            let Report = UITableViewRowAction(style: .destructive, title: "Báo cáo") { action, index in
                let ReportVC = Home_Storyboard.instantiateViewController(withIdentifier: "ReportViewController") as! ReportViewController
                ReportVC.idApplicant = self.applyed.applicantsList[indexPath.row]?.id_applicant
                ReportVC.idJob = self.idJob
                ReportVC.reporterId = self.applyed.applicantsList[indexPath.row]?.id_user
                ReportVC.yourRole = 1
                ReportVC.typ = 0
                self.navigationController?.pushViewController(ReportVC, animated: true)
            }
            let ToFire = UITableViewRowAction(style: .destructive, title: "Sa thải") { action, index in
                let ReportVC = Home_Storyboard.instantiateViewController(withIdentifier: "ReportViewController") as! ReportViewController
                ReportVC.idApplicant = self.applyed.applicantsList[indexPath.row]?.id_applicant
                ReportVC.idJob = self.idJob
                ReportVC.reporterId = self.applyed.applicantsList[indexPath.row]?.id_user
                ReportVC.yourRole = 1
                ReportVC.typ = 1
                self.navigationController?.pushViewController(ReportVC, animated: true)
            }
            switch id_status {
            case 1:
                return [Accept]
            case 2:
                return [Report,ToFire]
            default:
                return [Review]
            }
            
        }
        return []
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section{
        case 1:
            switch id_status {
            case 1:
                let detailVC = Home_Storyboard.instantiateViewController(identifier: "InfoPublicViewController") as InfoPublicViewController
                detailVC.id = "\(self.applying.applicantsList[indexPath.row]?.id_user ?? 0)"
                self.navigationController?.pushViewController(detailVC, animated: true)
            default:
                let detailVC = Home_Storyboard.instantiateViewController(identifier: "InfoPublicViewController") as InfoPublicViewController
                detailVC.id = "\(self.applyed.applicantsList[indexPath.row]?.id_user ?? 0)"
                self.navigationController?.pushViewController(detailVC, animated: true)
            }
            
        case 2:
            let detailVC = Home_Storyboard.instantiateViewController(identifier: "InfoPublicViewController") as InfoPublicViewController
            detailVC.id = "\(self.applyed.applicantsList[indexPath.row]?.id_user ?? 0)"
            self.navigationController?.pushViewController(detailVC, animated: true)
        default:
            print("-")
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 0
        default:
            return UITableView.automaticDimension
        }
    }
}
