//
//  highFilterCell.swift
//  DemoQuickJob
//
//  Created by HongDang on 5/19/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit
import  AlignedCollectionViewFlowLayout
class highFilterCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    var didTouch:((_ id:Int)->Void)! = nil
//    var ketCate = -1
    var arrTag:[Int] = []
//    var arrQuanlity:[Int] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        let alignedFlowLayout = self.collectionView?.collectionViewLayout as? AlignedCollectionViewFlowLayout
//        alignedFlowLayout?.horizontalAlignment = .left
//        alignedFlowLayout?.verticalAlignment = .top

//        alignedFlowLayout?.minimumInteritemSpacing = 10
//        alignedFlowLayout?.minimumLineSpacing = 10

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension highFilterCell:UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listTag.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "highFilterItem", for: indexPath) as! highFilterItem
        cell.lb.text = listTag[indexPath.row].name
        if arrTag.contains(indexPath.row){
            cell.contentView.backgroundColor = .gray
        } else {
            cell.contentView.backgroundColor = .orange
        }

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = indexPath.row        
        let cell = collectionView.cellForItem(at: indexPath)
        if cell?.contentView.backgroundColor == .orange {
            if didTouch != nil {
                didTouch(id)
            }
        } else {
        }
        
    }

    
}
