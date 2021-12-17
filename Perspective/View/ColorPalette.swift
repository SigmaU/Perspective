//
//  ColorPalette.swift
//  Perspective
//
//  Created by Csaba Kuti on 28/09/2021.
//

import UIKit

protocol PerspectiveColor {
    var black: UIColor { get }
    var dark: UIColor { get }
    var epicenter: UIColor { get }
    var major: UIColor { get }
    var center: UIColor { get }
    var minor: UIColor { get }
    var gray: UIColor { get }
    var white: UIColor { get }
}

struct PerspectivePurple: PerspectiveColor {
    var black: UIColor { return UIColor(red: 41 / 255.0, green: 16 / 255.0, blue: 34 / 255.0, alpha: 1) }
    var dark: UIColor { return UIColor(red: 77 / 255.0, green: 31 / 255.0, blue: 60 / 255.0, alpha: 1) }
    var epicenter: UIColor { return UIColor(red: 110 / 255.0, green: 45 / 255.0, blue: 86 / 255.0, alpha: 1) }
    var major: UIColor { return UIColor(red: 128 / 255.0, green: 62 / 255.0, blue: 104 / 255.0, alpha: 1) }
    var center: UIColor { return UIColor(red: 148 / 255.0, green: 72 / 255.0, blue: 120 / 255.0, alpha: 1) }
    var minor: UIColor { return UIColor(red: 207 / 255.0, green: 161 / 255.0, blue: 185 / 255.0, alpha: 1) }
    var gray: UIColor { return UIColor(red: 230 / 255.0, green: 207 / 255.0, blue: 219 / 255.0, alpha: 1) }
    var white: UIColor { return UIColor(red: 228 / 255.0, green: 236 / 255.0, blue: 221 / 255.0, alpha: 1) }
}

struct PerspectiveBlue: PerspectiveColor {
    var black: UIColor { return UIColor(red: 16 / 255.0, green: 27 / 255.0, blue: 41 / 255.0, alpha: 1) }
    var dark: UIColor { return UIColor(red: 31 / 255.0, green: 52 / 255.0, blue: 77 / 255.0, alpha: 1) }
    var epicenter: UIColor { return UIColor(red: 55 / 255.0, green: 91 / 255.0, blue: 135 / 255.0, alpha: 1) }
    var major: UIColor { return UIColor(red: 75 / 255.0, green: 110 / 255.0, blue: 153 / 255.0, alpha: 1) }
    var center: UIColor { return UIColor(red: 92 / 255.0, green: 136 / 255.0, blue: 189 / 255.0, alpha: 1) }
    var minor: UIColor { return UIColor(red: 161 / 255.0, green: 182 / 255.0, blue: 207 / 255.0, alpha: 1) }
    var gray: UIColor { return UIColor(red: 207 / 255.0, green: 217 / 255.0, blue: 230 / 255.0, alpha: 1) }
    var white: UIColor { return UIColor(red: 223 / 255.0, green: 229 / 255.0, blue: 237 / 255.0, alpha: 1) }
}

struct PerspectiveGreen: PerspectiveColor {
    var black: UIColor { return UIColor(red: 21 / 255.0, green: 41 / 255.0, blue: 16 / 255.0, alpha: 1) }
    var dark: UIColor { return UIColor(red: 40 / 255.0, green: 77 / 255.0, blue: 31 / 255.0, alpha: 1) }
    var epicenter: UIColor { return UIColor(red: 70 / 255.0, green: 135 / 255.0, blue: 55 / 255.0, alpha: 1) }
    var major: UIColor { return UIColor(red: 89 / 255.0, green: 153 / 255.0, blue: 75 / 255.0, alpha: 1) }
    var center: UIColor { return UIColor(red: 110 / 255.0, green: 189 / 255.0, blue: 92 / 255.0, alpha: 1) }
    var minor: UIColor { return UIColor(red: 169 / 255.0, green: 207 / 255.0, blue: 161 / 255.0, alpha: 1) }
    var gray: UIColor { return UIColor(red: 211 / 255.0, green: 230 / 255.0, blue: 207 / 255.0, alpha: 1) }
    var white: UIColor { return UIColor(red: 226 / 255.0, green: 237 / 255.0, blue: 223 / 255.0, alpha: 1) }
}
