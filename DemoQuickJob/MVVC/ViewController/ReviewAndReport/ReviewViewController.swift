//
//  ReviewViewController.swift
//  DemoQuickJob
//
//  Created by HongDang on 7/14/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit
import Cosmos
class ReviewViewController: UIViewController {
    
    //MARK: IBOUTLETS
    @IBOutlet weak var cosMosView: CosmosView!
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var reviewText: UITextView!
    @IBOutlet weak var lbStar: UILabel!
    
    //MARK: OTHER VARIABLES
    var ReviewReportVM = ReviewAndReportViewModel()
    var CommonVM = CommonViewModel()
    var status:Bool? //true from employer, false from employee
    var idApplicant:Int?
    var idJob:String?
    var canReview = true
    //MARK: VIEW LIFE CYCLE
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cosMosView.didTouchCosmos = { rating in
            self.lbStar.text = "Số điểm bạn đánh giá: \(round(100*rating)/100)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setupUI()
        setupVar()
        callAPI()
    }
    
    //MARK: - SETUP VAR
    func setupVar() {
        
    }
    
    //MARK: - SETUP UI
    func setupUI() {
        cosMosView.settings.updateOnTouch = true
        cosMosView.settings.fillMode = .full
        btn.layer.cornerRadius = 20
        btn.isUserInteractionEnabled = true
    }
    
    //MARK: - CALL API
    func callAPI() {
        
        fillData()
    }
    
    //MARK: - FILL AND BIND DATA
    func fillData() {
        ReviewReportVM.id_applicant = "\(self.idApplicant!)"
        ReviewReportVM.loadReview { (model) in
            guard let model = model else{
                return
            }
            if model.code == "200"{
                if model.data?.code == 1{
                    if self.status!{
                        if model.data?.review?.rating_fromEmployer != nil{
                            self.cosMosView.rating = Double.init((model.data?.review?.rating_fromEmployer)!)
                            self.reviewText.text = model.data?.review?.feedback_fromEmployer
                            self.btn.isUserInteractionEnabled = false
                        }
                    }
                    
                }
            }
        }
    }
    
    //MARK: - BUTTON ACTIONS
    
    @IBAction func sendReview(_ sender: Any) {
        if !canReview {
            return
        }
        self.ReviewReportVM.rating = Int.init(cosMosView.rating)
        self.ReviewReportVM.feedback = reviewText.text
        self.ReviewReportVM.id_applicant = "\(idApplicant!)"
        self.ReviewReportVM.id_job = idJob!
        if self.status!{
            self.ReviewReportVM.reviewFromEmployer { (model) in
                guard let model = model else{
                    return
                }
                if model.code == "200"{
                    self.alertReview("Review thành công")
                    self.navigationController?.popViewController(animated: true)
                    
                }else{
                    self.alertReview("Review không thành công \(model.code)")
                }
            }
        }else{
            self.ReviewReportVM.reviewFromEmployee { (model) in
                guard let model = model else{
                    return
                }
                if model.code == "200"{
                    self.alertReview("Review thành công")
                    self.navigationController?.popViewController(animated: true)
                    
                }else{
                    self.alertReview("Review không thành công \(model.code)")
                }
            }
        }
    }
    func alertReview(_ message:String){
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        self.CommonVM.showAlert(message, alert)
    }
    
}
