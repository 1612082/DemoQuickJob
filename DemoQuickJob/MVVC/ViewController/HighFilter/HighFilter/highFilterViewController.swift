//
//  highFilterViewController.swift
//  DemoQuickJob
//
//  Created by HongDang on 5/19/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit
protocol DisplayViewControllerDelegate : NSObjectProtocol{
    func doSomethingWith(data: [Int], id: String, jobType:String)
}
class highFilterViewController: UIViewController {
    
    //MARK: IBOUTLETS
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btn: UIButton!
    
    
    //MARK: OTHER VARIABLES
    let HighFilterVM = HighFilterViewModel()
    var arrTag:[Int] = []
    var arrIdTag:[Int] = []
    var jobType = "false"
//    var arrQuanlity:[Int] = []
    var arrListHighFilter:[String] = []
    var idJobTopic:String = ""
    weak var delegate : DisplayViewControllerDelegate?
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
        
    }
    
    //MARK: - SETUP UI
    func setupUI() {
        btn.layer.cornerRadius = 10
    }
    
    //MARK: - CALL API
    func callAPI() {
        
        fillData()
    }
    
    //MARK: - FILL AND BIND DATA
    func fillData() {
        HighFilterVM.Gettopic { (model) in
            guard let model = model else {
                return
            }
            if model.code == "200"{
                listTopic = model.data
                self.tableView.reloadData()
            }
        }
        HighFilterVM.Gettag { (model) in
            guard let model = model else {
                return
            }
            if model.code == "200"{
                listTag = model.data
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: - BUTTON ACTIONS
    
    @IBAction func Search(_ sender: UIButton) {
        HighFilterVM.job_type = ""
        arrIdTag = arrTag.map({ (id:Int)  in
            return listTag[id].id_tag
        })
        self.delegate?.doSomethingWith(data: arrIdTag, id: idJobTopic, jobType: jobType)
        navigationController?.popViewController(animated: true)
    }
    

}
extension highFilterViewController:UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "showHighFilterCell", for: indexPath) as! showHighFilterCell
            cell.collectionView.reloadData()
            cell.arrShow = arrTag.map({ (value:Int) -> String in
                    return listTag[value].name
                })
//            cell.arrListHighFilter = arrListHighFilter
            cell.didRemoveItem = { id in
                 self.arrTag.remove(at: id )
                tableView.reloadData()
            }
            return cell
        case 1:
             let cell = tableView.dequeueReusableCell(withIdentifier: "JobTypeSearchCell", for: indexPath) as! JobTypeSearchCell
             cell.didChangeState = { value in
                if value == 0{
                    self.jobType = "false"
                } else {
                    self.jobType = "true"
                }
             }
             return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SelectJobCell", for: indexPath) as! SelectJobCell
            cell.didShowJobs = {
                let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                for i in listTopic {
                    let location = UIAlertAction(title: i.name, style: .default) { (action) in
                        cell.tfJob.text = i.name
                        self.idJobTopic = "\(i.id_jobtopic)"
                    }
                    actionSheet.addAction(location)
                }
                actionSheet.addAction(cancel)
                self.present(actionSheet, animated: true, completion: nil)
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "highFilterCell", for: indexPath) as! highFilterCell
            cell.collectionView.reloadData()
            cell.arrTag = arrTag
            cell.didTouch = { id in
                if self.arrTag.contains(id) {
                    
                }else{
                    self.arrTag.append(id)
                }
                
                
                tableView.reloadData()
            }
            
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return ""
        case 1:
            return "Loại nghề nghiệp"
        case 2:
            return "Nghề nghiệp"
        default:
            return "Tính chất công việc"
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 2 || indexPath.section == 1 ) {
            return UITableView.automaticDimension
        }
        return tableView.frame.height / 3
    }
    
}
