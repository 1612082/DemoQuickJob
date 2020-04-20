//
//  BannerCell.swift
//  DemoQuickJob
//
//  Created by HongDang on 4/18/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class BannerCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
extension BannerCell:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrBannerImg.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let Item = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerItem", for: indexPath) as! BannerItem
        Item.img.image = arrBannerImg[indexPath.row]
        return Item
    }

    
    
}
extension BannerCell :UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
     
}
