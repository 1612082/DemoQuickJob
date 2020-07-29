//
//  UploadViewController.swift
//  DemoQuickJob
//
//  Created by HongDang on 4/17/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit
import FirebaseFirestoreSwift
import FirebaseFirestore
import Firebase
let db = Firestore.firestore()
class ChatViewController: UIViewController {
    
    //MARK: IBOUTLETS
    
    @IBOutlet weak var tableView: UITableView!
    //MARK: OTHER VARIABLES
//    var ref: DatabaseReference!
    var ListFriend:[String] = [""]
    var data = [NSArray]()
    
    //MARK: VIEW LIFE CYCLE
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ListFriend = [""]
        data = [NSArray]()
        setupVar()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setupUI()
        
        callAPI()
    }
    
    //MARK: - SETUP VAR
    func setupVar() {
//        let docRef = db.collection("chats")
        db.collection("chats").whereField("users", arrayContains: currentUser!.email).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    if self.ListFriend[0] != ""{
                        self.ListFriend.append(document.documentID)
                    } else{
                        self.ListFriend[0] = document.documentID
                    }
                }
                if self.ListFriend[0] != ""{
                    for i in self.ListFriend{
                        db.collection("chats").document(i).getDocument { (querySnapshot, err) in
                            if let querySnapshot = querySnapshot {
                                querySnapshot.get("img").map { (field) in
                                    let f = field as! NSArray
                                    self.data.append(f)
                                    self.tableView.reloadData()
                                }
                            }
                        }
                        
                    }
                    
                }
                
            }
        }
    }
    
    //MARK: - SETUP UI
    func setupUI() {
        self.navigationItem.title = "Chat"
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
extension ChatViewController:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(data.count)
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        cell.bindData(data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if data.count != 0{
            let contentVC = Main_Storyboard.instantiateViewController(withIdentifier: "ContentChatViewController") as! ContentChatViewController
            let temp = (data[indexPath.row][0] as! NSDictionary).dictionaryWithValues(forKeys: ["email"]) as? [String:String]
            let a = temp!["email"]!
            let temp1 = (data[indexPath.row][1] as! NSDictionary).dictionaryWithValues(forKeys: ["email"]) as? [String:String]
            let b = temp1!["email"]!
            let keySearch1 = "\(a):\(b)"
            let keySearch2 = "\(b):\(a)"
            let result = ListFriend.filter {$0 == keySearch1}
            if result.first != nil {
                contentVC.idDocument = result.first!
            } else {
                contentVC.idDocument = keySearch2
                
            }
            navigationController?.pushViewController(contentVC, animated: true)
        }
        
    }
}

