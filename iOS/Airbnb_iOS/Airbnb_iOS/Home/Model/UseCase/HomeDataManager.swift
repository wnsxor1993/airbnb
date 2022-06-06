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

    private let homeService = HomeService()
    private var delegate: HomeDataManagerDelegate?

    func setDelegate(_ delegate: HomeDataManagerDelegate) {
        self.delegate = delegate
    }

    func getHomeViewComponents(currentLocation: CLLocation) {
        homeService.fetchData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let componentsData):
                self.delegate?.updateHomeComponents(componentsData)
            case .failure(let error):
                self.delegate?.didGetComponentsError(error)
            }
        }
    }
}
