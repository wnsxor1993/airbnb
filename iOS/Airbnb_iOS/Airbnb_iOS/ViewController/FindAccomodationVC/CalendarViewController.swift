//
//  CalendarViewController.swift
//  Airbnb_iOS
//
//  Created by 김한솔 on 2022/05/30.
//

import UIKit

final class CalendarViewController: UIViewController {

    private lazy var calendarView = CalendarView(frame: view.frame)

    private var selectedDate: Date?
    private var baseDate: Date {
        didSet {
            days = (0..<6).map { offset in
                generateDaysInMonth(for: Calendar.current.date(byAdding: .month, value: offset, to: baseDate) ?? Date())
            }
            calendarView.reloadData()
        }
    }

    private lazy var days: [[Day]] = {
        let days = (0..<12).map { offset in
            generateDaysInMonth(for: Calendar.current.date(byAdding: .month, value: offset, to: baseDate) ?? Date())
        }

        return days
    }()

    private var numberOfWeeksInBaseDate: Int {
        calendar.range(of: .weekOfMonth, in: .month, for: baseDate)?.count ?? 0
    }

    private let calendar = Calendar(identifier: .gregorian)
    private var useCase = CalendarViewControllerUseCase()

    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return dateFormatter
    }()

    private var delegate: CalendarViewControllerDelegate?

    init(baseDate: Date) {
        self.baseDate = baseDate

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view = calendarView
        calendarView.setCollectionViewDelegate(self)
        calendarView.setCollectionViewDataSource(self)
        useCase.setDelegate(self)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        calendarView.reloadData()
    }

    func setDelegate(_ delegate: CalendarViewControllerDelegate) {
        self.delegate = delegate
    }
}

private extension CalendarViewController {
    func monthMetadata(for baseDate: Date) throws -> MonthMetadata {
        guard let numberOfDaysInMonth = calendar.range(of: .day, in: .month, for: baseDate)?.count,
              let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: baseDate)) else {
            throw CalendarDataError.metadataGeneration
        }

        let firstDayWeekday = calendar.component(.weekday, from: firstDayOfMonth)

        return MonthMetadata(
            numberOfdays: numberOfDaysInMonth,
            firstDay: firstDayOfMonth,
            firstDayWeekday: firstDayWeekday)
    }

    func generateDaysInMonth(for baseDate: Date) -> [Day] {
        guard let metadata = try? monthMetadata(for: baseDate) else {
            return []
        }

        let numberOfDaysInMonth = metadata.numberOfdays
        let offsetInInitialRow = metadata.firstDayWeekday
        let firstDayOfMonth = metadata.firstDay

        let days: [Day] = (1..<(numberOfDaysInMonth + offsetInInitialRow))
            .map { day in
                let isWithinDisplayMonth = day >= offsetInInitialRow

                let dayOffset = isWithinDisplayMonth ?
                    day - offsetInInitialRow : -(offsetInInitialRow - day)

                return generateDay(
                    offsetBy: dayOffset,
                    for: firstDayOfMonth,
                    isWithinDisplayMonth: isWithinDisplayMonth
                )
            }

        return days
    }

    func generateDay(offsetBy dayOffset: Int, for baseDate: Date, isWithinDisplayMonth: Bool) -> Day {
        let date = calendar.date(byAdding: .day, value: dayOffset, to: baseDate) ?? baseDate
        let yesterDay = Date(timeIntervalSinceNow: -86400)
        let isBeforeToday = date <= yesterDay
        return Day(
            date: date,
            number: dateFormatter.string(from: date),
            isSelected: false,
            isWithinDisplayedMonth: isWithinDisplayMonth,
            isBeforeToday: isBeforeToday)
    }
}

extension CalendarViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        days[section].count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        days.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCollectionCell.identifier,
                                                            for: indexPath)
                as? CalendarCollectionCell else {
            return UICollectionViewCell()
        }

        let day = days[indexPath.section][indexPath.item]

        cell.day = day

        cell.isHidden = !day.isWithinDisplayedMonth
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CalendarCollectionHeaderView.identifier, for: indexPath) as? CalendarCollectionHeaderView else {
                return UICollectionReusableView()
            }

            headerView.baseDate = Calendar.current.date(byAdding: .month, value: indexPath.section, to: baseDate) ?? Date()

            return headerView
        default:
            return UICollectionReusableView()
        }
    }
}

extension CalendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let yesterDay = Date(timeIntervalSinceNow: -86400)
        guard days[indexPath.section][indexPath.item].date > yesterDay else { return }
        useCase.updateSelectedDay(days[indexPath.section][indexPath.item].date, indexPathOfNewDate: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Int(collectionView.frame.width / 7)
        let height = Int(collectionView.frame.height) / numberOfWeeksInBaseDate

        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = collectionView.frame.width
        let height = String.calculateHeaderHeight(fontSize: 17, weight: .init(rawValue: 700))

        return CGSize(width: width, height: height)
    }
}

extension CalendarViewController: CalendarViewControllerUseCaseDelegate {
    func didChangeDateRange() {
        days = (0..<12).map { offset in
            generateDaysInMonth(for: Calendar.current.date(byAdding: .month, value: offset, to: baseDate) ?? Date())
        }
        calendarView.reloadData()
    }

    func didSetDate(newDate: Date, indexPathOfNewDate: IndexPath) {
        days[indexPathOfNewDate.section][indexPathOfNewDate.item].isSelected = true
        calendarView.reloadItems(at: [indexPathOfNewDate])
    }

    func didSetDateRange(_ dateRange: ClosedRange<Date>) {
        delegate?.didSetDateRange(dateRange)
    }
}

enum CalendarDataError: Error {
    case metadataGeneration
}

protocol CalendarViewControllerDelegate: AnyObject {
    func didSetDateRange(_ dateRange: ClosedRange<Date>)
}
