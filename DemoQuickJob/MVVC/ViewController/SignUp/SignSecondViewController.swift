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
    var idProvice:Int = 0
    var idDistrict:Int = 0
    var LoginVM = LobbyViewModel()
    var listDistictFilter:[DISTRICT] = []
    var userSignup:USERSIGNUP?
    let signupVM = SignupViewModel()
    
    
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
            for i in arrProvice {
                let location = UIAlertAction(title: i.name, style: .default) { (action) in
                    self.tfProvice.text = i.name
                    self.idProvice = i.id
                    self.listDistictFilter = listDtrict.filter{ $0.ProvinceID == i.id}
                }
                actionSheet.addAction(location)
            }
        case tfDistric:
            for i in self.listDistictFilter {
                let location = UIAlertAction(title: i.DistrictName, style: .default) { (action) in
                    self.tfDistric.text = i.DistrictName
                    self.idDistrict = i.DistrictID
                    self.LoginVM.DistrictID = i.DistrictID
                    self.LoginVM.GetWard { (model) in
                         guard let model = model else {
                            return
                        }
                        if model.code == 1{
                            listWard = model.data.Wards
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
