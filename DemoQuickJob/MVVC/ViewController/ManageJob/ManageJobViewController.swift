//
//  ManageJobViewController.swift
//  DemoQuickJob
//
//  Created by HongDang on 4/18/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit
var cateManage:Int = 0

class ManageJobViewController: UIViewController {
    
    //MARK: IBOUTLETS
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pushJobBtn: UIButton!
    //MARK: OTHER VARIABLES
    var ManageVM = ManageJobViewModel()
    var dataSchedule:DataSchedule?
    
    var allApplicant:[JobAllApply?] = []
    var DangTuyenAppli:[JobAllApply?] = []
    var DaTuyenChuaLam:[JobAllApply?] = []
    var DaTuyenDangLam:[JobAllApply?] = []
    var DaTuyenLamXong:[JobAllApply?] = []
    var DaTuyenHetHan:[JobAllApply?] = []
    var allJobPost:[JobAllPost?] = []
    var DangTuyen:[JobAllPost?] = []
    var DangLam:[JobAllPost?] = []
    var LamXong:[JobAllPost?] = []
    var HetHanCoNguoi:[JobAllPost?] = []
    var HetHanKoNguoi:[JobAllPost?] = []
    var flag = ""
    var CommonVC = CommonViewModel()
    var LoadingView = UIView()
    //MARK: VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        setupVar()
        callAPI()
    }
    override func viewWillAppear(_ animated: Bool) {
        fillData()
        //        allApplicant = []
        //        allJobPost = []
        tableView.reloadData()
    }
    //MARK: - SETUP VAR
    func setupVar() {
        
    }
    
    //MARK: - SETUP UI
    func setupUI() {
        pushJobBtn.layer.cornerRadius = 20
        navigationItem.title = "Quản lý công việc"
        
    }
    
    //MARK: - CALL API
    func callAPI() {
        
        fillData()
    }
    
    //MARK: - FILL AND BIND DATA
    func fillData() {
        ManageVM.token = token
//        CommonVC.Loading(&self.LoadingView, self.view)
        ManageVM.getSchedule { (model) in
            self.LoadingView.removeFromSuperview()
            guard let model = model else {
                return
            }
            if model.code == "200"{
                self.dataSchedule = model.data
                self.tableView.reloadData()
                
            } else {
                print(model.code)
            }
        }
        
        
        ManageVM.GetAllApplicant { (model) in
            self.LoadingView.removeFromSuperview()
            guard let model = model else {
                return
            }
            if model.code == "200"{
                self.allApplicant = model.data.jobList
                self.tableView.reloadData()
                
            } else {
                print(model.code)
            }
        }
        ManageVM.GetAllPostJob { (model) in
            self.LoadingView.removeFromSuperview()
            guard let model = model else {
                return
            }
            if model.code == "200"{
                
                self.allJobPost = model.data.jobList
                self.tableView.reloadData()
            } else {
                print(model.code)
            }
        }
        
    }
    
    //MARK: - BUTTON ACTIONS
    @IBAction func pushJob(_ sender: UIButton) {
        let lawlVC = PushJob_Storyboard.instantiateViewController(identifier: "LawViewController") as LawViewController
        navigationController?.pushViewController(lawlVC, animated: true)
    }
    
    
    
}
extension ManageJobViewController:UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        switch cateManage {
        case 0:
            return 2
        case 1:
            return 6
        default:
            return 6
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch cateManage {
        case 0:
            return ""
        case 1:
            switch section {
            case 0:
                return ""
            case 1:
                return "Đang tuyển"
            case 2:
                return "Đã tuyển nhưng chưa làm"
            case 3:
                return "Đang làm"
            case 4:
                return "Làm xong"
            default:
                return "Được tuyển nhưng hết hạn"
            }
        default:
            switch section {
            case 0:
                return ""
            case 1:
                return "Đang tuyển"
            case 2:
                return "Đang làm"
            case 3:
                return "Làm xong"
            case 4:
                return "Hết hạn có người đăng ký"
            default:
                return "Hết hạn không có người đăng ký"
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch cateManage {
        case 0:
            return 1
        case 1:
            switch section {
            case 0:
                return 1
            case 1:
                self.DangTuyenAppli = allApplicant.filter {
                    print($0!.applicant_status, $0!.id_status)
                    return $0!.applicant_status == 0
                }
                return DangTuyenAppli.count
            case 2:
                self.DaTuyenChuaLam = allApplicant.filter { $0!.applicant_status == 1 && $0!.id_status == 1 }
                return DaTuyenChuaLam.count
            case 3:
                self.DaTuyenDangLam = allApplicant.filter { $0!.applicant_status == 1 && $0!.id_status == 2 }
                return DaTuyenDangLam.count
            case 4:
                self.DaTuyenLamXong = allApplicant.filter { $0!.applicant_status == 1 && $0!.id_status == 3 }
                return DaTuyenLamXong.count
            default:
                self.DaTuyenHetHan = allApplicant.filter { $0!.applicant_status == 1 && $0!.id_status == 4 }
                return DaTuyenHetHan.count
            }
        default:
            
            switch section {
            case 0:
                return 1
            case 1:
                self.DangTuyen = self.allJobPost.filter {
                    return $0!.id_status == 1
                }
                return DangTuyen.count
            case 2:
                self.DangLam = self.allJobPost.filter { $0!.id_status == 2 }
                return DangLam.count
            case 3:
                self.LamXong = self.allJobPost.filter { $0!.id_status == 3 }
                return LamXong.count
            case 4:
                self.HetHanCoNguoi = self.allJobPost.filter { $0!.id_status == 4 }
                return HetHanCoNguoi.count
            default:
                self.HetHanKoNguoi = self.allJobPost.filter { $0!.id_status == -1 }
                return HetHanKoNguoi.count
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderManageCell", for: indexPath) as! HeaderManageCell
            cell.idManage = cateManage
            cell.didChangCate = { id in
                cateManage = id
                cell.collectionView.reloadData()
                tableView.reloadData()
            }
            return cell
        case 1:
            switch cateManage {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "CalenderCell", for: indexPath) as! CalenderCell
                cell.selectionStyle = .none
                if dataSchedule != nil{
                    cell.dataSchedule = self.dataSchedule
                    cell.filterFromSchedule(self.dataSchedule!)
                }
                cell.collectionView.reloadData()
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "JobCell", for: indexPath) as! JobCell
                cell.selectionStyle = .none
                cell.bindData2(self.DangTuyenAppli[indexPath.row]!)
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ContentManageCell", for: indexPath) as! ContentManageCell
                cell.bindData(self.DangTuyen[indexPath.row]!)
                cell.selectionStyle = .none
                return cell
            }
        case 2:
            switch cateManage {
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "JobCell", for: indexPath) as! JobCell
                cell.selectionStyle = .none
                cell.bindData2(self.DaTuyenChuaLam[indexPath.row]!)
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ContentManageCell", for: indexPath) as! ContentManageCell
                cell.bindData(self.DangLam[indexPath.row]!)
                cell.selectionStyle = .none
                return cell
            }
        case 3:
            switch cateManage {
                
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "JobCell", for: indexPath) as! JobCell
                cell.selectionStyle = .none
                cell.bindData2(self.DaTuyenDangLam[indexPath.row]!)
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ContentManageCell", for: indexPath) as! ContentManageCell
                cell.bindData(self.LamXong[indexPath.row]!)
                cell.selectionStyle = .none
                return cell
            }
        case 4:
            switch cateManage {
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "JobCell", for: indexPath) as! JobCell
                cell.selectionStyle = .none
                cell.bindData2(self.DaTuyenLamXong[indexPath.row]!)
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ContentManageCell", for: indexPath) as! ContentManageCell
                cell.bindData(self.HetHanCoNguoi[indexPath.row]!)
                cell.selectionStyle = .none
                return cell
            }
        default:
            switch cateManage {
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "JobCell", for: indexPath) as! JobCell
                cell.selectionStyle = .none
                cell.bindData2(self.DaTuyenHetHan[indexPath.row]!)
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ContentManageCell", for: indexPath) as! ContentManageCell
                cell.bindData(self.HetHanKoNguoi[indexPath.row]!)
                cell.selectionStyle = .none
                return cell
            }
            
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            
            let orient = UIApplication.shared.statusBarOrientation
            
            switch orient {
                
            case .portrait:
                self.tableView.reloadData()
                print("Portrait")
                
            case .landscapeLeft,.landscapeRight :
                self.tableView.reloadData()
                print("Landscape")
                
            default:
                
                print("")
            }
            
        }, completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            //refresh view once rotation is completed not in will transition as it returns incorrect frame size.Refresh here
            
        })
        super.viewWillTransition(to: size, with: coordinator)
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if cateManage == 1 {
            var listTouch:[JobAllApply?] = []
            switch indexPath.section {
            case 1:
                listTouch = DangTuyenAppli
            case 2:
                listTouch = DaTuyenChuaLam
            case 3:
                listTouch = DaTuyenDangLam
            case 4:
                listTouch = DaTuyenLamXong
            default:
                listTouch = DaTuyenHetHan

            }
            if listTouch[indexPath.row]!.job_type == false{
                let detailVC = Home_Storyboard.instantiateViewController(identifier: "DetailJTimeViewController") as DetailJTimeViewController
                detailVC.idJob = listTouch[indexPath.row]?.id_job
                navigationController?.pushViewController(detailVC, animated: true)
            } else {
                let detailVC = Home_Storyboard.instantiateViewController(identifier: "DetailJprodViewController") as DetailJprodViewController
                detailVC.idJob = listTouch[indexPath.row]?.id_job
                navigationController?.pushViewController(detailVC, animated: true)
            }
        }else if cateManage == 2 {
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            var listTouch:[JobAllPost?] = []
            switch indexPath.section {
            case 1:
                listTouch = DangTuyen
            case 2:
                listTouch = DangLam
            case 3:
                listTouch = LamXong
            case 4:
                listTouch = HetHanCoNguoi
                
            default:
                listTouch = HetHanKoNguoi

            }
            if listTouch[indexPath.row]?.id_status == 1{
                
                alert.addAction(UIAlertAction(title: "Quản lý ứng viên", style: .default , handler:{ (UIAlertAction)in
                    let detailVC = Main_Storyboard.instantiateViewController(identifier: "ManageApplicantViewController") as ManageApplicantViewController
                    detailVC.id_status = listTouch[indexPath.row]!.id_status
                    detailVC.idJob = "\(listTouch[indexPath.row]!.id_job)"
                    detailVC.jobTitle = listTouch[indexPath.row]!.title
                    self.navigationController?.pushViewController(detailVC, animated: true)
                }))
                alert.addAction(UIAlertAction(title: "Kết thúc công việc", style: .default , handler:{ [weak alert, weak self] (_)in
                    let alert2 = UIAlertController(title: "Xác nhận xong công việc", message: "Bạn muốn kết thúc công việc", preferredStyle: .alert)
                    alert2.addAction(UIAlertAction(title: "Kết thúc", style: .default, handler:{ (UIAlertAction)in
                        self?.DoneJob("\(listTouch[indexPath.row]!.id_job)", listTouch[indexPath.row]!.title)
                    }))
                    alert2.addAction(UIAlertAction(title: "Huỷ", style: .default, handler:{ (UIAlertAction)in
                    }))
                    self?.present(alert2, animated: true, completion: nil)
                }))
                
                
                alert.addAction(UIAlertAction(title: "Xem và Sửa công việc", style: .default , handler:{ (UIAlertAction)in
                    let detailVC = PushJob_Storyboard.instantiateViewController(identifier: "PersonalPushJobViewController") as PersonalPushJobViewController
                    detailVC.idJobEdit = listTouch[indexPath.row]!.id_job
                    detailVC.isEdit = true
                    self.navigationController?.pushViewController(detailVC, animated: true)
                }))
                
                alert.addAction(UIAlertAction(title: "Ngừng tuyển/Bắt đầu công việc", style: .default , handler:{ [weak alert, weak self] (_) in
                    
                    let innerAlert = UIAlertController(title: "Xác nhận ngừng tuyển", message: "Bạn muốn ngừng tuyển ứng viên", preferredStyle: .alert)
                    innerAlert.addAction(UIAlertAction(title: "Ngừng", style: .default, handler:{ (UIAlertAction)in
                        self?.StopApply("\(listTouch[indexPath.row]!.id_job)")
                    }))
                    innerAlert.addAction(UIAlertAction(title: "Huỷ", style: .default, handler:{ (UIAlertAction)in
                    }))
                    self?.present(innerAlert, animated: true, completion: nil)
                }))
                
                alert.addAction(UIAlertAction(title: "Xoá công việc", style: .destructive, handler:{ [weak alert, weak self] (_)in
                    
                    let alert2 = UIAlertController(title: "Xác nhận xoá", message: "Bạn thực sự muốn xoá", preferredStyle: .alert)
                    alert2.addAction(UIAlertAction(title: "Xoá", style: .default, handler:{ (UIAlertAction)in
                        self?.RemoveJob("\(listTouch[indexPath.row]!.id_job)")
                    }))
                    alert2.addAction(UIAlertAction(title: "Huỷ", style: .default, handler:{ [weak alert, weak self] (_)in
                    }))
                    self?.present(alert2, animated: true, completion: nil)
                    
                }))
                alert.addAction(UIAlertAction(title: "Đóng", style: .cancel, handler:{ (UIAlertAction)in
                }))
            }else if listTouch[indexPath.row]?.id_status == 2{
                alert.addAction(UIAlertAction(title: "Báo cáo ứng viên", style: .default , handler:{ (UIAlertAction)in
                    let detailVC = Main_Storyboard.instantiateViewController(identifier: "ManageApplicantViewController") as ManageApplicantViewController
                    detailVC.id_status = listTouch[indexPath.row]!.id_status
                    detailVC.idJob = "\(listTouch[indexPath.row]!.id_job)"
                    self.navigationController?.pushViewController(detailVC, animated: true)
                }))
                alert.addAction(UIAlertAction(title: "Đóng", style: .cancel, handler:{ (UIAlertAction)in
                }))
            }else if listTouch[indexPath.row]?.id_status == 3{
                alert.addAction(UIAlertAction(title: "Nhận xét ứng viên", style: .default , handler:{ (UIAlertAction)in
                    let detailVC = Main_Storyboard.instantiateViewController(identifier: "ManageApplicantViewController") as ManageApplicantViewController
                    detailVC.idJob = "\(listTouch[indexPath.row]!.id_job)"
                    detailVC.id_status = listTouch[indexPath.row]!.id_status
                    self.navigationController?.pushViewController(detailVC, animated: true)
                }))
                alert.addAction(UIAlertAction(title: "Đóng", style: .cancel, handler:{ (UIAlertAction)in
                }))
            } else if listTouch[indexPath.row]?.id_status == 4{
                alert.addAction(UIAlertAction(title: "Quản lý ứng viên", style: .default , handler:{ (UIAlertAction)in
                    let detailVC = Main_Storyboard.instantiateViewController(identifier: "ManageApplicantViewController") as ManageApplicantViewController
                    detailVC.id_status = listTouch[indexPath.row]!.id_status
                    detailVC.idJob = "\(listTouch[indexPath.row]!.id_job)"
                    self.navigationController?.pushViewController(detailVC, animated: true)
                }))
                alert.addAction(UIAlertAction(title: "Ngừng tuyển/Bắt đầu công việc", style: .default , handler:{ [weak alert, weak self] (_) in
                    
                    let innerAlert = UIAlertController(title: "Xác nhận ngừng tuyển", message: "Bạn muốn ngừng tuyển ứng viên", preferredStyle: .alert)
                    innerAlert.addAction(UIAlertAction(title: "Ngừng", style: .default, handler:{ (UIAlertAction)in
                        self?.StopApply("\(listTouch[indexPath.row]!.id_job)")
                    }))
                    innerAlert.addAction(UIAlertAction(title: "Huỷ", style: .default, handler:{ (UIAlertAction)in
                    }))
                    self?.present(innerAlert, animated: true, completion: nil)
                }))
                alert.addAction(UIAlertAction(title: "Xoá công việc", style: .destructive, handler:{ [weak alert, weak self] (_)in
                    
                    let alert2 = UIAlertController(title: "Xác nhận xoá", message: "Bạn thực sự muốn xoá", preferredStyle: .alert)
                    alert2.addAction(UIAlertAction(title: "Xoá", style: .default, handler:{ (UIAlertAction)in
                        self?.RemoveJob("\(listTouch[indexPath.row]!.id_job)")
                    }))
                    alert2.addAction(UIAlertAction(title: "Huỷ", style: .default, handler:{ [weak alert, weak self] (_)in
                    }))
                    self?.present(alert2, animated: true, completion: nil)
                    
                }))
                alert.addAction(UIAlertAction(title: "Đóng", style: .cancel, handler:{ (UIAlertAction)in
                }))
            }else{
                alert.addAction(UIAlertAction(title: "Đóng", style: .cancel, handler:{ (UIAlertAction)in
                }))
            }
            self.present(alert, animated: true, completion: {
                
            })
        }
    }
    
    func RemoveJob(_ idJob:String){
        self.ManageVM.id_job = idJob
        self.ManageVM.token = token
        self.ManageVM.DeleteJob { (model) in
            guard let model = model else {
                return
            }
            if model.code == "202"{
                let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                self.CommonVC.showAlert( "Xoá thành công", alert)
                self.tableView.reloadData()
            } else {
                let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                self.CommonVC.showAlert( "Xoá thất bại \(model.code)", alert)
            }
        }
    }
    func DoneJob(_ idJob:String, _ title:String){
        self.ManageVM.id_job = idJob
        self.ManageVM.job_title = title
        self.ManageVM.token = token
        self.ManageVM.DoneJob { (model) in
            guard let model = model else {
                return
            }
            if model.code == "202"{
                let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                self.CommonVC.showAlert( "Công việc đã kết thúc", alert)
                self.tableView.reloadData()
            } else {
                let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                self.CommonVC.showAlert( "Kết thúc công việc thất bại \(model.code)", alert)
            }
        }
    }
    func StopApply(_ idJob:String){
        self.ManageVM.id_job = idJob
        self.ManageVM.token = token
        self.ManageVM.StopApply { (model) in
            guard let model = model else {
                return
            }
            if model.code == "202"{
                let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                self.CommonVC.showAlert( "Ngưng thành công", alert)
                self.tableView.reloadData()
            } else {
                let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                self.CommonVC.showAlert( "Ngưng thất bại \(model.code)", alert)
            }
        }
    }
    func removeApplicant(_ idUser:String, _ idJob:String, _ i:Int){
        self.ManageVM.id_user = idUser
        self.ManageVM.id_job = idJob
        self.ManageVM.CancelApply { (model) in
            guard let model = model else {
                return
            }
            if model.code == "202"{
                let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                self.CommonVC.showAlert( "Xoá thành công", alert)
                self.allApplicant.remove(at: i)
                self.tableView.reloadData()
            } else {
                let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                self.CommonVC.showAlert( "Xoá thất bại \(model.code)", alert)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        var listTouch:[JobAllApply?] = []
        switch indexPath.section {
        case 1:
            listTouch = DangTuyenAppli
        case 2:
            listTouch = DaTuyenChuaLam
        case 3:
            listTouch = DaTuyenDangLam
        case 4:
            listTouch = DaTuyenLamXong
        default:
            listTouch = DaTuyenHetHan
        }
        if cateManage == 1{
            if listTouch[indexPath.row]?.id_status == 1{
                let delete = UITableViewRowAction(style: .default, title: "Huỷ Đăng ký") { (action, indexPath) in
                    let alert2 = UIAlertController(title: "Xác nhận xoá", message: "Bạn thực sự muốn xoá", preferredStyle: .alert)
                    alert2.addAction(UIAlertAction(title: "Xoá", style: .default, handler:{ (UIAlertAction)in
                        self.removeApplicant("\(currentUser!.id_user)", "\(listTouch[indexPath.row]!.id_job)" , indexPath.row)
                    }))
                    alert2.addAction(UIAlertAction(title: "Huỷ", style: .default, handler:{ (UIAlertAction)in
                    }))
                    self.present(alert2, animated: true, completion: nil)
                    
                }
                return [delete]
            } else if listTouch[indexPath.row]?.id_status == 2{
                let report = UITableViewRowAction(style: .default, title: "Báo cáo") { (action, indexPath) in
                    let ReportVC = Home_Storyboard.instantiateViewController(withIdentifier: "ReportViewController") as! ReportViewController
                    ReportVC.idApplicant = listTouch[indexPath.row]?.id_applicant
                    ReportVC.idJob = "\(listTouch[indexPath.row]!.id_job)"
                    ReportVC.reporterId = listTouch[indexPath.row]?.employer
                    ReportVC.yourRole = 0
                    self.navigationController?.pushViewController(ReportVC, animated: true)
                }
                let ToFire = UITableViewRowAction(style: .destructive, title: "Sa thải") { action, index in
                    let ReportVC = Home_Storyboard.instantiateViewController(withIdentifier: "ReportViewController") as! ReportViewController
                    ReportVC.idApplicant = listTouch[indexPath.row]?.id_applicant
                    ReportVC.idJob = "\(listTouch[indexPath.row]!.id_job)"
                    ReportVC.reporterId = listTouch[indexPath.row]?.employer
                    ReportVC.yourRole = 1
                    ReportVC.typ = 1
                    self.navigationController?.pushViewController(ReportVC, animated: true)
                }
                return [report,ToFire]
            } else if listTouch[indexPath.row]?.id_status == 3{
                let review = UITableViewRowAction(style: .default, title: "Đánh giá") { (action, indexPath) in
                    
                    let ReviewVC = Home_Storyboard.instantiateViewController(withIdentifier: "ReviewViewController") as! ReviewViewController
                    ReviewVC.idApplicant = listTouch[indexPath.row]?.id_applicant
                    ReviewVC.idJob = "\(listTouch[indexPath.row]!.id_job)"
                    ReviewVC.status = false
                    self.navigationController?.pushViewController(ReviewVC, animated: true)
                }
                return [review]
            } else{
                let delete = UITableViewRowAction(style: .default, title: "Huỷ Đăng ký") { (action, indexPath) in
                    let alert2 = UIAlertController(title: "Xác nhận xoá", message: "Bạn thực sự muốn xoá", preferredStyle: .alert)
                    alert2.addAction(UIAlertAction(title: "Xoá", style: .default, handler:{ (UIAlertAction)in
                        self.removeApplicant("\(currentUser!.id_user)", "\(listTouch[indexPath.row]!.id_job)" , indexPath.row)
                    }))
                    alert2.addAction(UIAlertAction(title: "Huỷ", style: .default, handler:{ (UIAlertAction)in
                    }))
                    self.present(alert2, animated: true, completion: nil)
                    
                }
                return [delete]
            }
            
        } 
        return []
        
        
    }
}


