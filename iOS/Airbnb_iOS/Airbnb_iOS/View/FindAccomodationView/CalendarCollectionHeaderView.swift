//
//  CalendarCollectionHeaderView.swift
//  Airbnb_iOS
//
//  Created by 김한솔 on 2022/05/30.
//

import UIKit

final class CalendarCollectionHeaderView: UIView {
    private let monthLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .init(rawValue: 700))
        return label
    }()

    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.locale = Locale.autoupdatingCurrent
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMM y")
        return dateFormatter
    }()

    var baseDate = Date() {
        didSet {
            monthLabel.text = dateFormatter.string(from: baseDate)
        }
    }

    init() {
        super.init(frame: .zero)

        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        addSubview(monthLabel)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        NSLayoutConstraint.activate([
            monthLabel.topAnchor.constraint(equalTo: topAnchor),
            monthLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            monthLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            monthLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
