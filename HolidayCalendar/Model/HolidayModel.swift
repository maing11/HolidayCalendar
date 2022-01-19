//
//  HolidayModel.swift
//  HolidayCalendar
//
//  Created by mai nguyen on 1/18/22.
//

import Foundation


struct HolidayModel: Decodable {
    var response: Holidays
}

struct Holidays: Decodable {
    var holidays: [HolidayDetail]
}

struct HolidayDetail: Decodable {
    var name: String
    var date: DateInfo
}

struct DateInfo: Decodable {
    var iso: String
}


extension Date {
    var year: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "mm-dd-yyyy"
        let year = formatter.string(from: self)
        return year
    }
}
