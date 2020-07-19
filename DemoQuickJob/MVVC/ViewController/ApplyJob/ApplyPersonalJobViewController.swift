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
    var budget:Int?
    var CommonVC = CommonViewModel()
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
        if (moneyTf.text == "" || (Int(moneyTf.text!)) == nil || (Int(moneyTf.text!)!) < budget! / 2){
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
            CommonVC.showAlert("Số tiền sai quy định hoặc ít hơn 50% ngân sách", alert)
            self.present(alert, animated: true, completion: nil)
        }else{
            ApplicantVM.id_job = "\(idJob ?? -1)"
            ApplicantVM.id_user = "\(currentUser!.id_user)"
            ApplicantVM.proposed_price = moneyTf.text ?? ""
            ApplicantVM.introduction_string = introduction.text ?? ""
            ApplicantVM.addApplicant { (model) in
                 guard let model = model else {
                    return
                }
                if model.code == "202"{
                   // the alert view
                    let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
                    self.present(alert, animated: true, completion: nil)
                    self.CommonVC.showAlert( "Đăng ký thành công", alert)
                    self.navigationController?.popToRootViewController(animated: true)

                }else if model.code == "-202"{
                    let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
                    self.present(alert, animated: true, completion: nil)
                    self.CommonVC.showAlert( "Đăng ký thất bại", alert)
                   
                }else{
                    let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
                    self.present(alert, animated: true, completion: nil)
                    self.CommonVC.showAlert( "Lỗi hệ thống \(model.code)", alert)
                }
            }
        }

        
        
    }
    

}
