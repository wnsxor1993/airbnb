//
//  FindAccomodationViewCont.swift
//  Airbnb_iOS
//
//  Created by 김한솔 on 2022/05/25.
//

import UIKit

final class FindAccomodationViewController: UIViewController {

    private lazy var findAccomodationView = FindAccomodationView(frame: view.frame)
    private var dataSource: [AccomodationData] = [
        AccomodationData(title: "위치"),
        AccomodationData(title: "체크인/체크아웃"),
        AccomodationData(title: "요금"),
        AccomodationData(title: "인원")
    ]
    private var useCase = FindAccomodationUseCase()

    override func viewDidLoad() {
        super.viewDidLoad()
        setViewInitialState()
        findAccomodationView.setTableViewDateSource(self)
        findAccomodationView.setTableViewDelegate(self)
        useCase.setDelegate(self)
        setCalendarView()
    }
}

private extension FindAccomodationViewController {

    func setViewInitialState() {
        view.backgroundColor = .white
        navigationItem.title = "숙소 찾기"
        view = findAccomodationView
        navigationController?.hidesBarsOnSwipe = false
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
    }
}

extension FindAccomodationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FindAccomodationCell.identifier, for: indexPath) as? FindAccomodationCell else {
            return UITableViewCell()
        }
        cell.setTitleLabel(dataSource[indexPath.row].title)
        cell.setDesctiption(dataSource[indexPath.row].data)

        return cell
    }

    private struct AccomodationData {
        let title: String
        var data: String?
    }
}

extension FindAccomodationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}


protocol FindAccomodationUseCaseDelegate: AnyObject {
    func didChangeDate()
    func didSetDate(_ newDate: Date)
    func didSetDateRange(_ dateRange: ClosedRange<Date>)
}
