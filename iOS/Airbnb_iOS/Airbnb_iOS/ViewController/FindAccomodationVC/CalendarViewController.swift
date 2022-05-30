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
            days = generateDaysInMonth(for: baseDate)
            calendarView.reloadData()
        }
    }

    private lazy var days = generateDaysInMonth(for: baseDate)

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
        calendarView.setHeaderViewBaseDate(baseDate)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        calendarView.reloadData()
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
        days.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCollectionCell.identifier,
                                                            for: indexPath)
                as? CalendarCollectionCell else {
            return UICollectionViewCell()
        }

        let day = days[indexPath.item]

        cell.day = day

        cell.isHidden = !day.isWithinDisplayedMonth
        return cell
    }
}

extension CalendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let yesterDay = Date(timeIntervalSinceNow: -86400)
        guard days[indexPath.item].date > yesterDay else { return }
        useCase.updateSelectedDay(days[indexPath.item].date, indexPathOfNewDate: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Int(collectionView.frame.width / 7)
        let height = Int(collectionView.frame.height) / numberOfWeeksInBaseDate

        return CGSize(width: width, height: height)
    }
}

extension CalendarViewController: CalendarViewControllerUseCaseDelegate {
    func didChangeDateRange() {
        var newDays = [Day]()
        for day in days {
            let newDay = Day(date: day.date,
                             number: day.number,
                             isSelected: false,
                             isWithinDisplayedMonth: day.isWithinDisplayedMonth,
                             isBeforeToday: day.isBeforeToday)
            newDays.append(newDay)
        }

        days = newDays
        calendarView.reloadData()
    }

    func didSetDate(newDate: Date, indexPathOfNewDate: IndexPath) {
        days[indexPathOfNewDate.item].isSelected = true
        calendarView.reloadItems(at: [indexPathOfNewDate])
    }

    func didSetDateRange(_ dateRange: ClosedRange<Date>) {

    }
}

enum CalendarDataError: Error {
    case metadataGeneration
}
