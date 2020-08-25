//
//  String+Extension.swift
//  NewsAPP
//
//  Created by Aashish on 8/25/20.
//  Copyright © 2020 aashish. All rights reserved.
//

import Foundation
extension String {
    
    func formatDateTimeString(_ format:String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = formatter.date(from: self)!
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    func formatAPIDateTimeString(_ format:String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssX"
        let date = formatter.date(from: self)!
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
}
