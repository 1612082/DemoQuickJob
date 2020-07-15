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
    var ref: DatabaseReference!
    var ListFriend:[String] = [""]
    var data = [NSArray]()
    
    //MARK: VIEW LIFE CYCLE
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        db.collection("chats").whereField("users", arrayContains: "nguyenhongdang@gmail.com").getDocuments() { (querySnapshot, err) in
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
//        if ListFriend[0] == ""{
//            return 0
//        }
//        return ListFriend.count
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        cell.bindData(data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contentVC = Main_Storyboard.instantiateViewController(withIdentifier: "ContentChatViewController") as! ContentChatViewController
        contentVC.idDocument = ListFriend[indexPath.row]
        navigationController?.pushViewController(contentVC, animated: true)
    }
}

