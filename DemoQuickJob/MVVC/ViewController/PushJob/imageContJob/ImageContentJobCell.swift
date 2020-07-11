//
//  ImageContentJobCell.swift
//  DemoQuickJob
//
//  Created by HongDang on 5/26/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class ImageContentJobCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    var didSelectImg:(()->Void)! = nil
    var arrPhoto:[UIImage] = [#imageLiteral(resourceName: "clickhere")]

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension ImageContentJobCell:UICollectionViewDataSource, UICollectionViewDelegate,  UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageContJobitem", for: indexPath) as! ImageContJobitem
        cell.img.image = arrPhoto[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if didSelectImg != nil{
            didSelectImg()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 100, height: 100)
        }
    func bindData(_ data:TYPEJOBDETAIL){
    }
}
