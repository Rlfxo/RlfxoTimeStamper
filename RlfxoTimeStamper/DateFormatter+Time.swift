//
//  DateFormatter+Time.swift
//  RlfxoTimeStamper
//
//  Created by 임길태 on 2021/12/17.
//

import Foundation

extension DateFormatter {
    static let shortTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY년 M월d일"
        formatter.locale = Locale(identifier: "ko-kr")
        return formatter
    }()
}
extension RelativeDateTimeFormatter {
    static let relativeTimeFormatter: RelativeDateTimeFormatter = {
        let formatter = RelativeDateTimeFormatter()
        formatter.locale = Locale(identifier: "ko-kr")
        formatter.dateTimeStyle = .named
        return formatter
    }()
}

extension DateFormatter: ObservableObject {
    
}

extension RelativeDateTimeFormatter: ObservableObject {
    
}
