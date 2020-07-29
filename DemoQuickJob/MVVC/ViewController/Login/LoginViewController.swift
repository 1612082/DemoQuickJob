//
//  ViewController.swift
//  DemoQuickJob
//
//  Created by HongDang on 4/17/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit
import Foundation

class LoginViewController: UIViewController {
    
    //MARK: IBOUTLETS
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var SignUpBtn: UIButton!
    
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPass: UITextField!
    
    //MARK: OTHER VARIABLES
    var LoginVM = LobbyViewModel()
    var LoadingView = UIView()
    var CommonVM = CommonViewModel()
    
    //MARK: LIFE CIRCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupVar()
        setupUI()
        callAPI()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        
    }
    //MARK: - SETUP VAR
    func setupVar() {
        UserDefaults.standard.set(nil, forKey: "isLogin")
        
        
    }
    
    //MARK: - SETUP UI
    func setupUI() {
        setupBtn(loginBtn)
        setupBtn(SignUpBtn)
        setupTF(tfUsername)
        setupTF(tfPass)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func setupBtn(_ btn:UIButton){
        btn.layer.borderWidth = 3
        btn.layer.borderColor = UIColor.white.cgColor
        btn.layer.cornerRadius = 20
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    func setupTF(_ tf:UITextField){
//        tf.backgroundColor = UIColor.clear
        tf.heightAnchor.constraint(equalToConstant: 50).isActive = true
        tf.font = UIFont(name: "", size: 20)
    }
    func login(){
        CommonVM.Loading(&self.LoadingView, self.view)
        self.LoginVM.Login { (model) in
            guard let model = model else {
                self.LoadingView.removeFromSuperview()
                return
            }
            if model.code == "101"{
                //                lay token va luu token
                UserDefaults.standard.set(model.data?.token, forKey: "token")
                currentUser = model.data?.user
                token = model.data!.token
                DispatchQueue.main.async {
                    // chuyen vao man hinh home
                    if UserDefaults.standard.string(forKey: "isLogin") == nil
                    {
                        UserDefaults.standard.set(1, forKey: "isLogin")
                        let scene = self.view.window?.windowScene?.delegate as! SceneDelegate
                        self.LoadingView.removeFromSuperview()
                        scene.GoToTabbar()
                        
                    }
                    
                }
            }else{
                self.LoadingView.removeFromSuperview()
                let when = DispatchTime.now() + 3
                let alert = UIAlertController(title: "", message: "Sai tên đăng nhập hoặc mật khẩu", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                DispatchQueue.main.asyncAfter(deadline: when){
                    // your code with delay
                    alert.dismiss(animated: true, completion: nil)
                }
            }
            
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
    
    @IBAction func Login(_ sender: Any) {
        
        if CommonVM.isValidEmail(tfUsername.text!){
            self.LoginVM.email = tfUsername.text!
            self.LoginVM.password = tfPass.text!
            login()
        }else{
            let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            self.CommonVM.showAlert( "Email không đúng định dạng", alert)
        }
        
    }
    @IBAction func Signup(_ sender: Any) {
        let signupFirstVC = Main_Storyboard.instantiateViewController(withIdentifier: "SignFirstViewController") as! SignFirstViewController
        navigationController?.pushViewController(signupFirstVC, animated: true)
    }
    
    @IBAction func forgotPass(_ sender: Any) {
        let forgotVC = Main_Storyboard.instantiateViewController(withIdentifier: "ForgotPassViewController") as! ForgotPassViewController
        navigationController?.pushViewController(forgotVC, animated: true)
    }
    
}

