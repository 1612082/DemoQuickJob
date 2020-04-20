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

    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    func setupUI() {

        let logoutBTN   = UIBarButtonItem(image: #imageLiteral(resourceName: "logout"), style: .plain, target: self, action: #selector(didTapLogoutBtn))
        let notiBTN   = UIBarButtonItem(image: #imageLiteral(resourceName: "notification"), style: .plain, target: self, action: #selector(didTapLogoutBtn))
        navigationItem.rightBarButtonItem = notiBTN
        navigationItem.leftBarButtonItem = logoutBTN
        navigationItem.title = "Trang Chu"
    }

    @objc func didTapLogoutBtn(sender: AnyObject){
        let scene = self.view.window?.windowScene?.delegate as! SceneDelegate
        scene.GoToLogin()
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1,3:
            return 5
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BannerCell", for: indexPath) as! BannerCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "JobCell", for: indexPath) as! JobCell
            cell.bindData(arrJob[indexPath.row])
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "JobCell", for: indexPath) as! JobCell
            cell.bindData(arrJob[indexPath.row + 5])
            return cell
        case 2,4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MoreCell", for: indexPath) as! MoreCell
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "footerCell", for: indexPath) as! footerCell
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 1:
            return "Top 5 Công việc theo thời gian"
        case 3:
            return "Top 5 Công việc theo sản phẩm"
        default:
            return ""
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            let detailVC = Main_Storyboard.instantiateViewController(identifier: "DetailJTimeViewController") as DetailJTimeViewController
            navigationController?.pushViewController(detailVC, animated: true)
        case 3:
            let detailVC = Main_Storyboard.instantiateViewController(identifier: "DetailJprodViewController") as DetailJprodViewController
            navigationController?.pushViewController(detailVC, animated: true)
        default:
            do {}
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
}
