//
//  CalendarViewController.swift
//  Airbnb_iOS
//
//  Created by 김한솔 on 2022/05/30.
//

import UIKit

protocol CalendarViewControllerDelegate: AnyObject {
    func didSetDateRange(_ dateRange: ClosedRange<Date>)
    func didChangeDateRange()
}

final class CalendarViewController: UIViewController {

    private lazy var calendarView = CalendarView(frame: view.frame)

    private var collectionDataSource: CalendarCollectionDataSource
    private var selectedDate: Date?
    private var useCase = CalendarUseCase()

    private weak var delegate: CalendarViewControllerDelegate?

    init(baseDate: Date) {
        collectionDataSource = CalendarCollectionDataSource(baseDate: baseDate)
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view = calendarView
        setCalendarView()
        useCase.setDelegate(self)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        calendarView.reloadData()
    }

    func setDelegate(_ delegate: CalendarViewControllerDelegate) {
        self.delegate = delegate
    }

    func resetSelectedCells() {
        collectionDataSource.resetDays()
    }
}

private extension CalendarViewController {
    func setCalendarView() {
        calendarView.setCollectionViewDelegate(self)
        calendarView.setCollectionViewDataSource(collectionDataSource)
        collectionDataSource.onUpdate = { [weak self] in
            self?.calendarView.reloadData()
        }
        collectionDataSource.resetDays()
    }
}

extension CalendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let yesterDay = Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()
        guard collectionDataSource.days[indexPath.section][indexPath.item].date > yesterDay else { return }
        useCase.updateSelectedDay(collectionDataSource.days[indexPath.section][indexPath.item].date, indexPathOfNewDate: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Int(collectionView.frame.width / 7)
        let height = Int(collectionView.frame.height) / collectionDataSource.numberOfWeeksInBaseDate

        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = collectionView.frame.width
        let height = String.calculateHeaderHeight(fontSize: 17, weight: .init(rawValue: 700))

        return CGSize(width: width, height: height)
    }
}

extension CalendarViewController: CalendarUseCaseDelegate {
    func didChangeDateRange() {
        collectionDataSource.resetDays()
        calendarView.reloadData()
        delegate?.didChangeDateRange()
    }

    func didSetDate(newDate: Date, indexPathOfNewDate: IndexPath) {
        collectionDataSource.days[indexPathOfNewDate.section][indexPathOfNewDate.item].isSelected = true
        calendarView.reloadItems(at: [indexPathOfNewDate])
    }

    func didSetDateRange(_ dateRange: ClosedRange<Date>) {
        delegate?.didSetDateRange(dateRange)
    }
}

enum CalendarDataError: Error {
    case metadataGeneration
}
