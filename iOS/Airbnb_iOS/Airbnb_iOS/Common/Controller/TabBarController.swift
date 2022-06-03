//
//  ViewController.swift
//  Airbnb_iOS
//
//  Created by juntaek.oh on 2022/05/24.
//

import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTabBarItem()
        self.setTabBarBackgroundColor()
    }
}

private extension TabBarController {
    func setTabBarItem() {
        let homeViewController = HomeViewController()
        homeViewController.getHomeViewComponents()
        let navigationViewController = UINavigationController(rootViewController: homeViewController)
        navigationViewController.tabBarItem = UITabBarItem(title: "검색", image: UIImage(systemName: "magnifyingglass"), tag: 0)

        let wishlistViewController = WishlistViewController()
        wishlistViewController.tabBarItem = UITabBarItem(title: "위시리스트", image: UIImage(systemName: "heart"), tag: 1)

        let reservationViewController = ReservationViewController()
        reservationViewController.tabBarItem = UITabBarItem(title: "내 예약", image: UIImage(systemName: "person"), tag: 2)

        self.viewControllers = [navigationViewController, wishlistViewController, reservationViewController]
    }

    func setTabBarBackgroundColor() {
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .gray6
            self.tabBar.standardAppearance = appearance
            self.tabBar.scrollEdgeAppearance = self.tabBar.standardAppearance
        } else {
            self.tabBar.barTintColor = .gray6
        }
    }
}
