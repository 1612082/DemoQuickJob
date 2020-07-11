//
//  InforEmployerViewModel.swift
//  DemoQuickJob
//
//  Created by HongDang on 6/26/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import Foundation
class InfoEmployerViewModel{
    var id:String = ""{
           didSet{}
    }
    func GetInfo(completion:@escaping GetInfoEmployerHandel){
        
        InfoEmployerAPI.shared.GetInfoEmployer(urlID: self.id, parameters: [:], headers: nil) { (model) in
            guard let model = model else {
                completion(nil)
                return
            }
            completion(model)
        }
    }
}

