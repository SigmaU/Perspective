//
//  BalloonMarker.swift
//  ChartsDemo
//
//  Copyright 2015 Daniel Cohen Gindi & Philipp Jahoda
//  Added & adapted by Csaba Kuti on 19/08/2021.
//  A port of MPAndroidChart for iOS
//  Licensed under Apache License 2.0
//
//  https://github.com/danielgindi/Charts
//
//  Variations by Csaba Kuti on 09/11/2020.

import Foundation
import Charts
#if canImport(UIKit)
import UIKit
#endif

open class BalloonMarker: MarkerImage
{
    @objc open var color: UIColor
    @objc open var arrowSize = CGSize(width: 15, height: 11)
    @objc open var font: UIFont
    @objc open var textColor: UIColor
    @objc open var insets: UIEdgeInsets
    @objc open var minimumSize = CGSize()
    
    var chartSize: CGSize!
    var chartType: ChartType!
    var displayRoundedValue = Bool()
    var xAxisName = String()
    var yAxisName = String()
    var xUnitM = String()
    var yUnitM = String()
    
    @objc open var labelText: String?
    @objc open var roundedRect = CGRect()
    @objc open var highlighted = Int()
    @objc open var cornerRadius = CGFloat()
    @objc open var roundedRectOffset = CGFloat()
    
    fileprivate var _labelSize: CGSize = CGSize()
    fileprivate var _paragraphStyle: NSMutableParagraphStyle?
    fileprivate var _drawAttributes = [NSAttributedString.Key : Any]()
    
    @objc public init(color: UIColor, font: UIFont, textColor: UIColor, insets: UIEdgeInsets)
    {
        self.color = color
        self.font = font
        self.textColor = textColor
        self.insets = insets
        
        _paragraphStyle = NSParagraphStyle.default.mutableCopy() as? NSMutableParagraphStyle
        _paragraphStyle?.alignment = .center
        super.init()
    }
    
    open override func offsetForDrawing(atPoint point: CGPoint) -> CGPoint
    {
        var offset = self.offset
        var size = self.size
        
        if size.width == 0.0 && image != nil
        {
            size.width = image!.size.width
        }
        if size.height == 0.0 && image != nil
        {
            size.height = image!.size.height
        }
        
        let width = size.width
        let height = size.height
        let padding: CGFloat = 8.0
        
        var origin = CGPoint(x: point.x, y: point.y)
        origin.x -= width / 2
        origin.y -= height
        
        if origin.x + offset.x < 0.0
        {
            offset.x = -origin.x + padding
        }
        else if let chart = chartView,
                origin.x + width + offset.x > chart.bounds.size.width
        {
            offset.x = chart.bounds.size.width - origin.x - width - padding
        }
        
        if origin.y + offset.y < 0
        {
            offset.y = height + padding;
        }
        else if let chart = chartView,
                origin.y + height + offset.y > chart.bounds.size.height
        {
            offset.y = chart.bounds.size.height - origin.y - height - padding
        }
        
        return offset
    }
    
    open override func draw(context: CGContext, point: CGPoint)
    {
        guard let labelText = labelText else { return }
        
        let offset = self.offsetForDrawing(atPoint: point)
        let size = self.size
        
        var rect = CGRect(
            origin: CGPoint(
                x: point.x + offset.x,
                y: point.y + offset.y),
            size: size)
        rect.origin.x -= size.width / 2.0
        rect.origin.y -= size.height
        
        if cornerRadius > 0 {
            roundedRectOffset = (rect.size.height - arrowSize.height)
            roundedRect = CGRect(
                origin: CGPoint(
                    x: point.x + offset.x,
                    y: point.y + offset.y),
                size: CGSize(width: size.width, height: size.height - arrowSize.height))
            roundedRect.origin.x -= size.width / 2.0
            roundedRect.origin.y -= size.height
        }
        
        context.saveGState()
        context.setFillColor(color.cgColor)
        
        if chartSize != nil && rect.size.width > (chartSize.width - rect.origin.x) {
            rect.origin.x -= (rect.size.width - (chartSize.width - rect.origin.x))
            roundedRect.origin.x -= (roundedRect.size.width - (chartSize.width - roundedRect.origin.x))
        }
        
        if offset.y > 0
        {
            context.beginPath()
            context.move(to: CGPoint(
                            x: rect.origin.x,
                            y: rect.origin.y + arrowSize.height))
            context.addLine(to: CGPoint(
                                x: rect.origin.x + (rect.size.width - arrowSize.width) / 2.0,
                                y: rect.origin.y + arrowSize.height))
            //arrow vertex
            context.addLine(to: CGPoint(
                                x: point.x,
                                y: point.y))
            context.addLine(to: CGPoint(
                                x: rect.origin.x + (rect.size.width + arrowSize.width) / 2.0,
                                y: rect.origin.y + arrowSize.height))
            //balloon body
            context.addPath(CGPath(roundedRect: roundedRect,
                                   cornerWidth: cornerRadius,
                                   cornerHeight: cornerRadius,
                                   transform: nil))
            
            context.fillPath()
        }
        else
        {
            context.beginPath()
            context.move(to: CGPoint(
                            x: rect.origin.x,
                            y: rect.origin.y + roundedRectOffset))
            context.addLine(to: CGPoint(
                                x: rect.origin.x + rect.size.width,
                                y: rect.origin.y + roundedRectOffset))
            context.addLine(to: CGPoint(
                                x: rect.origin.x + rect.size.width,
                                y: rect.origin.y + rect.size.height - arrowSize.height))
            context.addLine(to: CGPoint(
                                x: rect.origin.x + (rect.size.width + arrowSize.width) / 2.0,
                                y: rect.origin.y + rect.size.height - arrowSize.height))
            //arrow vertex
            context.addLine(to: CGPoint(
                                x: point.x,
                                y: point.y))
            context.addLine(to: CGPoint(
                                x: rect.origin.x + (rect.size.width - arrowSize.width) / 2.0,
                                y: rect.origin.y + rect.size.height - arrowSize.height))
            //balloon body
            context.addPath(CGPath(roundedRect: roundedRect,
                                   cornerWidth: cornerRadius,
                                   cornerHeight: cornerRadius,
                                   transform: nil))
            
            context.fillPath()
        }
        
        rect.origin.y += self.insets.top
        rect.size.height -= (self.insets.top) + self.insets.bottom
        UIGraphicsPushContext(context)
        labelText.draw(in: rect, withAttributes: _drawAttributes)
        
        UIGraphicsPopContext()
        context.restoreGState()
    }
    
    open override func refreshContent(entry: ChartDataEntry, highlight: Highlight)
    {
        let xValue = displayRoundedValue ? String(Int(entry.x.rounded())) : String(entry.x)
        let yValue = displayRoundedValue ? String(Int(entry.y.rounded())) : String(entry.y)
        
        switch chartType! {
        case ChartType.timeSeries:
            let hLabel = String(entry.y) + " \(yUnitM)"
            setLabel(hLabel + "\n" + (entry.data as! String))
        case ChartType.contingency:
            let hLabel = yAxisName + ": " + yValue + " \(yUnitM)" + "\n" + xAxisName + ": " + xValue + " \(xUnitM)"
            setLabel((entry.data as! String) + "\n" + hLabel)
        case ChartType.habit:
            let hLabel =  yAxisName + ": " + yValue + " \(yUnitM)"
            setLabel((entry.data as! String) + "\n" + hLabel)
        default:
            let hLabel = yAxisName + ": " + String(entry.y) + " \(yUnitM)" + "\n" + xAxisName + ": " + (entry.data as! String)
            setLabel(hLabel)
        }
    }
    
    @objc open func setLabel(_ newLabel: String)
    {
        labelText = newLabel
        
        _drawAttributes.removeAll()
        _drawAttributes[.font] = self.font
        _drawAttributes[.paragraphStyle] = _paragraphStyle
        _drawAttributes[.foregroundColor] = self.textColor
        
        _labelSize = labelText?.size(withAttributes: _drawAttributes) ?? CGSize.zero
        
        var size = CGSize()
        size.width = _labelSize.width + self.insets.left + self.insets.right
        size.height = _labelSize.height + self.insets.top + self.insets.bottom
        size.width = max(minimumSize.width, size.width)
        size.height = max(minimumSize.height, size.height)
        self.size = size
    }
    
}
