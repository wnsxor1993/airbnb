//
//  SelectCalendarView.swift
//  Airbnb_iOS
//
//  Created by 김한솔 on 2022/05/25.
//

import UIKit
import HorizonCalendar

final class SelectCalendarView: UIView {

    private lazy var calendarView = CalendarView(initialContent: makeContent())
    private var selectedDay1: Date?
    private var selectedDay2: Date?
    private var selectedDateRange: ClosedRange<Date>?
    weak var delegate: SelectCalendarDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setUpLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    func setCalendarHandler(_ handler: ((Day) -> Void)?) {
        calendarView.daySelectionHandler = handler
    }

    func setDateRange(_ dateRange: ClosedRange<Date>) {
        selectedDateRange = dateRange
        calendarView.setContent(makeContent())
        delegate?.didPresentDateRange(dateRange)
    }

    func setSelectedDay(_ date: Date) {
        if selectedDateRange != nil {
            selectedDateRange = nil
        }
        if selectedDay1 != nil &&
            selectedDay2 != nil {
            selectedDay1 = date
            selectedDay2 = nil
        } else if selectedDay1 != nil {
            selectedDay2 = date
        } else {
            selectedDay1 = date
            selectedDay2 = nil
        }

        let newContent = makeContent()
        calendarView.setContent(newContent)
    }
}

private extension SelectCalendarView {
    func makeContent() -> CalendarViewContent {
        let calendar = Calendar.current

        let startDate = Date()
        let endDate = calendar.date(byAdding: DateComponents(year: 1), to: startDate) ?? Date()
        let mockDate = calendar.date(from: DateComponents(year: 1999, month: 05, day: 01)) ?? Date()
        var dateRangeToHighlight = mockDate...mockDate
        if let selectedDateRange = selectedDateRange {
            dateRangeToHighlight = selectedDateRange
        }

        return CalendarViewContent(calendar: calendar,
                                   visibleDateRange: startDate...endDate,
                                   monthsLayout: .vertical(options: VerticalMonthsLayoutOptions()))
        .dayRangeItemProvider(for: [dateRangeToHighlight], { dayRangeLayoutContext in
            CalendarItemModel<DayRangeIndicatorView>(
                invariantViewProperties: .init(), viewModel: .init(framesOfDaysToHighlight: dayRangeLayoutContext.daysAndFrames.map { $0.frame })
            )
        })
        .dayItemProvider { [weak self] day in
            var invariantViewProperties = DayLabel.InvariantViewProperties(font: .systemFont(ofSize: 18), textColor: .darkGray, backgroundColor: .clear)

            if day.toDate() == self?.selectedDay1 ||
                day.toDate() == self?.selectedDay2 {
                invariantViewProperties.textColor = .white
                invariantViewProperties.backgroundColor = .black
            }

            return CalendarItemModel<DayLabel>(
                invariantViewProperties: invariantViewProperties, viewModel: .init(day: day)
            )
        }
        .interMonthSpacing(24)
        .verticalDayMargin(8)
    }

    func setUpLayout() {
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(calendarView)

        NSLayoutConstraint.activate([
            calendarView.leadingAnchor.constraint(equalTo: leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: trailingAnchor),
            calendarView.topAnchor.constraint(equalTo: topAnchor),
            calendarView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

protocol SelectCalendarDelegate: AnyObject {
    func didUpdateDay(_ newDay: Day)
    func didPresentDateRange(_ dateRange: ClosedRange<Date>)
}
