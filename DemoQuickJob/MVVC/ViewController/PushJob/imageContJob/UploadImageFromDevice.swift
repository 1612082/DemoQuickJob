//
//  UploadImageFromDevice.swift
//  DemoQuickJob
//
//  Created by HongDang on 5/26/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import Foundation
import DKImagePickerController

struct UploadImageFromDevice {
    
    static let shared = UploadImageFromDevice()
    
    func showImagePicker(vc: UIViewController, completion:@escaping (_ images: [UIImage])->Void){
        let picker = DKImagePickerController()
        picker.didSelectAssets = { (assets: [DKAsset]) in
            var images = [UIImage]()
            for item in assets {
                item.fetchImage(with: CGSize(width: 100, height: 100)) { (img, info) in
                    if let img = img {
                        images.append(img)
                    }
                }
            }
            completion(images)
        }
        vc.present(picker, animated: true, completion: nil)
    }
    
}
