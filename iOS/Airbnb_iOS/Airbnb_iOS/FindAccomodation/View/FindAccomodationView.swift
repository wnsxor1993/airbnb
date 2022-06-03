//
//  FindAccomodationView.swift
//  Airbnb_iOS
//
//  Created by 김한솔 on 2022/05/25.
//

import UIKit

final class FindAccomodationView: UIView {
    private let selectView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let infoTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FindAccomodationCell.self, forCellReuseIdentifier: FindAccomodationCell.identifier)
        return tableView
    }()

    private lazy var budgetView = BudgetView(frame: selectView.frame)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    func setTableViewDateSource(_ dataSource: UITableViewDataSource) {
        infoTableView.dataSource = dataSource
    }

    func setTableViewDelegate(_ delegate: UITableViewDelegate) {
        infoTableView.delegate = delegate
    }

    func setSelectView(_ view: UIView) {
        selectView.addSubview(view)

        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: selectView.topAnchor),
            view.bottomAnchor.constraint(equalTo: selectView.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: selectView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: selectView.trailingAnchor)
        ])
    }
    func next() {
        selectView.addSubview(budgetView)

        NSLayoutConstraint.activate([
            budgetView.topAnchor.constraint(equalTo: selectView.topAnchor),
            budgetView.bottomAnchor.constraint(equalTo: selectView.bottomAnchor),
            budgetView.leadingAnchor.constraint(equalTo: selectView.leadingAnchor),
            budgetView.trailingAnchor.constraint(equalTo: selectView.trailingAnchor)
        ])
    }

    func reloadCell() {
        infoTableView.reloadData()
    }
}

private extension FindAccomodationView {
    func setUpLayout() {
        addSubViews(selectView, infoTableView)
        backgroundColor = .white

        NSLayoutConstraint.activate([
            selectView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            selectView.leadingAnchor.constraint(equalTo: leadingAnchor),
            selectView.trailingAnchor.constraint(equalTo: trailingAnchor),
            selectView.heightAnchor.constraint(equalToConstant: frame.height / 1.7)
        ])

        NSLayoutConstraint.activate([
            infoTableView.topAnchor.constraint(equalTo: selectView.bottomAnchor),
            infoTableView.leadingAnchor.constraint(equalTo: selectView.leadingAnchor),
            infoTableView.trailingAnchor.constraint(equalTo: selectView.trailingAnchor),
            infoTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
