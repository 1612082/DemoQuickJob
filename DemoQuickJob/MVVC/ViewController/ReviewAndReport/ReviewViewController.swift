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
        cosMosView.settings.fillMode = .precise
        btn.layer.cornerRadius = 20
    }
    
    //MARK: - CALL API
    func callAPI() {
        
        fillData()
    }
    
    //MARK: - FILL AND BIND DATA
    func fillData() {
        
    }
    
    //MARK: - BUTTON ACTIONS
    
    @IBAction func sendReview(_ sender: Any) {
        print(reviewText.text)
        print(cosMosView.rating)
    }
    
}
