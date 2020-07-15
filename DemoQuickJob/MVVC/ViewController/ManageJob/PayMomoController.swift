//
//  TestViewController.swift
//  DemoQuickJob
//
//  Created by HongDang on 6/13/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit
import MomoiOSSwiftSdk
import Security
import  Alamofire
var status = false
public let NameNotification = Notification.Name("NoficationCenterTokenReceived")
class PayMomoController: UIViewController {
    
    //MARK: IBOUTLETS
    @IBOutlet weak var nameApply: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var buttonPay: UIButton!
    @IBOutlet weak var lblMessage: UILabel!
    //MARK: OTHER VARIABLES
    var hashFromAPI = ""
    let paymentinfo = NSMutableDictionary()
//    let buttonPay = UIButton()
    var timestamp = NSNumber()
    var partnerRefId:String = ""
    var number:String = ""
    var data:String = ""
    var idApplicant = 90
    var amount = 11000
    var MomoVM = MomoViewModel()
    var nameApplicant:String?
    //MARK: VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()

        setupVar()
        setupUI()
 
    }
    
    //MARK: - SETUP VAR
    func setupVar() {
        //STEP 1: addObserver Notification
        //Remove all MOMO NOTIFICATION by self
        NotificationCenter.default.removeObserver(self, name: NameNotification, object: nil)
        //Registration MOMO NOTIFICATION by self
        NotificationCenter.default.addObserver(self, selector: #selector(self.NoficationCenterTokenReceived), name:NameNotification, object: nil);
    }
    
    //MARK: - SETUP UI
    func setupUI() {
        nameApply.text = nameApplicant!
        price.text = "\(amount) VND"
        //STEP 3: INIT LAYOUT - ADD BUTTON PAYMENT VIA MOMO
        // Button title: ENGLISH = MoMo Wallet , VIETNAMESE = Ví MoMo
        buttonPay.setTitle("Ví MoMo", for: .normal)
        buttonPay.setTitleColor(UIColor.white, for: .normal)
        buttonPay.titleLabel!.font = UIFont.systemFont(ofSize: 15)
        buttonPay.backgroundColor = UIColor.purple
        self.view.addSubview(buttonPay)
        // Add Button Action to OPEN MOMO APPs
//        buttonPay.translatesAutoresizingMaskIntoConstraints = false
//        buttonPay.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
//        buttonPay.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
//        buttonPay.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -70).isActive = true
//        buttonPay.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        buttonPay.titleLabel?.adjustsFontSizeToFitWidth = true
        buttonPay.layer.cornerRadius = 20
        buttonPay.addTarget(self, action: #selector(self.gettoken), for: .touchUpInside) //see @objc func gettoken()
    }
    
    @objc func gettoken() {
        timestamp = Int64((NSDate().timeIntervalSince1970 * 1000).rounded()) as NSNumber
        MomoVM.requestId = Int(truncating: timestamp)
        paymentinfo["merchantcode"] = "MOMODJRT20200622"
        paymentinfo["merchantname"] = "STeam-Coop"
        paymentinfo["merchantnamelabel"] = "Service"
        paymentinfo["orderId"] = "\(idApplicant)" + "-F2L" + "\(timestamp)"
        partnerRefId = "\(idApplicant)" + "-F2L" + "\(timestamp)"
//        paymentinfo["orderId"] = "102-F2L1594318499214"
//        partnerRefId = "102-F2L1594318499214"
        paymentinfo["amount"] = self.amount
        paymentinfo["fee"] = 0
        paymentinfo["description"] = "Thanh toán tiền công"
        paymentinfo["username"] = nameApplicant!
        paymentinfo["appScheme"] = "momodjrt20200622"
        
        MoMoPayment.createPaymentInformation(info: paymentinfo)
        MoMoPayment.requestToken()
        
    }

    @objc func NoficationCenterTokenReceived(notif: NSNotification) {
        //Token Replied - Call Payment to MoMo Server
        print("::MoMoPay Log::Received Token Replied::\(notif.object!)")
        print("RequestToken response:\n  \(notif.object as Any)")
        
        let response:NSMutableDictionary = notif.object! as! NSMutableDictionary

        //let _status = response["status"] as! String
        let _statusStr = "\(response["status"] as! String)"
        
        if (_statusStr == "0") {
            
            print("::MoMoPay Log: SUCESS TOKEN. CONTINUE TO CALL API PAYMENT")
            print(">>phone \(response["phonenumber"] as! String) ")
            
            number = response["phonenumber"]! as! String
            data = response["data"] as! String
            getHash()
 
        }
        else{
            print("RequestToken response:\n \(notif.object!) | Fail token. Please check input params ")
        }
    }
    
    func submitOrderToServer(parram: [String:Any]) {
        
        let API_REQUEST_PATH = "https://test-payment.momo.vn/pay/app"
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parram as Any, options: .fragmentsAllowed)
            print("requestPayment -> \(jsonData)")
            // create post request
            let url = NSURL(string: API_REQUEST_PATH)!
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("gzip", forHTTPHeaderField: "Accept-Encoding")
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
                if error != nil{
                    print("Error -> \(String(describing: error))")
                }
                else{
                    do {
//                        let result = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:AnyObject]
//                        print("Response-> \(String(describing: result))")
                        let json = try JSONDecoder.init().decode(ReponseMomo.self, from: data!)
                        print(json)
                        self.MomoVM.momoTransId = json.transid
                        self.MomoVM.customerNumber = self.number
                        self.MomoVM.GetSign { (model) in
                            guard let model = model else{
                                return
                            }
                            if model.code == "200"{
                                self.MomoVM.signature = model.data
                                self.MomoVM.Confirm { (model) in
                                    guard let model = model else{
                                        return
                                    }
                                    if model.status == 0{
                                        print("Success confirm")
                                        self.MomoVM.idApplicant = "\(self.idApplicant)"
                                        self.MomoVM.AcceptApplicant { (model) in
                                            guard let model = model else{
                                                return
                                            }
                                            if model.code == "202"{
                                                let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
                                                self.present(alert, animated: true, completion: nil)
                                                self.MomoVM.showAlert( "Chấp nhận ứng viên thành công", alert)
                                                self.navigationController?.popViewController(animated: true)
                                            }else{
                                                let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
                                                self.present(alert, animated: true, completion: nil)
                                                self.MomoVM.showAlert( "Chấp nhận ứng viên thất bại \(model.code)", alert)
                                            }
                                            
                                        }
                                    }else{
                                        print(model)
                                    }
                                }
                            }
                        }
                        
                    } catch {
                        print("Error -> \(error)")
                    }
                }
                
            }
            
            task.resume()
            
        } catch {
            print(error)
        }
    }
    
   
    func getHash(){

        MomoVM.partnerRefId = partnerRefId as String
        MomoVM.amount = self.amount
        MomoVM.GetHash { (model) in
            guard let model = model else{
                return
            }
            if model.code == "200"{
                self.hashFromAPI = model.data
                print(self.MomoVM.requestId)
                let param = [
                    "partnerCode": "MOMODJRT20200622",
                    "customerNumber": self.number,
                    "partnerRefId": self.partnerRefId,
                    "appData": self.data,
                    "hash": self.hashFromAPI,
                    "version": 2,
                    "payType": 3,
                    "description": "\(self.MomoVM.requestId)",
                    "extra_data": "\(self.MomoVM.requestId)"
                    ] as [String : Any]
                self.submitOrderToServer(parram: param )
            }
        }

    }
}






