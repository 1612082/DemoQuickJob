//
//  ReportViewController.swift
//  DemoQuickJob
//
//  Created by HongDang on 7/18/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class ReportViewController: UIViewController {

    //MARK: IBOUTLETS
    
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var reportContent: UITextView!
    //MARK: OTHER VARIABLES
    var typ:Int?// - int: 0 là báo cáo; 1 là yêu cầu sa thải,
    var idApplicant:Int?// - int,
    var idJob:String?// - int,
    var reporterId:Int?// - int, // id người bị report
    var yourRole:Int?// - int, // vài trò: 0 - người làm, 1 - người thuê;
    var ReportVM = ReviewAndReportViewModel()
    var CommonVM = CommonViewModel()
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
        btn.layer.cornerRadius = 20
        reportContent.layer.borderWidth = 1
    }
    
    //MARK: - CALL API
    func callAPI() {
        
        fillData()
    }
    
    //MARK: - FILL AND BIND DATA
    func fillData() {
        ReportVM.id_user1 = "\(currentUser?.id_user)"
        ReportVM.id_user2 = "\(self.reporterId)"
        ReportVM.type = 1 // phai sua
        ReportVM.id_job = self.idJob!
        ReportVM.loadReport { (model) in
            guard let model = model else{
                return
            }
            if model.code == "200"{
                if model.data?.code == 1{
                    self.reportContent.text = model.data?.report?.content
                    
                }
            }
        }
    }
    
    //MARK: - BUTTON ACTIONS

    @IBAction func report(_ sender: Any) {
        ReportVM.id_applicant = "\(self.idApplicant!)"
        ReportVM.id_job = self.idJob!
        ReportVM.contentReport = reportContent.text
        ReportVM.type = self.typ!
        ReportVM.yourRole = self.yourRole!
        ReportVM.report { (model) in
            guard let model = model else{
                return
            }
            if model.code == "202"{
                let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
                self.CommonVM.showAlert("Báo cáo thành công", alert)
                self.present(alert, animated: true, completion: nil)
            } else{
                let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
                self.CommonVM.showAlert("Báo cáo thất bại \(model.code)", alert)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    

   

}
