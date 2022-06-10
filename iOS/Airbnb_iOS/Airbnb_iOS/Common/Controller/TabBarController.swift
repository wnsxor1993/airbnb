//
//  ViewController.swift
//  Airbnb_iOS
//
//  Created by juntaek.oh on 2022/05/24.
//

import UIKit
import CoreLocation

final class TabBarController: UITabBarController {
    
    private let locationManager = LocationManager()
    private var currentLocation = CLLocation()
    private var homeVC: HomeViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTabBarItem()
        self.setTabBarBackgroundColor()
        self.locationManager.locationManager.delegate = self
    }
}

private extension TabBarController {
    func setTabBarItem() {
        let locationAccess = self.locationManager.setLocationAccess()
        let homeViewController = HomeViewController(locationAccess: locationAccess)
        self.homeVC = homeViewController
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

extension TabBarController: CLLocationManagerDelegate {

    @available(iOS 14, *)
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()
        case .denied:
            print("")
            //self.alertLocationAccessNeeded(isDenied: .denied)
        default:
            return
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()
        case .denied:
            print("")
            //self.alertLocationAccessNeeded(isDenied: .denied)
        default:
            return
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first, let homeVC = self.homeVC, homeVC.nowLocation != location else { return }

        NotificationCenter.default.post(name: NSNotification.Name("location"), object: self, userInfo: ["location": location])
    }
}
