//
//  cateJobCell.swift
//  DemoQuickJob
//
//  Created by HongDang on 4/28/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class cateJobCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    var didChangeCategory:((_ id:Int)->Void)! = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension cateJobCell:UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CateJobItem", for: indexPath) as! CateJobItem
        cell.bindData(text: "Online", selected: arrState[indexPath.row])
        cell.contentView.layer.cornerRadius = 5
        if arrState[indexPath.row]{
            cell.contentView.backgroundColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.5)
        }else{
            cell.contentView.backgroundColor = .white
            cell.contentView.layer.cornerRadius = 5
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //        let size = collectionView.frame.size
        print(collectionView.frame.size)
        return CGSize(width: self.frame.width/3.2, height: collectionView.frame.size.height/4)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0.0
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 10.0
        }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let selectedCell:UICollectionViewCell = collectionView.cellForItem(at: indexPath)!
//        selectedCell.contentView.backgroundColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.5)
       
        if didChangeCategory != nil {
            self.didChangeCategory(indexPath.item)
        }

    }
}
