//
//  FindAccomodationViewCont.swift
//  Airbnb_iOS
//
//  Created by 김한솔 on 2022/05/25.
//

import UIKit

final class FindAccomodationViewController: UIViewController {

    private lazy var findAccomodationView = FindAccomodationView(frame: view.frame)
    private var useCase = FindAccomodationUseCase()
    private let dataSource = FindAccomodationTableDataSource()
    private let findAccomodationTableDelegate = FindAccomodationTableDelegate()

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
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isToolbarHidden = true
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
        navigationController?.isToolbarHidden = false
        let toolBarButtons = [
            UIBarButtonItem(title: "건너뛰기", style: .plain, target: self, action: #selector(skipButtonTouched)),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "다음", style: .plain, target: self, action: #selector(nextButtonTouched))
        ]
        toolbarItems = toolBarButtons
    }

    @objc func skipButtonTouched() {
        findAccomodationView.next()
    }

    @objc func nextButtonTouched() {
        print("Next")
    }

    func setCalendarView() {
        let today = Date()

        let calendarViewController = CalendarViewController(baseDate: today)

        addChild(calendarViewController)
        findAccomodationView.setSelectView(calendarViewController.view)
        calendarViewController.didMove(toParent: self)
        calendarViewController.setDelegate(self)
    }
}

extension FindAccomodationViewController: CalendarViewControllerDelegate {
    func didSetDateRange(_ dateRange: ClosedRange<Date>) {
        dataSource.reservationInfo[1] = AccomodationData.accomodationPeriod(.init(dateRange: dateRange))
        findAccomodationView.reloadCell()
    }
}
