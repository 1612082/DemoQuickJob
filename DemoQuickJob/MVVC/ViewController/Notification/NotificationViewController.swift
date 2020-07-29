//
//  NotificationViewController.swift
//  DemoQuickJob
//
//  Created by HongDang on 7/5/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController {
    
    //MARK: IBOUTLETS

    @IBOutlet weak var tableView: UITableView!
    
    //MARK: OTHER VARIABLES
    var data = NSArray()
    //MARK: VIEW LIFE CYCLE
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        db.collection("notifications").document("nguyenhongdang@gmail.com").getDocument { (querySnapshot, err) in
            if let querySnapshot = querySnapshot {
                querySnapshot.get("listNotify").map { (field) in
                    let f = field as! NSArray
                    self.data =  NSMutableArray(array:f.reverseObjectEnumerator().allObjects).mutableCopy() as! NSMutableArray
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    //MARK: - SETUP UI
    func setupUI() {
        navigationItem.title = "Thông báo"

    }
    
    //MARK: - CALL API
    func callAPI() {
        
        fillData()
    }
    
    //MARK: - FILL AND BIND DATA
    func fillData() {
        
    }
    
    //MARK: - BUTTON ACTIONS
    
    
}
extension NotificationViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
        let a = data[indexPath.row] as! NSDictionary
        print(a)
        let b = a["content"] as! NSDictionary

        cell.bindData(b)
        return cell
    }
    
    
}
