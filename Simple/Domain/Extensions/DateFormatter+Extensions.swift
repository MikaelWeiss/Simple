//
//  DateFormatter+Extensions.swift
//  Simple
//
//  Created by Mikael Weiss on 3/27/21.
//

import Foundation

extension DateFormatter {
    class var standard: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        return dateFormatter
    }
}
