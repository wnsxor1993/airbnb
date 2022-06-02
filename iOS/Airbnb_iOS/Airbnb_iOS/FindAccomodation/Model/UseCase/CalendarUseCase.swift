//
//  FindAccomodationUseCase.swift
//  Airbnb_iOS
//
//  Created by 김한솔 on 2022/05/27.
//

import Foundation

protocol CalendarUseCaseDelegate: AnyObject {
    func didChangeDateRange()
    func didSetDate(newDate: Date, indexPathOfNewDate: IndexPath)
    func didSetDateRange(_ dateRange: ClosedRange<Date>)
}

final class CalendarUseCase {
    private var selectedDay1: Date?
    private var selectedDay2: Date?
    private var delegate: CalendarUseCaseDelegate?

    func updateSelectedDay(_ newDate: Date, indexPathOfNewDate: IndexPath) {
        let isSetBothSelectedDays = self.selectedDay1 != nil && self.selectedDay2 != nil

        if isSetBothSelectedDays {
            self.selectedDay1 = newDate
            self.selectedDay2 = nil
            delegate?.didChangeDateRange()
            delegate?.didSetDate(newDate: newDate, indexPathOfNewDate: indexPathOfNewDate)
        } else if let selectedDay1 = selectedDay1 {
            if newDate <= selectedDay1 {
                self.selectedDay2 = selectedDay1
                self.selectedDay1 = newDate
            } else {
                selectedDay2 = newDate
            }
            delegate?.didSetDate(newDate: newDate, indexPathOfNewDate: indexPathOfNewDate)
            if let dateRange = calculateDateRange() {
                delegate?.didSetDateRange(dateRange)
            }
        } else {
            selectedDay1 = newDate
            selectedDay2 = nil
            delegate?.didSetDate(newDate: newDate, indexPathOfNewDate: indexPathOfNewDate)
        }
    }

    func setDelegate(_ delegate: CalendarUseCaseDelegate) {
        self.delegate = delegate
    }
}

private extension CalendarUseCase {
    func calculateDateRange() -> ClosedRange<Date>? {
        guard let selectedDay1 = selectedDay1,
              let selectedDay2 = selectedDay2 else {
            return nil
        }
        return selectedDay1...selectedDay2
    }
}
