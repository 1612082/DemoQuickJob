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
    var allApplicant:[JobAllApply?] = []
    var allJobPost:[JobAllPost?] = []
    var flag = ""
    var CommonVC = CommonViewModel()
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
    }
    //MARK: - SETUP VAR
    func setupVar() {
        
    }
    
    //MARK: - SETUP UI
    func setupUI() {
        pushJobBtn.layer.cornerRadius = 20
    }
    
    //MARK: - CALL API
    func callAPI() {
        
        fillData()
    }
    
    //MARK: - FILL AND BIND DATA
    func fillData() {
        ManageVM.token = token
        ManageVM.GetAllApplicant { (model) in
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
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            if cateManage == 0{
                return 1
            } else if cateManage == 1{
                return allApplicant.count
            } else {

                return allJobPost.count
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
        default:
            if cateManage == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: "CalenderCell", for: indexPath) as! CalenderCell
                cell.selectionStyle = .none
                cell.collectionView.reloadData()
                return cell
            } else if cateManage == 1{
                let cell = tableView.dequeueReusableCell(withIdentifier: "JobCell", for: indexPath) as! JobCell
                cell.selectionStyle = .none
                cell.bindData2(allApplicant[indexPath.row]!)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ContentManageCell", for: indexPath) as! ContentManageCell
                cell.bindData(allJobPost[indexPath.row]!)
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
            if allApplicant[indexPath.row]!.job_type == false{
                let detailVC = Home_Storyboard.instantiateViewController(identifier: "DetailJTimeViewController") as DetailJTimeViewController
                detailVC.idJob = allApplicant[indexPath.row]?.id_job
                navigationController?.pushViewController(detailVC, animated: true)
            } else {
                let detailVC = Home_Storyboard.instantiateViewController(identifier: "DetailJprodViewController") as DetailJprodViewController
                detailVC.idJob = allApplicant[indexPath.row]?.id_job
                navigationController?.pushViewController(detailVC, animated: true)
            }
        }else if cateManage == 2 {
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            if allJobPost[indexPath.row]?.id_status == 1{
                
                alert.addAction(UIAlertAction(title: "Quản lý ứng viên", style: .default , handler:{ (UIAlertAction)in
                    let detailVC = Main_Storyboard.instantiateViewController(identifier: "ManageApplicantViewController") as ManageApplicantViewController
                    let a = self.allJobPost[indexPath.row]!.id_job
                    detailVC.id_status = self.allJobPost[indexPath.row]!.id_status
                    detailVC.idJob = "\(self.allJobPost[indexPath.row]!.id_job)"
                    self.navigationController?.pushViewController(detailVC, animated: true)
                }))
                alert.addAction(UIAlertAction(title: "Kết thúc công việc", style: .default , handler:{ (UIAlertAction)in
                    
                }))


                alert.addAction(UIAlertAction(title: "Xem và Sửa công việc", style: .default , handler:{ (UIAlertAction)in
                    let detailVC = PushJob_Storyboard.instantiateViewController(identifier: "PersonalPushJobViewController") as PersonalPushJobViewController
                    detailVC.idJobEdit = self.allJobPost[indexPath.row]!.id_job
                    detailVC.isEdit = true
                    self.navigationController?.pushViewController(detailVC, animated: true)
                }))

                alert.addAction(UIAlertAction(title: "Ngừng tuyển", style: .default , handler:{ (UIAlertAction)in
                    self.flag = "StopApply"
                }))

                alert.addAction(UIAlertAction(title: "Xoá công việc", style: .destructive, handler:{ (UIAlertAction)in
                    self.flag = "deleteJob"
                    
                }))
                alert.addAction(UIAlertAction(title: "Đóng", style: .cancel, handler:{ (UIAlertAction)in
                }))
            }else if allJobPost[indexPath.row]?.id_status == 2{
                alert.addAction(UIAlertAction(title: "Báo cáo ứng viên", style: .default , handler:{ (UIAlertAction)in
                    let detailVC = Main_Storyboard.instantiateViewController(identifier: "ManageApplicantViewController") as ManageApplicantViewController
                    let a = self.allJobPost[indexPath.row]!.id_job
                    detailVC.id_status = self.allJobPost[indexPath.row]!.id_status
                    detailVC.idJob = "\(self.allJobPost[indexPath.row]!.id_job)"
                    self.navigationController?.pushViewController(detailVC, animated: true)
                }))
            }else{
                alert.addAction(UIAlertAction(title: "Nhận xét ứng viên", style: .default , handler:{ (UIAlertAction)in
                    let detailVC = Main_Storyboard.instantiateViewController(identifier: "ManageApplicantViewController") as ManageApplicantViewController
                    let a = self.allJobPost[indexPath.row]!.id_job
                    detailVC.idJob = "\(self.allJobPost[indexPath.row]!.id_job)"
                    detailVC.id_status = self.allJobPost[indexPath.row]!.id_status
                    self.navigationController?.pushViewController(detailVC, animated: true)
                }))
            }
            self.present(alert, animated: true, completion: {
                if self.flag == "deleteJob"{
                    self.dismiss(animated: true) {
                        let alert2 = UIAlertController(title: "Xác nhận xoá", message: "Bạn thực sự muốn xoá", preferredStyle: .alert)
                        alert2.addAction(UIAlertAction(title: "Xoá", style: .default, handler:{ (UIAlertAction)in
                            self.RemoveJob(indexPath.row)
                        }))
                        alert2.addAction(UIAlertAction(title: "Huỷ", style: .default, handler:{ (UIAlertAction)in
                        }))
                        self.present(alert2, animated: true, completion: nil)
                    }
                }
            })
        }
    }
    
    func RemoveJob(_ i:Int){
        self.ManageVM.id_job = "\(self.allJobPost[i]!.id_job)"
        self.ManageVM.token = token
        self.ManageVM.DeleteJob { (model) in
            guard let model = model else {
                return
            }
            if model.code == "202"{
                let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                self.ManageVM.showAlert( "Xoá thành công", alert)
                self.allApplicant.remove(at: i)
                self.tableView.reloadData()
            } else {
                let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                self.ManageVM.showAlert( "Xoá thất bại \(model.code)", alert)
            }
        }
    }
    func StopApply(_ i:Int){
        self.ManageVM.id_job = "\(self.allJobPost[i]!.id_job)"
        self.ManageVM.token = token
        self.ManageVM.StopApply { (model) in
            guard let model = model else {
                return
            }
            if model.code == "202"{
                let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                self.ManageVM.showAlert( "Ngưng thành công", alert)
                self.allApplicant.remove(at: i)
                self.tableView.reloadData()
            } else {
                let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                self.ManageVM.showAlert( "Ngưng thất bại \(model.code)", alert)
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
                self.ManageVM.showAlert( "Xoá thành công", alert)
                self.allApplicant.remove(at: i)
                self.tableView.reloadData()
            } else {
                let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                self.ManageVM.showAlert( "Xoá thất bại \(model.code)", alert)
            }
        }
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if cateManage == 1{
            let delete = UITableViewRowAction(style: .default, title: "Huỷ Đăng ký") { (action, indexPath) in
                let alert2 = UIAlertController(title: "Xác nhận xoá", message: "Bạn thực sự muốn xoá", preferredStyle: .alert)
                alert2.addAction(UIAlertAction(title: "Xoá", style: .default, handler:{ (UIAlertAction)in
                    self.removeApplicant("\(currentUser!.id_user)", "\(self.allApplicant[indexPath.row]!.id_job)" , indexPath.row)
                }))
                alert2.addAction(UIAlertAction(title: "Huỷ", style: .default, handler:{ (UIAlertAction)in
                }))
                self.present(alert2, animated: true, completion: nil)
                
            }
            let review = UITableViewRowAction(style: .default, title: "Đánh giá") { (action, indexPath) in
                let vc = Home_Storyboard.instantiateViewController(withIdentifier: "ReviewViewController" ) as! ReviewViewController
//                vc.idApplicant = self.allApplicant[indexPath.row]?.
                self.navigationController?.pushViewController(vc, animated: true)
            }
            let report = UITableViewRowAction(style: .default, title: "Báo cáo") { (action, indexPath) in
                
            }
            switch self.allApplicant[indexPath.row]?.id_status {
            case 1:
                return [delete]
            case 2:
                return [delete,report]
            default:
                return [review]
            }
        } 
        return []
        
        
    }
}


