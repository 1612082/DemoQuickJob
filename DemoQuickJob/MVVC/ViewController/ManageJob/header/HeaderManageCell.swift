//
//  HeaderManageCell.swift
//  DemoQuickJob
//
//  Created by HongDang on 5/5/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class HeaderManageCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    var didChangCate:((_ id:Int)->Void)! = nil
    var idManage:Int = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    

}
extension HeaderManageCell: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrHeaderMange.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderManageItem", for: indexPath) as! HeaderManageItem
        cell.lb.text = arrHeaderMange[indexPath.row]
        if indexPath.row == idManage{
            cell.lb.textColor = .blue
        }else{
            cell.lb.textColor = .black
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if didChangCate != nil {
            didChangCate(indexPath.item)
        }
    }
    
}
