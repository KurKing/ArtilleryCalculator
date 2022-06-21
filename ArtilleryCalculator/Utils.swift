//
//  Utils.swift
//  ArtilleryCalculator
//
//  Created by Oleksiy on 21.06.2022.
//

import UIKit

extension String {
    var sight: String {
        guard let input = Double(self) else {
            return "00"
        }
        return "\(Int((1000.0 - (1000.0 - input) * 1.0659).rounded()))"
    }
}

extension UIColor {
    static var darkRed: UIColor { UIColor(named: "darkRed")! }
}

extension Int {
    func multiplyBy10(times: Int) -> Int {
        return self * Int(pow(10.0, Double(times)))
    }
}
