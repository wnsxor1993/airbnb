//
//  HomeDataManager.swift
//  Airbnb_iOS
//
//  Created by 김한솔 on 2022/06/03.
//

import CoreLocation

protocol HomeDataManagerDelegate: AnyObject {
    func updateHomeComponents(_ homeComponentsData: [HomeViewComponentsData])
    func updateHeroImageData(_ heroImageData: HomeViewComponentsData.HeroImageData)
    func updateAroundSpotData(_ aroundSpotData: HomeViewComponentsData.AroundSpotData)
    func updateThemeSpotData(_ themeSpotData: HomeViewComponentsData.ThemeSpotData)
    func didGetComponentsError(_ error: Error)
}

final class HomeDataManager {

    private var homeRepository = HomeRepository()
    private weak var delegate: HomeDataManagerDelegate?

    init() {
        homeRepository.setDelegate(self)
    }

    func setDelegate(_ delegate: HomeDataManagerDelegate) {
        self.delegate = delegate
    }

    func getHomeViewComponents(currentLocation: CLLocation) {
        homeRepository.fetchData(
            currentLocation: (latitude: currentLocation.coordinate.latitude,
                              longitude: currentLocation.coordinate.longitude))
    }
}

extension HomeDataManager: HomeRepositoryDelegate {
    func didFetchHeroImageData(_ heroImageData: HomeViewComponentsData.HeroImageData) {
        delegate?.updateHeroImageData(heroImageData)
    }
    
    func didFetchAroundSpotData(_ aroundSpotData: HomeViewComponentsData.AroundSpotData) {
        delegate?.updateAroundSpotData(aroundSpotData)
    }
    
    func didFetchThemeSpotData(_ themeSpotData: HomeViewComponentsData.ThemeSpotData) {
        delegate?.updateThemeSpotData(themeSpotData)
    }
}
