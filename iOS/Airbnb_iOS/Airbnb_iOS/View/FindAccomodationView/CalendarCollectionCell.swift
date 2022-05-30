//
//  CalendarCollectionCell.swift
//  Airbnb_iOS
//
//  Created by 김한솔 on 2022/05/30.
//

import UIKit

final class CalendarCollectionCell: UICollectionViewCell {

    private lazy var selectionBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = .black

        return view
    }()

    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12, weight: .init(rawValue: 700))
        label.textColor = .label

        return label
    }()

    static let identifier = "CalendarCollectionViewCell"

    var day: Day? {
        didSet {
            guard let day = day else { return }
            if day.isBeforeToday {
                numberLabel.attributedText = day.number.strikeThrough()
            } else {
                numberLabel.text = day.number
            }
            updateSelectionStatus()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        isAccessibilityElement = true
        accessibilityTraits = .button

        contentView.addSubViews(selectionBackgroundView, numberLabel)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let size = traitCollection.horizontalSizeClass == .compact ?
        min(min(frame.width, frame.height) - 10, 60): 45

        NSLayoutConstraint.activate([
            numberLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            numberLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            selectionBackgroundView.centerYAnchor.constraint(equalTo: numberLabel.centerYAnchor),
            selectionBackgroundView.centerXAnchor.constraint(equalTo: numberLabel.centerXAnchor),
            selectionBackgroundView.widthAnchor.constraint(equalToConstant: size),
            selectionBackgroundView.heightAnchor.constraint(equalTo: selectionBackgroundView.widthAnchor)
        ])

        selectionBackgroundView.layer.cornerRadius = size / 2
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        layoutSubviews()
    }

    override func prepareForReuse() {
        numberLabel.text = nil
        selectionBackgroundView.isHidden = true
    }
}

private extension CalendarCollectionCell {

    func updateSelectionStatus() {
        guard let day = day else { return }

        if day.isSelected {
            applySelectedStyle()
        } else {
            applyDefaultStyle(
                isWithinDisplayedMonth: day.isWithinDisplayedMonth,
                              isBeforeToday: day.isBeforeToday)
        }
    }

    func applySelectedStyle() {
        numberLabel.textColor = .white
        selectionBackgroundView.isHidden = false
    }

    func applyDefaultStyle(isWithinDisplayedMonth: Bool, isBeforeToday: Bool) {
        numberLabel.textColor = isBeforeToday ?
        (.gray4 ?? .label) : .label
        selectionBackgroundView.isHidden = true
    }
}
