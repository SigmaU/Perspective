//
//  AppDelegate+Shared.swift
//  Perspective
//
//  Created by Csaba Kuti on 05/07/2021.
//

import UIKit

extension AppDelegate {
    static var shared: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
}
