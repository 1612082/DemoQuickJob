//
//  SignFirstViewController.swift
//  DemoQuickJob
//
//  Created by HongDang on 6/5/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class SignFirstViewController: UIViewController {
    
    //MARK: IBOUTLETS
    
    
    @IBOutlet weak var genre: UISegmentedControl!
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var tfGmail: UITextField!
    @IBOutlet weak var tfNickname: UITextField!
    @IBOutlet weak var tfPhoneNumber: UITextField!
    //MARK: OTHER VARIABLES
    var userSignup:USERSIGNUP = USERSIGNUP(email: "", password: "", dob: "", fullname: "", dial: "", gender: -1, addr: "", confirm: "m")
    let signupVM = SignupViewModel()
    var LoginVM = LobbyViewModel()
    var GetAddrVM = GetAddrViewModel()
    var commonVC = CommonViewModel()
    //MARK: VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupVar()
        setupUI()
    }
    //MARK: - SETUP VAR
    func setupVar() {
        if listProvince.count == 0 {
            GetAddrVM.GetProvince { (model) in
                guard let model = model else{
                    return
                }
                if model.code == 200{
                    listProvince = model.data
                }
            }
        }
    }
    
    //MARK: - SETUP UI
    func setupUI() {
        tfPhoneNumber.keyboardType = .numberPad
        signupVM.setupBtn(btn)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func next(_ sender: Any) {
        if (tfGmail.text != "" && tfNickname.text != "" && tfPhoneNumber.text != ""){
            userSignup.email = tfGmail.text!
            userSignup.fullname = tfNickname.text!
            userSignup.dial = tfPhoneNumber.text!
            userSignup.gender = genre.selectedSegmentIndex
            let signupSecondVC = Main_Storyboard.instantiateViewController(withIdentifier: "SignSecondViewController") as! SignSecondViewController
            signupSecondVC.userSignup = userSignup
            navigationController?.pushViewController(signupSecondVC, animated: true)
        } else{
            let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            self.commonVC.showAlert( "Phải điền đày đủ thông tin", alert)
        }
        
    }
    

   

}
