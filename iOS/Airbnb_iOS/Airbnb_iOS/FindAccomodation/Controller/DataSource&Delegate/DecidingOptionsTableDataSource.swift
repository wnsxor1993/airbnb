//
//  DecidingOptionsTableDataSource.swift
//  Airbnb_iOS
//
//  Created by 김한솔 on 2022/06/02.
//

import UIKit

final class DecidingOptionsTableDataSource: NSObject {
    var reservationInfo: [AccomodationData] = [
        .location(.init()),
        .accomodationPeriod(.init()),
        .budget(price: nil),
        .headCount(.init())
    ]
}

extension DecidingOptionsTableDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reservationInfo.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DecidedOptionsCell.identifier, for: indexPath) as? DecidedOptionsCell else {
            return UITableViewCell()
        }
        cell.setTitleLabel(reservationInfo[indexPath.row].title)
        cell.setDesctiption(reservationInfo[indexPath.row].data)

        return cell
    }
}
