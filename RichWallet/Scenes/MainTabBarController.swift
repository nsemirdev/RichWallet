//
//  MainTabBarController.swift
//  RichWallet
//
//  Created by Emir Alkal on 23.01.2023.
//

import UIKit

final class MainTabBarController: UITabBarController {
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpTabBarAppearance()
    setUpViewControllers()
    setUpSelectedAnimation(at: tabBar.items![0])
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    setUpTabBarStyle()
  }
  
  override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
    setUpSelectedAnimation(at: item)
  }
  
  private func setUpTabBarStyle() {
    tabBar.frame.size.height = UIScreen.main.bounds.size.height * 0.125
    tabBar.frame.origin.y = view.frame.size.height - (tabBar.frame.size.height)
    
    tabBar.layer.cornerRadius = 40
    tabBar.clipsToBounds = true
    tabBar.tintColor = AppColors.secondaryColor
    tabBar.layer.maskedCorners = [
      .layerMaxXMinYCorner,
      .layerMinXMinYCorner
    ]
  }
  
  private func setUpSelectedAnimation(at item: UITabBarItem) {
    tabBar.items?.forEach { tabItem in
      guard let barItemView = tabItem.value(forKey: "view") as? UIView else { return }
      barItemView.transform = .identity
    }
    
    guard let barItemView = item.value(forKey: "view") as? UIView else { return }
    let timeInterval: TimeInterval = 0.4
    let propertyAnimator = UIViewPropertyAnimator(duration: timeInterval, dampingRatio: 0.5) {
      barItemView.transform = CGAffineTransform.identity.scaledBy(x: 1.15, y: 1.15)
    }
    propertyAnimator.startAnimation()
  }
  
  private func setUpTabBarAppearance() {
    let appearance = UITabBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = UIColor(named: "PrimaryColor")
    
    UITabBar.appearance().standardAppearance = appearance
    UITabBar.appearance().scrollEdgeAppearance = appearance
  }
  
  private func setUpViewControllers() {
    let titles = ["Wallet", "Trade", "Profile"]
    let images = [
      UIImage(systemName: "house"),
      UIImage(systemName: "dollarsign.square"),
      UIImage(systemName: "person.crop.square")
    ]
    
    let views: [UIViewController] = [
      HomeViewController(),
      TradeViewController(),
      ProfileViewController()
    ]
    
    for (idx, viewController) in views.enumerated() {
      viewController.tabBarItem.title = titles[idx]
      viewController.tabBarItem.image = images[idx]
    }
    
    viewControllers = views
  }
}
