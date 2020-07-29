//
//  AuthenticateIDCardViewController.swift
//  DemoQuickJob
//
//  Created by HongDang on 7/22/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit
import  Foundation

enum falseAuthen {
    case nilImg
    case nilIdetity
    case falseFormat
}
class AuthenticateIDCardViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    //MARK: IBOUTLETS
    @IBOutlet weak var imgSelf: UIImageView!
    @IBOutlet weak var imgFrontID: UIImageView!
    @IBOutlet weak var imgBackID: UIImageView!
    
    @IBOutlet weak var btnSavePhoto: UIButton!
    @IBOutlet weak var Identity: UITextField!
    @IBOutlet var btn: [UIButton]!
    
    //MARK: OTHER VARIABLES
    let picker = UIImagePickerController()
    var profileVM = ProfileViewModel()
    var commonVM = CommonViewModel()
    var reasonFalse:falseAuthen?
    var LoadingView = UIView()
    var option:Int = 0 // 1 self 2 frontID 3 backID
    var arrImgBase:[String] = []
    //MARK: VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupVar()
        setupUI()
        callAPI()
    }
    override func viewWillAppear(_ animated: Bool) {
        btn[0].setTitle(imgSelf.image == UIImage.init() ? "Ảnh chân dung" : nil, for: .normal)
        btn[1].setTitle(imgFrontID.image == UIImage.init() ? "CMND mặt trước" : nil, for: .normal)
        btn[2].setTitle(imgBackID.image == UIImage.init() ? "CMND mặt sau" : nil, for: .normal)
    }
    //MARK: - SETUP VAR
    func setupVar() {
        
    }
    
    //MARK: - SETUP UI
    func setupUI() {
        imgSelf.image = UIImage.init()
        imgFrontID.image = UIImage.init()
        imgBackID.image = UIImage.init()
        btnSavePhoto.layer.cornerRadius = 20
        for i in btn{
            i.backgroundColor = .clear
        }
    }
    
    //MARK: - CALL API
    func callAPI() {
        
    }
    
    
    
    //MARK: - BUTTON ACTIONS
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        guard let image = info[.originalImage] as? UIImage else {
            print("No image found")
            return
        }
        // print out the image size as a test
        switch self.option {
        case 1:
            imgSelf.image = image
        case 2:
            imgFrontID.image = image
        case 3:
            imgBackID.image = image
        default:
            do{}
        }
    }
    @IBAction func takePhoto(_ sender: Any) {
        
    }
    public static func  convertImageToBase64String(image : UIImage ) -> String
    {
        let strBase64 =  image.pngData()?.base64EncodedString()
        return strBase64!
    }
    @IBAction func savePhoto(_ sender: Any) {

        let imgCheck = UIImage.init()
        if (imgSelf.image != imgCheck && imgFrontID.image != imgCheck && imgBackID.image != imgCheck){
            if Identity.text != ""{
                if (Identity.text?.count == 9 || Identity.text?.count == 12){
                    let imageData: Data? = imgSelf.image!.jpegData(compressionQuality: 0.4)
//                    let imageStr = imageData?.base64EncodedString(options: .lineLength64Characters) ?? ""
//                    let imageSelfData = (imgSelf.image!.pngData()?.base64EncodedString())!
                    let strBase64Self = imageData!.base64EncodedString(options: .lineLength64Characters)
                    let imageFrontData: Data? = imgFrontID.image!.jpegData(compressionQuality: 0.4)

                    let strBase64Front = imageFrontData!.base64EncodedString(options: .lineLength64Characters)
                    let imageBackData = imgBackID.image!.jpegData(compressionQuality: 0.4)
                    let strBase64Back = imageBackData!.base64EncodedString(options: .lineLength64Characters)
                    profileVM.identity = Identity.text!
                    profileVM.portrait = strBase64Self
//                    profileVM.frontIdPaper = imageFrontData
//                    profileVM.backIdPaper = imageBackData
//                    profileVM.portrait = strImg//strBase64Self
//                    profileVM.frontIdPaper = strImg//strBase64Front
//                    profileVM.backIdPaper = strImg//strBase64Back
                    profileVM.token = token
                    commonVM.Loading(&self.LoadingView, self.view)
                    profileVM.AuthenIDCard { (model) in
                        self.LoadingView.removeFromSuperview()

                        guard let model = model else {
                            self.LoadingView.removeFromSuperview()
                            return
                        }
                        self.LoadingView.removeFromSuperview()
                        if model.code == "106"{
                            let message = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
                            self.commonVM.showAlert("Gửi thông tin thành công", message)
                            self.present(message, animated: true, completion: nil)
                        }else{
                            let message = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
                            print(model.code)
                            self.commonVM.showAlert("Gửi thông tin thất bại ", message)
                            self.present(message, animated: true, completion: nil)
                        }
                    }
                }else{
                    reasonFalse = .falseFormat
                    showAlert(reasonFalse!)
                }

            }else{
                reasonFalse = .nilIdetity
                showAlert(reasonFalse!)
            }
        } else{
            reasonFalse = .nilImg
            showAlert(reasonFalse!)
        }

    }
    func showAlert(_ reason:falseAuthen){
        var alert = UIAlertController()
        switch reason {
        case .nilImg:
            alert = UIAlertController(title: "Thông báo", message: "Chưa đầy đủ hình ảnh", preferredStyle: .alert)
        case .nilIdetity:
            alert = UIAlertController(title: "Thông báo", message: "Chưa điền số chứng minh nhân dân", preferredStyle: .alert)
        default:
            alert = UIAlertController(title: "Thông báo", message: "Chứng minh nhân dân phải có 9 hoặc 12 số", preferredStyle: .alert)
        }
        alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func takeSelfPhoto(_ sender: UIButton) {
        self.option = 1
        sender.setTitle(nil, for: .normal)
        takePhoto()
    }
    
    @IBAction func takeFrontID(_ sender: UIButton) {
        self.option = 2
        sender.setTitle(nil, for: .normal)

        takePhoto()
    }
    @IBAction func takeBackID(_ sender: UIButton) {
        self.option = 3
        sender.setTitle(nil, for: .normal)

        takePhoto()
    }
    func takePhoto(){
        var vcCamera =  UIImagePickerController()
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            let alertController = UIAlertController(title: nil, message: "Device has no camera.", preferredStyle: .alert)

            let okAction = UIAlertAction(title: "Alright", style: .default, handler: { (alert: UIAlertAction!) in
            })

            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            vcCamera = UIImagePickerController()
            let options = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let camera = UIAlertAction(title: "Chụp ảnh", style: .default) { (_) in
                vcCamera.sourceType = .camera
                vcCamera.delegate = self
                self.present(vcCamera, animated: true, completion: nil)
            }
            let photoLibrary = UIAlertAction(title: "Lấy từ thư viện", style: .default) { (_) in
                vcCamera.sourceType = .photoLibrary
                vcCamera.delegate = self
                self.present(vcCamera, animated: true, completion: nil)
            }
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            options.addAction(camera)

            options.addAction(photoLibrary)
            options.addAction(cancel)
            present(options, animated: true)
        }
    }
}

