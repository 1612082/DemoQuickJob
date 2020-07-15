//
//  ApplyPersonalJobViewController.swift
//  DemoQuickJob
//
//  Created by HongDang on 6/22/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class ApplyPersonalJobViewController: UIViewController {
    

    @IBOutlet weak var moneyTf: UITextField!
    @IBOutlet weak var introduction: UITextView!
    @IBOutlet weak var btnApply: UIButton!
    var ApplicantVM = ApplyJobViewModel()
    var idJob:Int?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupUI()
        setupVar()
    }
    //MARK: - SETUP VAR
    func setupVar() {
        
    }
    
    //MARK: - SETUP UI
    func setupUI() {
        introduction.text = ""
        moneyTf.keyboardType = .numberPad
        btnApply.layer.cornerRadius = 10
    }

    
    //MARK: - BUTTON ACTIONS
    @IBAction func Aplly(_ sender: Any) {
        ApplicantVM.id_job = "\(idJob ?? -1)"
        ApplicantVM.id_user = "\(currentUser!.id_user)"
        ApplicantVM.proposed_price = moneyTf.text ?? ""
        ApplicantVM.introduction_string = introduction.text ?? ""
        if (moneyTf.text != ""){
            ApplicantVM.addApplicant { (model) in
                 guard let model = model else {
                    return
                }
                if model.code == "202"{
                   // the alert view
                    let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
                    self.present(alert, animated: true, completion: nil)
                    self.ApplicantVM.showAlert( "Đăng ký thành công", alert)
                    self.navigationController?.popToRootViewController(animated: true)

                }else if model.code == "-202"{
                    let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
                    self.present(alert, animated: true, completion: nil)
                    self.ApplicantVM.showAlert( "Đăng ký thất bại", alert)
                   
                }else{
                    let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
                    self.present(alert, animated: true, completion: nil)
                    self.ApplicantVM.showAlert( "Lỗi hệ thống \(model.code)", alert)
                }
            }
        } else {
            let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            self.ApplicantVM.showAlert( "Vui lòng điền đầy đủ thông tin", alert)
        }
        
    }
    

}
