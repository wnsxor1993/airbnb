//
//  HomeViewController.swift
//  Airbnb_iOS
//
//  Created by juntaek.oh on 2022/05/24.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController {

    private let browseViewController = BrowseViewController()
    private lazy var homeView = HomeView(frame: view.frame)
    private let dataSource = HomeViewCollectionDataSource()

    private let homeViewDataManager = HomeDataManager()

    private let locationManager = LocationManager()
    private var currentLocation = CLLocation()

    let searchBar: UISearchBar = {
        let searcher = UISearchBar()
        searcher.placeholder = "어디로 여행가세요?"
        return searcher
    }()

    init() {
        super.init(nibName: nil, bundle: nil)
        setHomeDataManagerDelegate()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureSettings()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.hidesBarsOnSwipe = true
    }

    func getHomeViewComponents() {
        homeViewDataManager.getHomeViewComponents(currentLocation: currentLocation)
    }
}

private extension HomeViewController {

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

    func setHomeDataManagerDelegate() {
        homeViewDataManager.setDelegate(self)
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
            self.presentAlert(url: settingsAppURL)
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

extension HomeViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        browseViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(browseViewController, animated: true)

        return false
    }
}

extension HomeViewController: CLLocationManagerDelegate {

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

extension HomeViewController: HomeDataManagerDelegate {
    func updateHomeComponents(_ homeComponentsData: [HomeViewComponentsData]) {
        dataSource.data = homeComponentsData
        DispatchQueue.main.async { [weak self] in
            self?.homeView.reloadCollectionViewCell()
        }
    }

    func updateHeroImageData(_ heroImageData: HomeViewComponentsData.HeroImageData) {
        dataSource.data[0] = .firstSection(heroImageData)
        DispatchQueue.main.async { [weak self] in
            self?.homeView.reloadCollectionViewCell(sectionNumber: 0)
        }
    }

    func updateAroundSpotData(_ aroundSpotData: HomeViewComponentsData.AroundSpotData) {
        if case let HomeViewComponentsData.secondSection(previousData) = dataSource.data[1] {
            let updatedData = (previousData + [aroundSpotData]).sorted {
                $0.distance < $1.distance
            }
            dataSource.data[1] = .secondSection(updatedData)
            homeView.reloadCollectionViewCell(sectionNumber: 1)
        }
    }

    func updateThemeSpotData(_ themeSpotData: HomeViewComponentsData.ThemeSpotData) {
        if case let HomeViewComponentsData.thirdSection(previousData) = dataSource.data[2] {
            let updatedData = previousData + [themeSpotData]
            dataSource.data[2] = .thirdSection(updatedData)
            homeView.reloadCollectionViewCell(sectionNumber: 2)
        }
    }

    func didGetComponentsError(_ error: Error) {
        print(error)
    }
}
