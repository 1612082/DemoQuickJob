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
    //MARK: VIEW LIFE CYCLE
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setupUI()
        setupVar()
        callAPI()
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
        ManaJobVM.status = "0"
        ManaJobVM.token = token
        ManaJobVM.idJob = self.idJob
        ManaJobVM.GetAllCandidate { (model) in
            guard let model = model else {
                return
            }
            if model.code == "200"{
                self.applying = model.data
                self.tableView.reloadData()
            }
        }
        
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
        return 3
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch  section {
        case 0:
             return "Tổng số ứng viên \(Int(applying.total) + Int(applyed.total))"
        case 1:
            return "Đang chờ duyệt"
        default:
            return "Đã tuyển"
        }
       
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return applying.applicantsList.count

        default:
            return applyed.applicantsList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch  indexPath.section {
        case 0:
            return UITableViewCell()
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ApplicantCell", for: indexPath) as! ApplicantCell
            switch indexPath.section {
            case 1:
                cell.bindData(applying.applicantsList[indexPath.row]!)
            default:
                cell.bindData(applyed.applicantsList[indexPath.row]!)
            }
            return cell
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
