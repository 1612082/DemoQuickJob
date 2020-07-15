//
//  JobDetailViewModel.swift
//  DemoQuickJob
//
//  Created by HongDang on 6/1/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import Foundation

class JobDetailViewModel {
    var idJob:Int = 0{
        didSet{}
    }
    func GetDetailJob(completion:@escaping GetJobDetailHandel){
        let param = [
            "id": "\(self.idJob)",
        ]
        APIJobDetail.shared.GetDetailJob("\(idJob)",parameters: (param), headers: nil) { (model) in
            guard let model = model else {
                completion(nil)
                return
            }
            completion(model)
        }
        
    }
    func convertDoubleToCurrency(amount: Int) -> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale.current
        numberFormatter.currencySymbol = "VND"
        let a = numberFormatter.string(from: NSNumber(value: amount))!
        return String(a.prefix(a.count - 3))
    }
    func convertCurrencyToDouble(input: String) -> Double? {
         let numberFormatter = NumberFormatter()
         numberFormatter.numberStyle = .currency
         numberFormatter.locale = Locale.current
         return numberFormatter.number(from: input)?.doubleValue
    }
    func FindYourPrice(_ list:[Dealer?])-> String {
        let result = list.filter{ $0?.id_user == currentUser?.id_user }
        if result.first == nil {
            return ""
        } else {
            return "\(result.first??.proposed_price ?? -1)"
            
        }
    }
    func DateFormater(_ s:String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"

        if let date = dateFormatterGet.date(from: s) {
            return dateFormatterPrint.string(from: date)
        } else {
           return "2020-01-01"
        }
    }
}
