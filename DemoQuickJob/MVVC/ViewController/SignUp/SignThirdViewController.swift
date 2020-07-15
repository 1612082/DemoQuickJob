//
//  SignThirdViewController.swift
//  DemoQuickJob
//
//  Created by HongDang on 6/5/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class SignThirdViewController: UIViewController {

    //MARK: IBOUTLETS
    
   
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var tfPass: UITextField!
    @IBOutlet weak var tfConfirm: UITextField!
    //MARK: OTHER VARIABLES
    var userSignup:USERSIGNUP?
    var signupVM = SignupViewModel()
    
    
    //MARK: VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupVar()
        setupUI()
    }

    //MARK: - SETUP VAR
    func setupVar() {
        
    }
    
    //MARK: - SETUP UI
    func setupUI() {
        signupVM.setupBtn(btn)
    }
    @IBAction func signUp(_ sender: Any) {
        if tfPass.text != "" && tfConfirm.text != ""{
            if tfPass.text == tfConfirm.text{
                userSignup?.password = tfPass.text!
                userSignup?.confirm = tfPass.text!
                print(userSignup!)
                signupVM.passData(userSignup!)
                signupVM.signup { (model) in
                    guard let model = model else {
                        return
                    }
                    if model.code == "102"{
                        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
                        self.present(alert, animated: true, completion: nil)
                        self.signupVM.showAlert( "Tạo công việc mới thành công", alert)
                        self.navigationController?.popToRootViewController(animated: true)
                        
                    } else {
                        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
                        self.present(alert, animated: true, completion: nil)
                        self.signupVM.showAlert( "Tạo tài khoản mới thất bại \(model.code)", alert)
                    }
                }
            }else{
                let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                self.signupVM.showAlert( "Mật khẩu không trùng khớp", alert)
            }
            
        } else {
            let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            self.signupVM.showAlert( "Phải điền đày đủ thông tin", alert)
        }
        
    }
    
}
