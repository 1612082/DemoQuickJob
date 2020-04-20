//
//  testViewController.swift
//  DemoQuickJob
//
//  Created by HongDang on 4/20/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class testViewController: UIViewController {

    @IBOutlet weak var tf: UITextField!
    @IBOutlet weak var output: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        output.isUserInteractionEnabled = false

        // Do any additional setup after loading the view.
    }
    

    @IBAction func trans(_ sender: Any) {
        output.text = "-Nam, nữ tuổi từ 18 - 35\n-Ưu tiên biết sử dụng máy tính\n-Trình độ lớp 9 trở lên"
    }
    

}
