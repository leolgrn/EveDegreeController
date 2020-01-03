//
//  ChartFormatter.swift
//  EveDegreeController
//
//  Created by Léo LEGRON on 03/01/2020.
//  Copyright © 2020 Léo LEGRON. All rights reserved.
//

import Foundation
import Charts

class ChartXAxisFormatter: NSObject {
    fileprivate var dateFormatter: DateFormatter?

    convenience init(dateFormatter: DateFormatter) {
        self.init()
        self.dateFormatter = dateFormatter
    }
}


extension ChartXAxisFormatter: IAxisValueFormatter {

    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        guard let dateFormatter = dateFormatter
        else {
            return ""
        }

        let date = Date(timeIntervalSince1970: value)
        return dateFormatter.string(from: date)
    }

}
