//
//  ContentChatViewController.swift
//  DemoQuickJob
//
//  Created by HongDang on 7/5/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift
class ContentChatViewController: UIViewController {
    
    //MARK: IBOUTLETS
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var contentChat: UITextField!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    
    //MARK: OTHER VARIABLES
    var idDocument = "nguyenhongdang@gmail.com:tranquocanh858@gmail.com"//String()
    var data = NSArray()
    var space = "  "
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
        db.collection("chats").document(idDocument).addSnapshotListener { (querySnapshot, err) in
            if let querySnapshot = querySnapshot {
                querySnapshot.get("messages").map { (field) in
                    let f = field as! NSArray
                    if f.count != 0{
                        self.data = f
                        self.tableViewHeight.constant = CGFloat(f.count * 50)
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    //MARK: - SETUP UI
    func setupUI() {
    }
    
    //MARK: - CALL API
    func callAPI() {
        
        fillData()
    }
    
    //MARK: - FILL AND BIND DATA
    func fillData() {
        
    }
    
    //MARK: - BUTTON ACTIONS
    @IBAction func Send(_ sender: UIButton) {
        let timestamp = NSDate().timeIntervalSince1970 as NSNumber
        if(contentChat.text != nil){
            var flagErr = false
            let input = [
                "message" : contentChat.text!,
                "sender": "nguyenhongdang@gmail.com",
                "timestamp": timestamp,
                ] as [String : Any]
 
            db.collection("chats").document(idDocument).updateData(
                ["messages": FieldValue.arrayUnion([input])]
                
            ) { (err) in
                print("Can not send msg")
                flagErr = true
            }
            if flagErr{
                
            } else{
                contentChat.text = ""
            }
            
        }
        
    }
    

    

}
extension ContentChatViewController:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContentChatCell", for: indexPath) as! ContentChatCell
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
        let content = (data[indexPath.row] as AnyObject).dictionaryWithValues(forKeys: ["message"]) as? [String:String]
        let sender = (data[indexPath.row] as AnyObject).dictionaryWithValues(forKeys: ["sender"]) as? [String:String]
        cell.lbContent.text = space + content!["message"]! + space
        cell.lbContent.translatesAutoresizingMaskIntoConstraints = false
        cell.lbContent.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor).isActive = true
        if sender!["sender"]! != currentUser!.email{
            cell.lbContent.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 20).isActive = true
        }else{
            cell.lbContent.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -20).isActive = true
            cell.lbContent.backgroundColor = .systemIndigo
            cell.lbContent.textColor = .white
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
