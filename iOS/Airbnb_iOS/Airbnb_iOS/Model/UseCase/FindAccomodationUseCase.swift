//
//  FindAccomodationUseCase.swift
//  Airbnb_iOS
//
//  Created by 김한솔 on 2022/05/27.
//

import Foundation

final class FindAccomodationUseCase {
    private var selectedDay1: Date?
    private var selectedDay2: Date?
    private var delegate: FindAccomodationUseCaseDelegate?

    func updateSelectedDay(_ newDay: Date) {
        if self.selectedDay1 != nil && self.selectedDay2 != nil {
            self.selectedDay1 = newDay
            self.selectedDay2 = nil
            delegate?.didChangeDate()
        } else if let selectedDay1 = selectedDay1 {
            if newDay <= selectedDay1 {
                self.selectedDay2 = selectedDay1
                self.selectedDay1 = newDay
            } else {
                selectedDay2 = newDay
            }

            if let dateRange = calculateDateRange() {
                delegate?.didSetDateRange(dateRange)
                self.selectedDay1 = nil
                self.selectedDay1 = nil
            }
        } else {
            selectedDay1 = newDay
            selectedDay2 = nil
        }
    }

    func setDelegate(_ delegate: FindAccomodationUseCaseDelegate) {
        self.delegate = delegate
    }
}

private extension FindAccomodationUseCase {
    func calculateDateRange() -> ClosedRange<Date>? {
        guard let selectedDay1 = selectedDay1,
              let selectedDay2 = selectedDay2 else {
            return nil
        }
        return selectedDay1...selectedDay2
    }
}
