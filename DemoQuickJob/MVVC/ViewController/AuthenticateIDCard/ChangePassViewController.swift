//
//  ChangePassViewController.swift
//  DemoQuickJob
//
//  Created by HongDang on 7/24/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class ChangePassViewController: UIViewController {

    @IBOutlet var tfPass: [UITextField]!
    @IBOutlet weak var btn: UIButton!
    var profileVM = ProfileViewModel()
    var CommonVM = CommonViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = "Đổi mật khẩu"
        for i in tfPass{
            i.layer.cornerRadius =  20
            btn.layer.cornerRadius = 20
        }
    }
    

    @IBAction func changePass(_ sender: Any) {
        if(tfPass[0].text == "" || tfPass[1].text == "" || tfPass[2].text == ""){
            let alert = UIAlertController(title: "Cảnh báo", message: "", preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            self.CommonVM.showAlert( "Không được để trống", alert)
        }else{
            if (tfPass[0].text == tfPass[1].text ){
                let alert = UIAlertController(title: "Trùng lặp", message: "", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                self.CommonVM.showAlert( "Mật khẩu mới giống mật khâu cũ", alert)
                return
            }
            if (tfPass[1].text == tfPass[2].text ){
                profileVM.old_password = tfPass[0].text!
                profileVM.new_password = tfPass[1].text!
                profileVM.changePass { (model) in
                    guard let model = model else{
                        return
                    }
                    if model.code == "105"{
                        let when = DispatchTime.now() + 4
                        let alert = UIAlertController(title: "", message: "Đổi mật khẩu thành công", preferredStyle: .alert)
                        self.present(alert, animated: true, completion: nil)
                        DispatchQueue.main.asyncAfter(deadline: when){
                            // your code with delay
                            alert.dismiss(animated: true, completion: nil)
                        }
                    }else if model.code == "-105"{
                        let alert = UIAlertController(title: "Mật khẩu cũ sai", message: "", preferredStyle: .alert)
                        self.present(alert, animated: true, completion: nil)
                        self.CommonVM.showAlert( "Mật khẩu cũ bị sai", alert)
                    }else{
                        let alert = UIAlertController(title: "Xảy ra lỗi", message: "", preferredStyle: .alert)
                        self.present(alert, animated: true, completion: nil)
                        self.CommonVM.showAlert( "Không đỏi mật khẩu được", alert)
                    }
                }
            }else{
                let alert = UIAlertController(title: "Mật khẩu mới sai", message: "", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                self.CommonVM.showAlert( "Xác nhận mật khẩu mới không khớp", alert)
            }
        }
        
        
    }
    
}
