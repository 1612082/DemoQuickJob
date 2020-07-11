//
//  TabarViewController.swift
//  DemoQuickJob
//
//  Created by HongDang on 4/17/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import UIKit


class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabbar()
    }
    

     func setupTabbar(){
               
               // xac dinh man hinh
               let Home = Home_Storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
               Home.tabBarItem = UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "home"), tag: 1000)
               let NaviHome = NaviViewController(rootViewController: Home)
               
               let Search = Main_Storyboard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
               Search.tabBarItem = UITabBarItem(title: "Search", image: #imageLiteral(resourceName: "search"), tag: 1000)
               let NaviSearch = NaviViewController(rootViewController: Search)
               
               let Upload = Main_Storyboard.instantiateViewController(identifier: "ChatViewController") as! ChatViewController
               Upload.tabBarItem = UITabBarItem(title: "Chat", image: #imageLiteral(resourceName: "mess"), tag: 3000)
               let NaviUpload = NaviViewController(rootViewController: Upload)
               
               let Manage = Main_Storyboard.instantiateViewController(withIdentifier: "ManageJobViewController") as! ManageJobViewController
               Manage.tabBarItem = UITabBarItem(title: "Manage", image: #imageLiteral(resourceName: "calendar"), tag: 1000)
               let NaviRManage = NaviViewController(rootViewController: Manage)

               let Profile = Profile_Storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
               Profile.tabBarItem = UITabBarItem(title: "Profile", image: #imageLiteral(resourceName: "user"), tag: 1000)
               let NaviProfile = NaviViewController(rootViewController: Profile)
               // dua vao mang tabbar
               self.viewControllers = [NaviHome, NaviSearch, NaviUpload, NaviRManage, NaviProfile ]
               
           }
}
