//
//  HomeViewController.swift
//  DemoQuickJob
//
//  Created by HongDang on 4/17/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit
import  Foundation

class HomeViewController: UIViewController {

    //MARK: IBOUTLETS
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: OTHER VARIABLES
    let TopPostJobVM = TopPostJobViewModel()
    var SearchTopTime = HighFilterViewModel()
    var SearchTopProduct = HighFilterViewModel()
    //MARK: VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVar()
        setupUI()
    }
    //MARK: - SETUP VAR
    func setupVar() {
        SearchTopTime.job_type = "false"
        SearchTopTime.Search { (model) in
            guard let model = model else {
                return
            }
            if model.code == "200"{
                listTimeJob = model.data.jobList
                self.tableView.reloadData()
            }
        }
        SearchTopProduct.job_type = "true"
        SearchTopProduct.Search { (model) in
            guard let model = model else {
                return
            }
            if model.code == "200"{
                listProductJob = model.data.jobList
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: - SETUP UI
    func setupUI() {

        let logoutBTN   = UIBarButtonItem(image: #imageLiteral(resourceName: "logout"), style: .plain, target: self, action: #selector(didTapLogoutBtn))
        let notiBTN   = UIBarButtonItem(image: #imageLiteral(resourceName: "notification"), style: .plain, target: self, action: #selector(didTapNotiBtn))
        navigationItem.rightBarButtonItem = notiBTN
        navigationItem.leftBarButtonItem = logoutBTN
        navigationItem.title = "Trang Chủ"
        self.navigationController?.isNavigationBarHidden = false
    }

    @objc func didTapLogoutBtn(sender: AnyObject){
        UserDefaults.standard.set(nil, forKey: "token")
        let scene = self.view.window?.windowScene?.delegate as! SceneDelegate
        scene.GoToLogin()
    }
    @objc func didTapNotiBtn(sender: AnyObject){
        let notiVC = Main_Storyboard.instantiateViewController(identifier: "NotificationViewController") as! NotificationViewController
        navigationController?.pushViewController(notiVC, animated: true)
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1:
            return listTimeJob.count
        case 2:
            return listProductJob.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BannerCell", for: indexPath) as! BannerCell
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "JobCell", for: indexPath) as! JobCell
            cell.selectionStyle = .none
            cell.bindData(listTimeJob[indexPath.row]!)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "JobCell", for: indexPath) as! JobCell
            cell.selectionStyle = .none
            cell.bindData(listProductJob[indexPath.row]!)
            return cell
//        case 2,4:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "MoreCell", for: indexPath) as! MoreCell
//            cell.selectionStyle = .none
//            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AwardCell", for: indexPath) as! AwardCell
            cell.selectionStyle = .none
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "footerCell", for: indexPath) as! footerCell
            cell.selectionStyle = .none
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 1:
            return "Top 5 Công việc thời vụ"
        case 2:
            return "Top 5 Công việc theo sản phẩm"
        case 3:
            return "Góc vinh danh"
        default:
            return ""
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
//            let detailVC = Home_Storyboard.instantiateViewController(identifier: "DetailJTimeViewController") as DetailJTimeViewController
//            detailVC.PostJob = listTimeJob[indexPath.row]
//            navigationController?.pushViewController(detailVC, animated: true)
            if listTimeJob[indexPath.row]!.job_type == false{
                let detailVC = Home_Storyboard.instantiateViewController(identifier: "DetailJTimeViewController") as DetailJTimeViewController
                detailVC.idJob = listTimeJob[indexPath.row]?.id_job
                navigationController?.pushViewController(detailVC, animated: true)
            } else {
                let detailVC = Home_Storyboard.instantiateViewController(identifier: "DetailJprodViewController") as DetailJprodViewController
                detailVC.idJob = listTimeJob[indexPath.row]?.id_job
                navigationController?.pushViewController(detailVC, animated: true)
            }
        case 2:
//            let detailVC = Home_Storyboard.instantiateViewController(identifier: "DetailJprodViewController") as DetailJprodViewController
//                           detailVC.PostJob = listProductJob[indexPath.row]
//                           navigationController?.pushViewController(detailVC, animated: true)
            if listProductJob[indexPath.row]!.job_type == false{
                let detailVC = Home_Storyboard.instantiateViewController(identifier: "DetailJTimeViewController") as DetailJTimeViewController
                detailVC.idJob = listProductJob[indexPath.row]?.id_job
                navigationController?.pushViewController(detailVC, animated: true)
            } else {
                let detailVC = Home_Storyboard.instantiateViewController(identifier: "DetailJprodViewController") as DetailJprodViewController
                detailVC.idJob = listProductJob[indexPath.row]?.id_job
                navigationController?.pushViewController(detailVC, animated: true)
            }

        default:
            do {}
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
}
