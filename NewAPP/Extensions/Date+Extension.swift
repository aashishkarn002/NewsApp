//
//  Date+Extension.swift
//  NewsAPP
//
//  Created by Cellcom on 8/25/20.
//  Copyright © 2020 aashish. All rights reserved.
//

import Foundation
extension Date {
   func formattedCurrentDateTimeString() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "dd MMM,yyyy"
        let result = formatter.string(from: date)
        return result
    }
}
