//
//  PersonalPushJobViewController.swift
//  DemoQuickJob
//
//  Created by HongDang on 5/18/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit


class PersonalPushJobViewController: UIViewController {
    
    
 
    //MARK: IBOUTLETS
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var doneBtn: UIButton!
    
    //MARK: OTHER VARIABLES
    let HighFilterVM = HighFilterViewModel()
    var arrTag:[Int] = []
    var oneOrMulti:Int = 0
    var arrPhoto:[UIImage] = [#imageLiteral(resourceName: "clickhere")]
    var PushJobVM = PushJobViewModel()
    var JobDetailVM = JobDetailViewModel()
    var idJobEdit:Int = -1
    var isEdit = false
    var dataEdit:TYPEJOBDETAIL?
    override func viewDidLoad() {
        super.viewDidLoad()
        doneBtn.layer.cornerRadius = 20
        // Do any additional setup after loading the view.
        
        setupUI()
        setupVar()
        callAPI()
    }
    override func viewWillAppear(_ animated: Bool) {
        PushJobViewModel.result = TYPEPUSHJOB(employer: currentUser?.id_user ?? -1, title: "", salary: "", job_topic: "", area_province: "", area_district: "", address: "", start_date: "", end_date: "", lat: -1, lng: -1, description: "", expire_date: "", dealable: -1, job_type: "1", isOnline: -1, isCompany: -1, requirement: "", vacancy: "", images: [], tags: [], benefit: "")
    }
        
    //MARK: - SETUP VAR
    func setupVar() {
        
    }
    
    //MARK: - SETUP UI
    func setupUI() {
        if isEdit{
            doneBtn.setTitle("Sửa công việc", for: .normal)
        } else{
            doneBtn.setTitle("Đăng công việc", for: .normal)
        }
        doneBtn.titleLabel?.font =  .systemFont(ofSize: 22)
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
        if isEdit == true{
            self.JobDetailVM.idJob = (self.idJobEdit)
            self.JobDetailVM.GetDetailJob { (model) in
                guard let model = model else {
                    return
                }
                if model.code == "200" {
                    self.dataEdit = model.data
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    //MARK: - BUTTON ACTIONS
    @IBAction func push(_ sender: Any) {
        if isEdit{
            
        } else {
            if PushJobViewModel.result!.title == ""{
                let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                self.PushJobVM.showAlert( "Phải có tên công việc", alert)
            }else if PushJobViewModel.result!.salary == ""{
                let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                self.PushJobVM.showAlert( "Phải có ngân sách cho công việc", alert)
            }else if PushJobViewModel.result!.salary == ""{
                let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                self.PushJobVM.showAlert( "Phải có ngân sách cho công việc", alert)
            }else if PushJobViewModel.result!.start_date == ""{
                let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                self.PushJobVM.showAlert( "Phải có ngày làm việc", alert)
            }else{
                PushJobVM.passData(PushJobViewModel.result!)
                PushJobVM.pushJob { (model) in
                     guard let model = model else {
                        return
                    }
                    if model.code == "201"{
                        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
                        self.present(alert, animated: true, completion: nil)
                        self.PushJobVM.showAlert( "Tạo công việc mới thành công", alert)
                        self.navigationController?.popToRootViewController(animated: true)
                        
                    } else {
                        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
                        self.present(alert, animated: true, completion: nil)
                        self.PushJobVM.showAlert( "Tạo công việc mới thất bại \(model.code)", alert)
                    }
                }
            }
        }
        
        
    }
    
    
}
extension PersonalPushJobViewController: UITableViewDataSource,
UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 8
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Tên công việc"
        case 1:
            return "Nội dung công việc"
        case 2:
            return "Hình ảnh miêu tả công việc (Không bắt buộc)"
        case 3:
            return "Phân loại công việc"
        case 4:
            return "Ngân sách"
        case 5:
            return "Chọn ngày làm việc hay bàn giao sản phẩm"
        case 6:
            return ""
        default:
            return "Tuỳ chọn các tính năng"
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitlePushJobCell", for: indexPath) as! TitlePushJobCell
            cell.selectionStyle = .none
            if isEdit  {
                if dataEdit != nil{
                    cell.bindData(dataEdit!)
                }
                
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ContentPushJobCell", for: indexPath) as! ContentPushJobCell
            cell.selectionStyle = .none
            if isEdit && dataEdit != nil{
                cell.bindData(dataEdit!)
            }
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageContentJobCell", for: indexPath) as! ImageContentJobCell
            cell.arrPhoto = arrPhoto
            cell.didSelectImg = {
                UploadImageFromDevice.shared.showImagePicker(vc: self) { (images) in
                    if images.count != 0{
                        self.arrPhoto = images
                        PushJobViewModel.result!.images = images
                    }                    
                    cell.collectionView.reloadData()
                    tableView.reloadData()
                }
            }
            cell.selectionStyle = .none
            if isEdit && dataEdit != nil{
                cell.bindData(dataEdit!)
            }
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FilterPushJobCell", for: indexPath) as! FilterPushJobCell
            cell.collectionView.reloadData()
            cell.arrTag = arrTag
            cell.didTouch = { id in
                if self.arrTag.contains(id) {
                    self.arrTag.remove(at: self.arrTag.firstIndex(of: id)!)
                }else{
                    self.arrTag.append(id)
                    
                }
                PushJobViewModel.result!.tags = self.arrTag
                tableView.reloadData()
            }
            cell.didShowTopic = {
                let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                for i in listTopic {
                    let location = UIAlertAction(title: i.name, style: .default) { (action) in
                        cell.JobTopic.text = i.name
                        PushJobViewModel.result!.job_topic = "\(i.id_jobtopic)"
                    }
                    actionSheet.addAction(location)
                    
                }
                actionSheet.addAction(cancel)
                self.present(actionSheet, animated: true, completion: nil)
            }
            cell.selectionStyle = .none
            if isEdit && dataEdit != nil{
                cell.bindData(dataEdit!)
            }
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BudgetPushJobCell", for: indexPath) as! BudgetPushJobCell
            cell.selectionStyle = .none
            if isEdit && dataEdit != nil{
                cell.bindData(dataEdit!)
            }
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "StateDateCell", for: indexPath) as! StateDateCell
            cell.selectionStyle = .none
            cell.didChangeStateDate = { selectValue in
                self.oneOrMulti = selectValue
                if selectValue == 0{
                    
                } else{
                    PushJobViewModel.result?.job_type = "0"
                }
               
                self.tableView.reloadData()
            }
            if isEdit && dataEdit != nil{
                if dataEdit?.start_date == dataEdit?.end_date {
                    oneOrMulti = 0
                } else{
                    oneOrMulti = 1
                }
                
                cell.bindData(dataEdit!)
            }
            return cell
        case 6:
             if self.oneOrMulti == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "dateWorkingCell", for: indexPath) as! dateWorkingCell
                if isEdit && dataEdit != nil{
                    cell.bindData(dataEdit!)
                }
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "multiDateWorkingCell", for: indexPath) as! multiDateWorkingCell
                if isEdit && dataEdit != nil{
                    cell.bindData(dataEdit!)
                }
                return cell
            }
            
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OptionsFormCell", for: indexPath) as! OptionsFormCell
            cell.selectionStyle = .none
            if isEdit && dataEdit != nil{
                cell.bindData(dataEdit!)
            }
            return cell
        }
    }
    
    
}

