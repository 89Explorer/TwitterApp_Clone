//
//  ViewController.swift
//  TwitterApp_Clone
//
//  Created by 권정근 on 5/24/24.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupTabBar()
        
        
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        let searchVC = UINavigationController(rootViewController: SearchViewController(viewModel: SearchViewViewModel()))
        let notificationVC = UINavigationController(rootViewController: NotificationViewController())
        let directMessageVC = UINavigationController(rootViewController: DirectMessageViewController())
        
        
        homeVC.tabBarItem.image = UIImage(systemName: "house")
        homeVC.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        
        
        searchVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        
        
        notificationVC.tabBarItem.image = UIImage(systemName: "bell")
        notificationVC.tabBarItem.selectedImage = UIImage(systemName: "bell.fill")
        
        
        directMessageVC.tabBarItem.image = UIImage(systemName: "envelope")
        directMessageVC.tabBarItem.selectedImage = UIImage(systemName: "envelope.fill")
        
        
        setViewControllers([homeVC, searchVC, notificationVC, directMessageVC], animated: true)
        
    }
    
    
    // 탭바에 배경색을 정하기 위한 함수
    func setupTabBar() {
        let appearance = UITabBarAppearance()
        let tabBar = UITabBar()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground
        tabBar.standardAppearance = appearance;
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}

