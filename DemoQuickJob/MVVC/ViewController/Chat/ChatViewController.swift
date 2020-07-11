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
//        db.collection("chats").getDocuments(){ (querySnapshot, err) in
//            if let querySnapshot = querySnapshot {
//                self.task = querySnapshot.documents.compactMap({ (document) in
//                    do{
//                        document.get("img").map { (field)  in
//                            let a = field as! NSArray
//                            print(a)
//                            if a.count != 0{
//                                let b = a[0] as! NSDictionary
//                                let t = b.dictionaryWithValues(forKeys: ["email"]) as? [String:String]
//                                let text:String = t!["email"]!
//                                print(text)
//                                
//                            }
//                            else{
//                                
//                            }
//                        }
//                        let x = try document.data(as: dataFirecloud.self)
//                        self.task.append(x!)
//                        print(x)
//                    }catch{
//                        print(error)
//                    }
//                    return nil
//                })
//            }
//        }
//        if arr[0] != ""{
//            let docref2 = db.collection("test").document(arr[0])
//            docref2.getDocument { (document2, error) in
//                if let document2 = document2, document2.exists {
//                    do{
//                        print("------")
//                        print(document2.data())
//                        let dataDescription = try document2.data(as: dataFirecloud.self)
//                        print("Document data: \(dataDescription)")
//                    }catch{
//                        print("can't parse")
//                    }
//
//                } else {
//                    print("Document does not exist")
//                }
//            }
//        }
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

