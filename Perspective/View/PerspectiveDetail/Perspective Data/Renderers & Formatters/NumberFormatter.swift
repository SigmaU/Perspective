//
//  NumberFormatter.swift
//  Perspective
//
//  Added by Csaba Kuti on 30/09/2021.
//

import Foundation

extension String {
    static let numberFormatter = NumberFormatter()
    
    var doubleValue: Double? {
        String.numberFormatter.decimalSeparator = "."
        if let result =  String.numberFormatter.number(from: self) {
            return result.doubleValue
        } else {
            String.numberFormatter.decimalSeparator = ","
            if let result = String.numberFormatter.number(from: self) {
                return result.doubleValue
            } else {
                return nil
            }
        }
    }
}
