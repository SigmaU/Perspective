//
//  PerspectiveDateFormatter.swift
//  Perspective
//
//  Created by Csaba Kuti on 14/10/2021.
//

import Foundation

func dateFormatter(format: String = "dd-MMM-YYYY", timeZone: String = "UTC", style: DateFormatter.Style = .medium) -> DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = format
    formatter.dateStyle = style
    formatter.timeZone = TimeZone(abbreviation: timeZone)
    return formatter
}

func axisDateFormatter(format: String = "dd-MMM-YYYY", timeZone: String = "UTC") -> DateFormatter {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.dateFormat = format
    formatter.timeZone = TimeZone(abbreviation: timeZone)
    return formatter
}
