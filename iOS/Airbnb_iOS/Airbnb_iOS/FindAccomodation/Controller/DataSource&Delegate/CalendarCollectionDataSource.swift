//
//  CalendarCollectionDataSource.swift
//  Airbnb_iOS
//
//  Created by 김한솔 on 2022/06/02.
//

import UIKit

final class CalendarCollectionDataSource: NSObject {
    private var baseDate: Date
    private let calendar = Calendar(identifier: .gregorian)
    var days: [[Day]] = []
    var numberOfWeeksInBaseDate: Int {
        calendar.range(of: .weekOfMonth, in: .month, for: baseDate)?.count ?? 0
    }

    var onUpdate: (() -> Void) = {}

    init(baseDate: Date) {
        self.baseDate = baseDate
    }

    func resetDays() {
        days = (0..<12).map { offset in
            generateDaysInMonth(for: calendar.date(byAdding: .month, value: offset, to: baseDate) ?? Date())
        }
        onUpdate()
    }
}

extension CalendarCollectionDataSource: UICollectionViewDataSource {
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

private extension CalendarCollectionDataSource {
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
            number: DateConverter.convertToDayString(date: date),
            isSelected: false,
            isWithinDisplayedMonth: isWithinDisplayMonth,
            isBeforeToday: isBeforeToday)
    }
}
