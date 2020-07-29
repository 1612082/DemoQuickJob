//
//  ForgotPassViewController.swift
//  DemoQuickJob
//
//  Created by HongDang on 7/24/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class ForgotPassViewController: UIViewController {

    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var btn: UIButton!
    var LoginVM = LobbyViewModel()
    var CommonVM = CommonViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false

        // Do any additional setup after loading the view.
        tfEmail.layer.cornerRadius = 10
        btn.layer.cornerRadius = 20
        navigationItem.title = "Quên mật khẩu"

    }
    
    @IBAction func sendEmail(_ sender: Any) {
        if CommonVM.isValidEmail(tfEmail.text!){
            LoginVM.email = tfEmail.text!
            LoginVM.ForgotPass { (model) in
                guard let model = model else {
                    return
                }
                if model.code == "108"{
                    let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
                    self.present(alert, animated: true, completion: nil)
                    self.CommonVM.showAlert( "Gửi password mới thành công \(model.code)", alert)
                }else{
                    let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
                    self.present(alert, animated: true, completion: nil)
                    self.CommonVM.showAlert( "Gửi password mới thất bại", alert)
                }
            }
            
        }else{
            let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            self.CommonVM.showAlert( "Email không đúng định dạng", alert)
        }
        
    }
    
}
