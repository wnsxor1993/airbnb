//
//  HomeDataManager.swift
//  Airbnb_iOS
//
//  Created by 김한솔 on 2022/06/03.
//

import CoreLocation

protocol HomeDataManagerDelegate: AnyObject {
    func updateHomeComponents(_ homeComponentsData: [HomeViewComponentsData])
    func didGetComponentsError(_ error: Error)
}

final class HomeDataManager {

    private var homeService = HomeService()
    private weak var delegate: HomeDataManagerDelegate?

    init() {
        homeService.setDelegate(self)
    }

    func setDelegate(_ delegate: HomeDataManagerDelegate) {
        self.delegate = delegate
    }

    func getHomeViewComponents(currentLocation: CLLocation) {
        homeService.fetchData(
            currentLocation: (latitude: currentLocation.coordinate.latitude,
                              longitude: currentLocation.coordinate.longitude))
    }
}

extension HomeDataManager: HomeServiceDelegate {
    func didFetchHeroImageData(_ heroImageData: HomeViewComponentsData.HeroImageData) {
    }
    
    func didFetchAroundSpotData(_ aroundSpotData: HomeViewComponentsData.AroundSpotData) {
    }
    
    func didFetchThemeSpotData(_ themeSpotData: HomeViewComponentsData.ThemeSpotData) {
    }
}
