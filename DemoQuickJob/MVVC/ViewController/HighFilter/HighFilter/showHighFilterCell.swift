//
//  showHighFilterCell.swift
//  DemoQuickJob
//
//  Created by HongDang on 5/19/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class showHighFilterCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    var didRemoveItem:((_ id:Int)->Void)! = nil
    var arrShow:[String] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension showHighFilterCell:UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrShow.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShowHighFilterItem", for: indexPath) as! ShowHighFilterItem
        cell.lb.text = "x \(arrShow[indexPath.row])"
        cell.contentView.backgroundColor = .green
        cell.layer.cornerRadius = 5
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = indexPath.row
        if didRemoveItem != nil {
            didRemoveItem(id)
        }
    }
}
