//
//  SearchViewController.swift
//  DemoQuickJob
//
//  Created by HongDang on 4/17/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit
var arrState:[Bool] = [true,true,true,true,true,true,true,true]
class SearchViewController: UIViewController, UIActionSheetDelegate, DisplayViewControllerDelegate {
    
    
    //MARK: IBOUTLETS
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: OTHER VARIABLES
    var arrSearch:[TYPEJOBPOST?] = []
    let HighFilterVM = HighFilterViewModel()
    var DistrictSearch:[District] = []
    var ProvinceSearch:[Provice] = []
    //MARK: VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupVar()
        callAPI()
        
    }

    //MARK: - SETUP VAR
    func setupVar() {
        
    }
    
    //MARK: - SETUP UI
    func setupUI() {
        navigationItem.title = "Tìm kiếm công việc"

    }
    
    //MARK: - CALL API
    func callAPI() {
        
        fillData()
    }
    
    //MARK: - FILL AND BIND DATA
    func fillData() {
        HighFilterVM.GetDistrict { (model) in
            guard let model = model else {
                return
            }
            if model.code == "200"{
                self.DistrictSearch = model.data
            }
        }
        HighFilterVM.GetProvice { (model) in
            guard let model = model else {
                return
            }
            if model.code == "200"{
                self.ProvinceSearch = model.data
            }
        }
    }
    
    //MARK: - BUTTON ACTIONS
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "PassData"){
            let highFillter = segue.destination as! highFilterViewController
            highFillter.delegate = self
        }
    }
    func doSomethingWith(data: [Int],id: String, jobType: String) {
        self.HighFilterVM.arrTag = data
        self.HighFilterVM.idTopic = id
        self.HighFilterVM.title = ""
        self.HighFilterVM.idProvince = ""
        self.HighFilterVM.job_type = jobType
        self.HighFilterVM.Search { (model) in
            guard let model = model else {
                return
            }
            if model.code == "200" {
                self.arrSearch = model.data.jobList
                self.tableView.reloadData()
            }
        }
    }
}
extension SearchViewController:UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0,1:
            return 1

        default:
            if arrSearch.count == 0 {
                return 1
            } else {
                return arrSearch.count
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TabSearchCell") as! TabSearchCell
            cell.didChangeCategory = { (id)  in
                tableView.reloadData()
            }
            cell.didTouchFilter = {
//                let highFilterVC = Main_Storyboard.instantiateViewController(identifier: "highFilterViewController") as highFilterViewController
//                self.navigationController?.pushViewController(highFilterVC, animated: true)
                self.performSegue(withIdentifier: "PassData", sender: self)
            }
            cell.didSearch = { s in
                if s != "" {
                    self.HighFilterVM.title = s
                    self.HighFilterVM.arrTag = []
                    self.HighFilterVM.idTopic = ""
                    self.HighFilterVM.idProvince = ""
                    self.HighFilterVM.Search { (model) in
                        guard let model = model else {
                            return
                        }
                        if model.code == "200" {
                            self.arrSearch = model.data.jobList
                            tableView.reloadData()
                        }
                    }
                    
                } else {
                    print ("nil y")
                }
            }
            cell.selectionStyle = .none

            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "filterJobCell", for: indexPath) as! filterJobCell
            cell.selectionStyle = .none
            cell.didShowAddr = {
                let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                for i in self.ProvinceSearch {
                    let location = UIAlertAction(title: i.name, style: .default) { (action) in
                        cell.tfFilter.text = i.name
                        self.HighFilterVM.idProvince = "\(i.id_province)"
                        self.HighFilterVM.title = ""
                        self.HighFilterVM.arrTag = []
                        self.HighFilterVM.idTopic = ""
                        self.HighFilterVM.Search { (model) in
                            guard let model = model else {
                                return
                            }
                            if model.code == "200" {
                                self.arrSearch = model.data.jobList
                                tableView.reloadData()
                            }
                        }
                    }
                    actionSheet.addAction(location)
                }
                actionSheet.addAction(cancel)
                self.present(actionSheet, animated: true, completion: nil)
            }
            return cell

        default:
            if arrSearch.count == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "noneCell", for: indexPath) as! noneCell
                cell.textLabel?.text = "Bạn có thể tìm kiếm theo tên công việc"
                return cell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "JobCell", for: indexPath) as! JobCell
            cell.bindData(arrSearch[indexPath.row]!)
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
        
        if arrSearch[indexPath.row]!.isCompany == false{
            let detailVC = Home_Storyboard.instantiateViewController(identifier: "DetailJprodViewController") as DetailJprodViewController
            detailVC.idJob = arrSearch[indexPath.row]?.id_job
            navigationController?.pushViewController(detailVC, animated: true)
        }else{
            let detailVC = Home_Storyboard.instantiateViewController(identifier: "DetailJTimeViewController") as DetailJTimeViewController
            detailVC.idJob = arrSearch[indexPath.row]?.id_job
            navigationController?.pushViewController(detailVC, animated: true)
        }
        
    }
}
