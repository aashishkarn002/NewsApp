//
//  Date+Extension.swift
//  NewsAPP
//
//  Created by Aashish on 8/25/20.
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
    func timeAgoDisplay(date:String) -> String {
        let formatter = RelativeDateTimeFormatter()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from:date)
        //formatter.unitsStyle = .full
        formatter.dateTimeStyle = .named
        formatter.localizedString(from: DateComponents(day: -1))
        return formatter.localizedString(for: self, relativeTo: date!)
    }
    func timeInterval(timeAgo:String) -> String
    {
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US_POSIX")
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ssX"
        let dateWithTime = df.date(from: timeAgo)
        
        let interval = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: dateWithTime!, to: Date())
        
        if let year = interval.year, year > 0 {
            return year == 1 ? "\(year)" + " " + "year ago" : "\(year)" + " " + "years ago"
        } else if let month = interval.month, month > 0 {
            return month == 1 ? "\(month)" + " " + "month ago" : "\(month)" + " " + "months ago"
        } else if let day = interval.day, day > 0 {
            return day == 1 ? "\(day)" + " " + "day ago" : "\(day)" + " " + "days ago"
        }else if let hour = interval.hour, hour > 0 {
            return hour == 1 ? "\(hour)" + " " + "hour ago" : "\(hour)" + " " + "hours ago"
        }else if let minute = interval.minute, minute > 0 {
            return minute == 1 ? "\(minute)" + " " + "minute ago" : "\(minute)" + " " + "minutes ago"
        }else if let second = interval.second, second > 0 {
            return second == 1 ? "\(second)" + " " + "second ago" : "\(second)" + " " + "seconds ago"
        } else {
            return "a moment ago"
            
        }
    }
}
