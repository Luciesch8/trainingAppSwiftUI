//
//  Chart.swift
//  SportApp
//
//  Created by Ah lucie nous gênes 🍄 on 12/01/2023.
//

import SwiftUI

struct ChartModel: Identifiable {
    var id = UUID().uuidString
    var hours : Date
    var views : Double
    var animated : Bool = false
}

extension Date{
    func updateHours(value: Int)->Date{
        let calendar = Calendar.current
        return calendar.date(bySettingHour: value, minute: 0, second: 0, of: self) ?? .now
    }
}

var sample_analytics : [ChartModel] = [
    ChartModel(hours: Date().updateHours(value: 8), views: 1500),
    ChartModel(hours: Date().updateHours(value: 9), views: 3500),
    ChartModel(hours: Date().updateHours(value: 10), views: 1600),
    ChartModel(hours: Date().updateHours(value: 11), views: 4500),
    ChartModel(hours: Date().updateHours(value: 12), views: 1500),
    ChartModel(hours: Date().updateHours(value: 13), views: 1900),
    ChartModel(hours: Date().updateHours(value: 14), views: 2500),
    ChartModel(hours: Date().updateHours(value: 15), views: 2000),
    ChartModel(hours: Date().updateHours(value: 16), views: 3500),
    ChartModel(hours: Date().updateHours(value: 17), views: 4500),
    ChartModel(hours: Date().updateHours(value: 18), views: 1900),
    ChartModel(hours: Date().updateHours(value: 19), views: 2500),
    ChartModel(hours: Date().updateHours(value: 20), views: 1300),
    ChartModel(hours: Date().updateHours(value: 21), views: 1200),
]
