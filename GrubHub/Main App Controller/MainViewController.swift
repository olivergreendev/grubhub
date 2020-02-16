//
//  MainViewController.swift
//  GrubHub
//
//  Created by Oliver Green on 06/02/2020.
//  Copyright © 2020 Oliver Green. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBarItems()
    }
    
    func setupTabBarItems() {
        
        let firstTabViewController = MenuTabTableController()
        firstTabViewController.tabBarItem = UITabBarItem.init(title: nil, image: #imageLiteral(resourceName: "default-flag"), tag: 0)
        firstTabViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: -10, right: 0)
        
        let secondTabViewController = OrderTabController()
        secondTabViewController.tabBarItem = UITabBarItem.init(title: nil, image: #imageLiteral(resourceName: "default-flag"), tag: 1)
        secondTabViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: -10, right: 0)
        
        let thirdTabViewController = ThirdTabController()
        thirdTabViewController.tabBarItem = UITabBarItem.init(title: nil, image: #imageLiteral(resourceName: "default-flag"), tag: 2)
        thirdTabViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: -10, right: 0)
        
        let fourthTabViewController = FourthTabController()
        fourthTabViewController.tabBarItem = UITabBarItem.init(title: nil, image: #imageLiteral(resourceName: "default-flag"), tag: 3)
        fourthTabViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: -10, right: 0)
        
        let tabBarList = [firstTabViewController, secondTabViewController, thirdTabViewController, fourthTabViewController]
        
        viewControllers = tabBarList
    }
}
