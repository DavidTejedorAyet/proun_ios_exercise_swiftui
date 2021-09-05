//
//  Date.swift
//  proun-ios-exercise-swiftui
//
//  Created by David on 5/9/21.
//

import Foundation

extension Date {
    
    func isEqual(to date: Date, toGranularity component: Calendar.Component, in calendar: Calendar = .current) -> Bool {
        calendar.isDate(self, equalTo: date, toGranularity: component)
    }
    
    func isInSameMonth(as date: Date) -> Bool { isEqual(to: date, toGranularity: .month) }
    var isInThisMonth: Bool { isInSameMonth(as: Date()) }
}
