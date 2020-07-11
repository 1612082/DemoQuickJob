//
//  ProfileViewController.swift
//  DemoQuickJob
//
//  Created by HongDang on 4/17/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    //MARK: IBOUTLETS
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: OTHER VARIABLES
    let ProfileVM = ProfileViewModel()
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
        ProfileVM.token = UserDefaults.standard.string(forKey: "token") ?? ""
        ProfileVM.GetProfile { (model) in
            guard let model = model else {
                return
            }
            if model.code == "200"{
                CurrentProfile = model.data.personal
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: - BUTTON ACTIONS

    

    

}
extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
            cell.didChangeScreen = {
                let EditInfoVC = Profile_Storyboard.instantiateViewController(identifier: "EditProfileViewController") as! EditProfileViewController
                
                if cell.img != nil {
                    EditInfoVC.img.append(cell.img.image!)
                } else {
                    let a:UIImage = #imageLiteral(resourceName: "avatar")
                    EditInfoVC.img.append(a)
                }
                self.navigationController?.pushViewController(EditInfoVC, animated: true)
            }
            cell.bindData(CurrentProfile)
            return cell
        case 1:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChangePassCell", for: indexPath) as! ChangePassCell
        
            return cell
        default:
            let num = indexPath.section
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddInfoProfileCell", for: indexPath) as! AddInfoProfileCell
            cell.bindData(arrProfileCell[num-2])
            return cell
        }
    }
    
    
}
