//
//  FindAccomodationViewCont.swift
//  Airbnb_iOS
//
//  Created by 김한솔 on 2022/05/25.
//

import UIKit

final class FindAccomodationViewController: UIViewController {

    private lazy var findAccomodationView = FindAccomodationView(frame: view.frame)
    private let dataSource = FindAccomodationTableDataSource()
    private let findAccomodationTableDelegate = FindAccomodationTableDelegate()
    private var calendarViewController: CalendarViewController?
    private let detailPageViewController = DetailPageViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setViewInitialState()
        findAccomodationView.setTableViewDateSource(dataSource)
        findAccomodationView.setTableViewDelegate(findAccomodationTableDelegate)
        setCalendarView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.isToolbarHidden = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isToolbarHidden = true
    }

    func setLocationData(_ data: AccomodationData) {
        dataSource.reservationInfo[0] = data
    }
}

private extension FindAccomodationViewController {

    func setViewInitialState() {
        view.backgroundColor = .white
        navigationItem.title = "숙소 찾기"
        view = findAccomodationView
        setToolbar()
    }

    func setToolbar() {
        let toolBarButtons = [
            UIBarButtonItem(title: "건너뛰기", style: .plain, target: self, action: #selector(nextButtonOfCalendarViewTouched)),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "다음", style: .plain, target: self, action: #selector(nextButtonOfCalendarViewTouched))
        ]
        toolbarItems = toolBarButtons
        toolBarButtons[2].isEnabled = false
    }

    @objc func nextButtonOfCalendarViewTouched() {
        if case let .location(locationData) = dataSource.reservationInfo[0],
           case let .accomodationPeriod(dataRangeData) = dataSource.reservationInfo[1] {
            let accomodationsViewController = AccomodationsViewController(location: locationData, dateRange: dataRangeData.dateRange)
            navigationController?.pushViewController(accomodationsViewController, animated: true)
        }
    }

    @objc func removeButtonOfCalendarViewTouched() {
        guard let calendarViewController = calendarViewController else { return }
        resetCalendarView()
        calendarViewController.resetSelectedCells()
        toolbarItems?[0] = UIBarButtonItem(title: "건너뛰기", style: .plain, target: self, action: #selector(nextButtonOfCalendarViewTouched))
    }

    func setCalendarView() {
        let today = Date()

        let calendarViewController = CalendarViewController(baseDate: today)
        self.calendarViewController = calendarViewController

        addChild(calendarViewController)
        findAccomodationView.setSelectView(calendarViewController.view)
        calendarViewController.didMove(toParent: self)
        calendarViewController.setDelegate(self)
    }

    func resetCalendarView() {
        dataSource.reservationInfo[1] = AccomodationData.accomodationPeriod(.init())
        findAccomodationView.reloadCell()
        toolbarItems?[2].isEnabled = false
    }

    func setBudgetView() {
//        if let calendarViewController = calendarViewController {
//            calendarViewController.removeFromParent()
//        }
        self.navigationController?.pushViewController(detailPageViewController, animated: true)
    }
}

extension FindAccomodationViewController: CalendarViewControllerDelegate {
    func didSetDateRange(_ dateRange: ClosedRange<Date>) {
        dataSource.reservationInfo[1] = AccomodationData.accomodationPeriod(.init(dateRange: dateRange))
        findAccomodationView.reloadCell()
        toolbarItems?[2].isEnabled = true
        toolbarItems?[0] = UIBarButtonItem(title: "지우기", style: .plain, target: self, action: #selector(removeButtonOfCalendarViewTouched))
    }

    func didChangeDateRange() {
        resetCalendarView()
        toolbarItems?[0] = UIBarButtonItem(title: "건너뛰기", style: .plain, target: self, action: #selector(nextButtonOfCalendarViewTouched))
    }
}
