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

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var SignUpBtn: UIButton!
    
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPass: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        SetupUI()
    }
    func SetupUI(){
        setupBtn(loginBtn)
        setupBtn(SignUpBtn)
        setupTF(tfUsername)
        setupTF(tfPass)
    }
    func setupBtn(_ btn:UIButton){
        btn.layer.borderWidth = 3
        btn.layer.borderColor = UIColor.white.cgColor
        btn.layer.cornerRadius = 20
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    func setupTF(_ tf:UITextField){
        tf.backgroundColor = UIColor.clear
        tf.heightAnchor.constraint(equalToConstant: 50).isActive = true
        tf.font = UIFont(name: "", size: 20)
    }
    @IBAction func Login(_ sender: Any) {
        let scene = self.view.window?.windowScene?.delegate as! SceneDelegate
        scene.GoToTabbar()
    }
    @IBAction func Signup(_ sender: Any) {
    }
    

}

