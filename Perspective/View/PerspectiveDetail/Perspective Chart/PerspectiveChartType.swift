//
//  PerspectiveChartType.swift
//  Perspective
//
//  Created by Csaba Kuti on 18/08/2021.
//

import Foundation
import UIKit

enum ChartType: String {
    case timeSeries = "Time Series"
    case contingency = "Contingency"
    case habit = "Habit"
    case sequential = "Sequential"
}

public final class PerspectiveChartType: NSObject {
    var type: String
    var xAxisType: Any.Type
    var yAxisType: Double.Type
    var hasDataName: Bool = false
    var hasDate: Bool = false
    var sortType: String
    var color: PerspectiveColor
    var verticalLine: Double?
    var horizontalLine: Double?
    
    init(_ chartTypeSelected: ChartType) {
        type = chartTypeSelected.rawValue
        switch chartTypeSelected {
        case .timeSeries:
            xAxisType = Date.self
            yAxisType = Double.self
            sortType = "x"
            hasDate = true
            color = PerspectiveBlue()
        case .contingency:
            xAxisType = Double.self
            yAxisType = Double.self
            sortType = "timeStamp"
            hasDataName = true
            color = PerspectiveGreen()
        case .habit:
            xAxisType = Date.self
            yAxisType = Double.self
            sortType = "x"
            hasDate = true
            color = PerspectivePurple()
        default:
            xAxisType = Double.self
            yAxisType = Double.self
            sortType = "x"
            color = PerspectivePurple()
        }
    }
}
