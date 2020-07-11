//
//  imgdetailCell.swift
//  DemoQuickJob
//
//  Created by HongDang on 4/24/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class imgdetailCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    var arrImg:[String] = []
    var empty:Bool = false
//    var decodedimage:UIImage?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension imgdetailCell:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if arrImg.count == 0{
            empty = true
            return 1
        }
        return arrImg.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imgdetailItem", for: indexPath) as! imgdetailItem
        if empty == true{
            cell.img.image = #imageLiteral(resourceName: "avatar")
        }else{
            let dataDecoded:NSData = NSData(base64Encoded: arrImg[indexPath.row], options: NSData.Base64DecodingOptions(rawValue: 0))!
            if UIImage(data: dataDecoded as Data) != nil{
                let decodedimage:UIImage = UIImage(data: dataDecoded as Data)!
                cell.img.image = decodedimage
            }else{
                cell.img.image = #imageLiteral(resourceName: "avatar")
            }
            
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //        let size = collectionView.frame.size
        print("aaaa")
        print(self.frame.width, collectionView.frame.height)
            return CGSize(width: self.frame.width, height: collectionView.frame.height)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0.0
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 0.0
        }
    
}
