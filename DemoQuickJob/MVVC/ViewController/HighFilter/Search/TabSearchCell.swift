//
//  TabSearchCell.swift
//  DemoQuickJob
//
//  Created by HongDang on 4/27/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit

class TabSearchCell: UITableViewCell,UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var filterbtn: UIButton!
    var didChangeCategory:((_ id:Bool)->Void)! = nil
    var didTouchFilter:(() -> Void)! = nil
    var didSearch:((_ s:String)->Void)! = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        searchBar.showsCancelButton = true
        searchBar.placeholder  = "search by name"
        searchBar.delegate = self
        let image = #imageLiteral(resourceName: "filter")
        filterbtn.setTitle("", for: .normal)
        filterbtn.backgroundColor = .clear
        filterbtn.setImage(image, for: .normal)
        filterbtn.contentMode = .center
        filterbtn.imageView?.contentMode = .scaleAspectFit
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        searchBar.endEditing(true)
        print("aaa")
        if didSearch != nil {
            didSearch(searchBar.text ?? "")
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        searchBar.endEditing(true)
        if didChangeCategory != nil {
            didChangeCategory(true)
        }

    }
    @IBAction func clickFilter(_ sender: Any) {
        if didTouchFilter != nil {
            didTouchFilter()
        }
    }
    
    
}
