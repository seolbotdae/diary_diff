//
//  Date+DateFormatter.swift
//  NC1
//
//  Created by Seol WooHyeok on 4/14/24.
//

import Foundation

extension Date {
    static func getDateFormatter(format: String) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "ko_KR")
        
        return dateFormatter
    }
    
    static func getParsedDate(date: Date) -> Int {
        let formatter = Date.getDateFormatter(format: "yyyyMMdd")
        formatter.locale = Locale(identifier: "ko_KR")
        let dateString = formatter.string(from: date)
        
        return Int(dateString) ?? 0
    }
    
    static func getDateId(date: Date) -> Int {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyyMMdd"
        
        let str = dateFormatter.string(from: date)
        
        return Int(str) ?? -1
    }
    
    static func getYYYYMMDDString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy.MM.dd"
        
        let str = dateFormatter.string(from: date)
        
        return str
    }
}
