//
//  InfoPublicViewController.swift
//  DemoQuickJob
//
//  Created by HongDang on 6/26/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class InfoPublicViewController: UIViewController {
    
    //MARK: IBOUTLETS
    @IBOutlet weak var tableView: UITableView!
    //MARK: OTHER VARIABLES
    var id:String = ""
    var InfoEmployerVM = InfoEmployerViewModel()
    var infoPublic:DataEmployer?
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
        
    }
    
    //MARK: - CALL API
    func callAPI() {
        
        fillData()
    }
    
    //MARK: - FILL AND BIND DATA
    func fillData() {
        InfoEmployerVM.id = id
        InfoEmployerVM.GetInfo { (model) in
            guard let model = model else {
                return
            }
            if model.code == "200"{
                self.infoPublic = model.data
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: - BUTTON ACTIONS

    

}
extension InfoPublicViewController:UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if infoPublic == nil {
            return 0
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoImageCell", for: indexPath) as! InfoImageCell
            cell.bindData(infoPublic!.personal)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoPublicFirstCell", for: indexPath) as! InfoPublicFirstCell
            cell.bindData(infoPublic!.personal)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoPublicSecondCell", for: indexPath) as! InfoPublicSecondCell
            cell.bindData(infoPublic!.personal)
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoPublicThirdCell", for: indexPath) as! InfoPublicThirdCell
            cell.bindData(infoPublic!.employer, "Số công việc đã đăng")
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoPublicThirdCell", for: indexPath) as! InfoPublicThirdCell
            cell.bindData2(infoPublic!.employee, "Số công việc đã làm")
            return cell
        }
    }
    
    
}
