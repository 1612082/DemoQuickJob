//
//  ApplyJobViewModel.swift
//  DemoQuickJob
//
//  Created by HongDang on 6/22/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
class ApplyJobViewModel {
    var id_user:String = ""{
        didSet{}
    }
    var id_job:String = ""{
        didSet{}
    }
    var proposed_price:String = ""{
        didSet{}
    }
    var introduction_string:String = ""{
        didSet{}
    }
    func addApplicant(completion:@escaping ApplicantHandel){
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Accept": "application/json"
        ]
        let param = [
            "id_user": self.id_user,
            "id_job": self.id_job,
            "proposed_price": self.proposed_price,
            "introduction_string": self.introduction_string,
            "attachment": ""
        ]
        ApplicantAPI.shared.addApplicant(parameters: param, headers: headers) { (model) in
            guard let model = model else {
                completion(nil)
                return
            }
            completion(model)
        }
       
        
        
    }
    func showAlert(_ s:String, _ alert:UIAlertController){
//        let alert = UIAlertController(title: "", message: s, preferredStyle: .alert)
//        self.present(alert, animated: true, completion: nil)
        alert.message = s
        // change to desired number of seconds (in this case 5 seconds)
        let when = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: when){
          // your code with delay
          alert.dismiss(animated: true, completion: nil)
        }
    }
}
