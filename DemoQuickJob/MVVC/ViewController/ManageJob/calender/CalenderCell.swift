//
//  CalenderCell.swift
//  DemoQuickJob
//
//  Created by HongDang on 5/5/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class CalenderCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lbMonth: UILabel!
    @IBOutlet weak var btnPrevious: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    var listDate = [WorkInMonth]()
    var dataSchedule:DataSchedule?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupVar()
        setupUI()
        
    }

        //MARK: - SETUP VAR
    func setupVar() {
//        currentMonthIndex = Calendar.current.component(.month, from: Date())
        year = Calendar.current.component(.year, from: Date())
        month = Calendar.current.component(.month, from: Date())
        todaysDate = Calendar.current.component(.day, from: Date())
       
        
        //for leap years, make february month of 29 days
        ChangeDateInFeb(year)
        //end
        numberOfEmptyBoxs = getNumberOfEmptyBoxs()
        
    }
    
    //MARK: - SETUP UI
    func setupUI() {
        currentMonth = NameMonth[month - 1]
        lbMonth.text =  "\(currentMonth) \(year)"
        let imageview = UIImageView(image: UIImage(named: "left-arrow"))
        let img = #imageLiteral(resourceName: "right-arrow")
        self.btnPrevious.setImage(imageview.image, for: .normal)
        btnPrevious.setTitle(nil, for: .normal)
        btnNext.setTitle(nil, for: .normal)
        self.btnNext.setImage(img, for: .normal)
        
    }
    func getMiddleString(_ str:String, start:Int, end:Int) ->String{
        let start = str.index(str.startIndex, offsetBy: start)
        let end = str.index(str.startIndex, offsetBy: end)
        let range = start...end
        return String(str[range])
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func previousMonth(_ sender: Any) {
        self.filterFromSchedule(self.dataSchedule)
        switch currentMonth {
        case "January":
            month = 12
            year -= 1
            ChangeDateInFeb(year)
            currentMonth = NameMonth[month - 1]
            numberOfEmptyBoxs = getNumberOfEmptyBoxs()
            lbMonth.text =  "\(currentMonth) \(year)"
            collectionView.reloadData()
        default:
            month -= 1
            currentMonth = NameMonth[month - 1]
            numberOfEmptyBoxs = getNumberOfEmptyBoxs()
            lbMonth.text =  "\(currentMonth) \(year)"
            collectionView.reloadData()
        }
    }
    @IBAction func nextMonth(_ sender: Any) {
        self.filterFromSchedule(self.dataSchedule)
        switch currentMonth {
        case "December":
            month = 1
            year += 1
            ChangeDateInFeb(year)
            currentMonth = NameMonth[month - 1]
            numberOfEmptyBoxs = getNumberOfEmptyBoxs()
            lbMonth.text =  "\(currentMonth) \(year)"
            collectionView.reloadData()
        default:
            month += 1
            currentMonth = NameMonth[month - 1]
            numberOfEmptyBoxs = getNumberOfEmptyBoxs()
            lbMonth.text =  "\(currentMonth) \(year)"
            collectionView.reloadData()
        }
    }
    func GetDay(_ day:Int,_ month:Int,_ year:Int) -> Int {
        let n = (day + ((153 * (month + 12 * ((14 - month) / 12) - 3) + 2) / 5) +
         (365 * (year + 4800 - ((14 - month) / 12))) +
         ((year + 4800 - ((14 - month) / 12)) / 4) -
        ((year + 4800 - ((14 - month) / 12)) / 100) +
        ((year + 4800 - ((14 - month) / 12)) / 400)  - 32045) % 7;
        return n
//        if n == 0 { //it is sunday
//            return 6
//        } else {
//            return n-1
//        }
        
    }
    func CheckLeapYear(_ year:Int) -> Bool{
        if (((year % 4) == 0) && ((year % 100) != 0)){
            return true;
        }else if ((year % 400) == 0){
            return true;
        }else {
            return false;
        }
    }
    func ChangeDateInFeb(_ y:Int){
        if CheckLeapYear(y) {
            numOfDaysInMonth[1] = 29
        } else {
            numOfDaysInMonth[1] = 28
        }
    }
    func getNumberOfEmptyBoxs() -> Int{
        return GetDay(1, month, year)
    }
    func filterFromSchedule(_ data:DataSchedule?) {
        if data != nil{
            self.listDate = []
            var formatMonth:String = String(month)
            if month < 10{
                formatMonth = "0\(month)"
            }
            for i in data!.employeeShedule{
                let yearSub:String = String(i!.end.prefix(4))                
                let monthSub = getMiddleString(i!.end, start: 5, end: 6)
                let dateSub = getMiddleString(i!.end, start: 8, end: 9)
                if (yearSub == "\(year)" && monthSub == formatMonth){
                    self.listDate.append(WorkInMonth(date: dateSub, type: false))
                }
            }
            for i in data!.employerShedule{
                let yearSub:String = String(i!.end.prefix(4))
                
                let monthSub = getMiddleString(i!.end, start: 5, end: 6)
                let dateSub = getMiddleString(i!.end, start: 8, end: 9)
                if (yearSub == "\(year)" && monthSub == formatMonth){
                    self.listDate.append(WorkInMonth(date: dateSub, type: true))
                }
            }
        }
    }
}
extension CalenderCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numOfDaysInMonth[month - 1] + numberOfEmptyBoxs
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalenderItem", for: indexPath) as! CalenderItem
        if indexPath.row < numberOfEmptyBoxs {
            cell.lb.text = ""
        } else {
            cell.lb.text = "\(indexPath.row - numberOfEmptyBoxs + 1)"
        }
        
        if (cell.lb.text == "\(todaysDate)" && month == Calendar.current.component(.month, from: Date())) {
            cell.contentView.backgroundColor = .lightGray
        }else if listDate.filter({ $0.date == cell.lb.text }).first != nil {
            let temp = listDate.filter({ $0.date == cell.lb.text }).first
            if temp!.type{
                cell.contentView.backgroundColor = .cyan
            }else{
                cell.contentView.backgroundColor = .systemPink
            }
            
        } else {
            cell.contentView.backgroundColor = .white
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //        let size = collectionView.frame.size
        return CGSize(width: collectionView.frame.width/7.5, height: 40)
        }
    
}
extension Date {
    var weekday: Int {
        return Calendar.current.component(.weekday, from: self)
    }
    var firstDayOfTheMonth: Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year,.month], from: self))!
    }
}
struct WorkInMonth {
    let date:String
    let type:Bool // false: employee true:employer
}
