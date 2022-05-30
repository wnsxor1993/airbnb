//
//  CalendarView.swift
//  Airbnb_iOS
//
//  Created by 김한솔 on 2022/05/30.
//

import UIKit

class CalendarView: UIView {
    private let monthCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white

        return collectionView
    }()

    private let headerView = CalendarCollectionHeaderView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        monthCollectionView.register(CalendarCollectionCell.self, forCellWithReuseIdentifier: CalendarCollectionCell.identifier)
        translatesAutoresizingMaskIntoConstraints = false
        addSubViews(monthCollectionView, headerView)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    func reloadData() {
        DispatchQueue.main.async {
            self.monthCollectionView.reloadData()
        }
    }

    func reloadItems(at indexPaths: [IndexPath]) {
        DispatchQueue.main.async {
            self.monthCollectionView.reloadItems(at: indexPaths)
        }
    }

    func setCollectionViewDelegate(_ delegate: UICollectionViewDelegateFlowLayout) {
        monthCollectionView.delegate = delegate
    }

    func setCollectionViewDataSource(_ dataSource: UICollectionViewDataSource) {
        monthCollectionView.dataSource = dataSource
    }

    func setHeaderViewBaseDate(_ basedate: Date) {
        headerView.baseDate = basedate
    }

    override func layoutSubviews() {
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 20),
            monthCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            monthCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            monthCollectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            monthCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
