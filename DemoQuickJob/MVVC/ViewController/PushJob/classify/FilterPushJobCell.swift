//
//  FilterPushJobCell.swift
//  DemoQuickJob
//
//  Created by HongDang on 5/18/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class FilterPushJobCell: UITableViewCell,UITextFieldDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var JobTopic: UITextField!
    var didShowTopic:(()->Void)! = nil
    var didTouch:((_ id:Int)->Void)! = nil
    var arrTag:[Int] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let view1 = UIView()
        let imageview = UIImageView(image: UIImage(named: "down"))
        view1.addSubview(imageview)
        view1.widthAnchor.constraint(equalToConstant: 30).isActive = true
        view1.heightAnchor.constraint(equalToConstant: 18).isActive = true

        self.JobTopic.rightViewMode = .always
        self.JobTopic.rightView = view1
        JobTopic.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        if didShowTopic != nil {
            didShowTopic()
        }
        
    }
    func bindData(_ data:TYPEJOBDETAIL){
        JobTopic.text = listTopic.filter({ (i) -> Bool in
            return i.id_jobtopic == data.job_topic
            }).first?.name
        
        arrTag = data.tags.map({ (tag) in
            let TextToID = listTag.indices.filter { (i) -> Bool in
                listTag[i].name == tag
            }.first
            return TextToID!
        })
    }

}
extension FilterPushJobCell: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listTag.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatePushJobItem", for: indexPath) as! CatePushJobItem
        cell.lb.text = listTag[indexPath.row].name
        if arrTag.contains(indexPath.row){
            cell.contentView.backgroundColor = .green
        } else {
            cell.contentView.backgroundColor = .orange
        }
        cell.layer.cornerRadius = 5
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let id = indexPath.row
//        let cell = collectionView.cellForItem(at: indexPath)
        if didTouch != nil {
            didTouch(id)
        }
    }
    
}
