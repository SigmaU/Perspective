//
//  Model.swift
//  Perspective
//
//  Created by Csaba on 25.11.2021.
//

import Foundation


// MARK: - Model
struct _Model: Codable {
    let folders: [_Folder]

    enum CodingKeys: String, CodingKey {
        case folders = "Folders"
    }
}

// MARK: - Folder
struct _Folder: Codable {
    let timeStamp: String
    let name: String
    let perspectives: [_Perspective]

    enum CodingKeys: String, CodingKey {
        case timeStamp = "timeStamp"
        case name = "name"
        case perspectives
    }
}

// MARK: - Perspective
struct _Perspective: Codable {
    let properties: _Properties
    let dataSeries: [_DataSeries]

    enum CodingKeys: String, CodingKey {
        case properties = "Properties"
        case dataSeries = "DataSeries"
    }
}

// MARK: - Properties:
struct _Properties: Codable {
    let timestamp, name, type, yAxisName, xAxisName : String
    let yAxisUnit, xAxisUnit, horizontalLine, verticalLine : String
}

// MARK: - DataSeries
struct _DataSeries: Codable {
    let timeStamp, name, x, y: String
}
