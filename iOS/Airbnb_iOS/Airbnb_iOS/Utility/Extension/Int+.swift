//
//  Int+.swift
//  Airbnb_iOS
//
//  Created by 김한솔 on 2022/06/03.
//

import Foundation

extension Int {
    func toKRW() -> String {
        var reversed = String("\(self)".reversed())
        var splitted = [String]()
        let offset = 3

        while reversed.count > offset {
            let startPoint = reversed.startIndex
            let endPoint = reversed.index(startPoint, offsetBy: offset)

            splitted.append(String(reversed[startPoint..<endPoint].reversed()))
            reversed.removeSubrange(startPoint..<endPoint)

            if reversed.count <= offset {
                splitted.append(String(reversed.reversed()))
            }
        }

        return splitted.reversed().joined(separator: ",") + "원"
    }
}
