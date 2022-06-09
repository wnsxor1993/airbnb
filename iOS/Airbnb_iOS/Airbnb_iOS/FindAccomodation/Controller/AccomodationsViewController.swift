//
//  AccomodationsViewController.swift
//  Airbnb_iOS
//
//  Created by 김한솔 on 2022/06/07.
//

import UIKit

final class AccomodationsViewController: UIViewController {
    private lazy var accomodationsView = AccomodationsView(frame: view.frame)
    private let dataSource = AccomodationsCollectionDataSource()
    private let dataManager = AccomodationsDataManager()

    init(location: AccomodationData.Location?, dateRange: ClosedRange<Date>?) {
        super.init(nibName: nil, bundle: nil)
        dataSource.data[0] = AccomodationsViewComponentsData.accomodationOptionSection(.init(locationName: location?.name, dateRange: dateRange))
        accomodationsView.setDataSource(dataSource)
        accomodationsView.setDelegate(object: self)
        view = accomodationsView

        dataManager.setDelegate(self)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.topItem?.backButtonTitle = "뒤로"
        navigationItem.title = "숙소 찾기"
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = true
    }

    func getViewComponentsData() {
        dataManager.getAccomodationsData()
    }
}

extension AccomodationsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.section == 2 else { return }
        
        let detailPageViewController = DetailPageViewController()
        self.navigationController?.pushViewController(detailPageViewController, animated: true)
    }
}

extension AccomodationsViewController: AccomodationsDataManagerDelegate {
    func updateAccomodationComponentsData(_ data: AccomodationsViewComponentsData.AccomodationInfo) {
        if case let AccomodationsViewComponentsData.accomodationsSection(previousData) = dataSource.data[2],
           case let AccomodationsViewComponentsData.countAccomodationsSection(count) = dataSource.data[1] {
            let updatedData = (previousData ?? []) + [data]
            let updatedCount = count + 1
            dataSource.data[2] = .accomodationsSection(updatedData)
            dataSource.data[1] = .countAccomodationsSection(count: updatedCount)
            accomodationsView.reloadCollectionViewCell(sectionNumber: 2)
            accomodationsView.reloadCollectionViewCell(sectionNumber: 1)
        }
    }
}
