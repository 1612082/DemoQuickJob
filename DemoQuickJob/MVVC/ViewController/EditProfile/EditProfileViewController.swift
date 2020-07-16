//
//  EditProfileViewController.swift
//  DemoQuickJob
//
//  Created by HongDang on 6/10/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    //MARK: IBOUTLETS
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnEdit: UIButton!
    //MARK: OTHER VARIABLES
    var isEdit = false
    var trans = false
    var img:[UIImage] = []
    var idProvice:Int = 0
    var idDistrict:Int = 0
    var listDistictFilter:[DISTRICTGHN] = []
    var LoginVM = LobbyViewModel()
    var GetAddrVM = GetAddrViewModel()
    var listDistrict:[DISTRICTGHN] = []
    var listWard:[WARDGHN] = []
    //MARK: VIEW LIFE CYCLE
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if trans {
            isEdit = true
        } else {
            isEdit = false
        }
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
        if trans {
            btnEdit.setTitle("Hoàn tất", for: .normal)
        } else {
            btnEdit.setTitle("Chỉnh sửa", for: .normal)
        }
    }
    
    //MARK: - CALL API
    func callAPI() {
        
        fillData()
    }
    
    //MARK: - FILL AND BIND DATA
    func fillData() {
        
    }
    
    //MARK: - BUTTON ACTIONS
    @IBAction func Edit(_ sender: UIButton) {
        if isEdit{
            //send API
            self.navigationController?.popToRootViewController(animated: true)
        } else {
            let EditInfoVC = Profile_Storyboard.instantiateViewController(identifier: "EditProfileViewController") as! EditProfileViewController
            EditInfoVC.trans = true
            EditInfoVC.img = img
            self.navigationController?.pushViewController(EditInfoVC, animated: true)
        }
    }
    
    
}
extension EditProfileViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "AVATAR"
        case 1:
            return "Tên đầy đủ"
        case 2:
            return "Số điện thoại"
        case 3:
            return "Ngày sinh"
        case 4:
            return "Email"
        case 5:
            return "Địa chỉ"
        default:
            return "Giới tính"
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "EditImageCell", for: indexPath) as! EditImageCell
            cell.isUserInteractionEnabled = self.isEdit
            
            cell.didChangeAvatar = {
                UploadImageFromDevice.shared.showImagePicker(vc: self) { (images) in
                    if images.count != 0{
                        self.img = images
                    }
                    
                    tableView.reloadData()
                }
            }
            cell.bindData(self.img, trans)
            return cell
        case 1,2,3,4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "EditInforCell", for: indexPath) as! EditInforCell
            switch indexPath.section {
            case 1:
                cell.bindData(CurrentProfile!.fullname)
            case 2:
                cell.bindData(CurrentProfile!.dial)
            case 3:
                cell.bindData(CurrentProfile!.dob)
            default:
                cell.bindData(CurrentProfile!.email)
                
            }
            cell.isUserInteractionEnabled = self.isEdit
            return cell
        case 5:
            if isEdit == false{
                let cell = tableView.dequeueReusableCell(withIdentifier: "EditInforCell", for: indexPath) as! EditInforCell
                cell.bindData(CurrentProfile!.address)
                cell.isUserInteractionEnabled = self.isEdit
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "EditAddrCell", for: indexPath) as! EditAddrCell
                cell.isUserInteractionEnabled = self.isEdit
                cell.didChangeAddr = { id in
                    let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                    let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                    switch id {
                    case 0:
                        for i in listProvince {
                            let location = UIAlertAction(title: i.ProvinceName, style: .default) { (action) in
                                cell.changeProvice(i.ProvinceName)
                                self.GetAddrVM.provinceID = i.ProvinceID
                                self.GetAddrVM.GetDistrict {  (model) in
                                    guard let model = model else{
                                        return
                                    }
                                    if model.code == 200{
                                        self.listDistrict = model.data
                                    }
                                    
                                }
                            }
                            actionSheet.addAction(location)
                        }
                    case 1:
                        for i in self.listDistictFilter {
                            let location = UIAlertAction(title: i.DistrictName, style: .default) { (action) in
                                cell.changeDistrict(i.DistrictName)
                                self.idDistrict = i.DistrictID
                                self.GetAddrVM.districtID = i.DistrictID
                                self.GetAddrVM.GetWard { (model) in
                                    guard let model = model else {
                                        return
                                    }
                                    if model.code == 1{
                                        self.listWard = model.data
                                    }
                                }
                            }
                            actionSheet.addAction(location)
                        }
                    default:
                        for i in self.listWard {
                            let location = UIAlertAction(title: i.WardName, style: .default) { (action) in
                                cell.changeWard(i.WardName)
                                
                            }
                            actionSheet.addAction(location)
                        }
                    }
                    actionSheet.addAction(cancel)
                    self.present(actionSheet, animated: true, completion: nil)
                }
                return cell
            }
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "EditGenderCell", for: indexPath) as! EditGenderCell
            cell.bindData(CurrentProfile!.gender)
            cell.isUserInteractionEnabled = self.isEdit
            return cell
        }
    }
    
    
}
