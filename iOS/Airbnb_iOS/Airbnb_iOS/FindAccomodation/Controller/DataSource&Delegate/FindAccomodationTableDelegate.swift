//
//  FindAccomodationTableDelegate.swift
//  Airbnb_iOS
//
//  Created by 김한솔 on 2022/06/02.
//

import UIKit

final class FindAccomodationTableDelegate: NSObject, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}
