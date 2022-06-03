//
//  HomewViewController.swift
//  Airbnb_iOS
//
//  Created by juntaek.oh on 2022/05/24.
//

import UIKit
import CoreLocation

class HomewViewController: UIViewController {

    private let browseViewController = BrowseViewController()
    private lazy var homeView = HomeView(frame: view.frame)
    private let dataSource = SearchViewCollectionDataSource()
    
    private let locationManager = LocationManager()
    private var currentLocation = CLLocation()

    let searchBar: UISearchBar = {
        let searcher = UISearchBar()
        searcher.placeholder = "어디로 여행가세요?"
        return searcher
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureSettings()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.hidesBarsOnSwipe = true
    }
}

private extension HomewViewController {
    
    func configureSettings() {
        self.addChild(browseViewController)
        self.setHomeView()
        self.setSearchBar()
        self.setLocationAccess()
    }
    
    func setHomeView() {
        self.view = homeView
        self.homeView.setDataSource(dataSource)
    }
    
    func setSearchBar() {
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
    }
    
    func setLocationAccess() {
        self.locationManager.locationManager.delegate = self
        self.alertLocationAccessNeeded(isDenied: self.locationManager.setLocationAccess())
    }
    
    func alertLocationAccessNeeded(isDenied: LocationManager.AceessCase) {
        var settingsAppURL: URL?
        
        if #available(iOS 15.4, *) {
            settingsAppURL = URL(string: UIApplicationOpenNotificationSettingsURLString)
        } else {
            settingsAppURL = URL(string: UIApplication.openSettingsURLString)
        }
        
        guard let settingsAppURL = settingsAppURL else { return }
        
        switch isDenied {
        case .denied:
            DispatchQueue.main.async {
                self.presentAlert(url: settingsAppURL)
            }
        default:
            return
        }
    }
    
    func presentAlert(url: URL) {
        let alert = UIAlertController(title: "위치 권한이 필요합니다", message: "설정창에서 위치 권한 설정 내역을 변경하실 수 있습니다.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "설정창으로 가기", style: .cancel, handler: { _ in
            UIApplication.shared.open(url)
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .default, handler: nil))
        
        present(alert, animated: true)
    }
}

extension HomewViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        browseViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(browseViewController, animated: true)

        return false
    }
}

extension HomewViewController: CLLocationManagerDelegate {
    
    @available(iOS 14, *)
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()
        case .denied:
            self.alertLocationAccessNeeded(isDenied: .denied)
        default:
            return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()
        case .denied:
            self.alertLocationAccessNeeded(isDenied: .denied)
        default:
            return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        self.currentLocation = location
    }
}
