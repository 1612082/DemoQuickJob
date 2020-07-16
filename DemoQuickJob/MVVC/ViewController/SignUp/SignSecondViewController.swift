//
//  SignSecondViewController.swift
//  DemoQuickJob
//
//  Created by HongDang on 6/5/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class SignSecondViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: IBOUTLETS
    @IBOutlet weak var btn: UIButton!    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tfDob: UITextField!
    @IBOutlet weak var tfProvice: UITextField!
    @IBOutlet weak var tfDistric: UITextField!
    @IBOutlet weak var tfWard: UITextField!
    
    //MARK: OTHER VARIABLES
    var caseAddr:Int = 0
    var datePicker : UIDatePicker!
    var LoginVM = LobbyViewModel()
    var userSignup:USERSIGNUP?
    let signupVM = SignupViewModel()
    var listDistrict:[DISTRICTGHN] = []
    var listWard:[WARDGHN] = []
    var GetAddrVM = GetAddrViewModel()
    
    
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
        datePicker = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 200))
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(changeDate), for: .valueChanged)
        tfDob.inputView = datePicker
        tfProvice.delegate = self
        tfDistric.delegate = self
        tfWard.delegate = self
        signupVM.setupBtn(btn)
    }
    
    @objc func changeDate(datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        tfDob.text = dateFormatter.string(from: datePicker.date)
        
    }
    
    @IBAction func next(_ sender: Any) {
        if (tfDob.text != nil && tfProvice.text != nil && tfDistric.text != nil && tfWard.text != nil ){
            userSignup?.dob = tfDob.text!
            userSignup?.addr = "\(tfWard.text!) \(tfDistric.text!) \(tfProvice.text!)"
            
        } else {
            userSignup?.dob = ""
            userSignup?.addr = ""
        }
        let signupThirdVC = Main_Storyboard.instantiateViewController(withIdentifier: "SignThirdViewController") as! SignThirdViewController
        signupThirdVC.userSignup = userSignup
        navigationController?.pushViewController(signupThirdVC, animated: true)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        switch textField {
        case tfProvice:
            for i in listProvince {
                let location = UIAlertAction(title: i.ProvinceName, style: .default) { (action) in
                    self.tfProvice.text = i.ProvinceName
                    self.GetAddrVM.provinceID = i.ProvinceID
                    //                    self.listDistictFilter = listDtrict.filter{ $0.ProvinceID == i.id}
                    self.GetAddrVM.GetDistrict {  (model) in
                        guard let model = model else{
                            return
                        }
                        if model.code == 200{
                            self.listDistrict = model.data
                        }
                        
                    }
                }
                actionSheet.addAction(location)
            }
        case tfDistric:
            for i in self.listDistrict {
                let location = UIAlertAction(title: i.DistrictName, style: .default) { (action) in
                    self.tfDistric.text = i.DistrictName
                    self.GetAddrVM.districtID = i.DistrictID
                    self.GetAddrVM.GetWard { (model) in
                        guard let model = model else {
                            return
                        }
                        if model.code == 200{
                            self.listWard = model.data
                        }
                    }
                }
                actionSheet.addAction(location)
            }
        default:
            for i in listWard {
                let location = UIAlertAction(title: i.WardName, style: .default) { (action) in
                    self.tfWard.text = i.WardName
                }
                actionSheet.addAction(location)
            }
        }
        
        actionSheet.addAction(cancel)
        present(actionSheet, animated: true, completion: nil)
    }
    
    
}
