//
//  AccomodationsDataManager.swift
//  Airbnb_iOS
//
//  Created by 김한솔 on 2022/06/09.
//

import Foundation

protocol AccomodationsDataManagerDelegate: AnyObject {
    func updateAccomodationComponentsData(_ data: AccomodationsViewComponentsData.AccomodationInfo)
}

final class AccomodationsDataManager {
    private var repository = AccomodationsRepository()
    private weak var delegate: AccomodationsDataManagerDelegate?

    init() {
        repository.setDelegate(self)
    }

    func getAccomodationsData() {
        repository.fetchData()
    }

    func setDelegate(_ delegate: AccomodationsDataManagerDelegate) {
        self.delegate = delegate
    }
}

extension AccomodationsDataManager: AccomodationsRepositoryDelegate {
    func didFetchedData(_ data: AccomodationsViewComponentsData.AccomodationInfo) {
        delegate?.updateAccomodationComponentsData(data)
    }
}
