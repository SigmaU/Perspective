//
//  PerspectiveChartViewController+AxisTitles.swift
//  Perspective
//
//  Created by Csaba Kuti on 01/11/2021.
//

import UIKit

extension PerspectiveChartViewController {
    
    func setupAxisTitles() {
    
    chartView.extraRightOffset = CGFloat(10)
    let yAxisRenderer = customYAxisRenderer(viewPortHandler: chartView.viewPortHandler,
                                            yAxis: chartView.leftAxis,
                                            transformer: chartView.getTransformer(forAxis: .left)
    )

    let yUnit = perspective.yAxisUnit.isEmpty ? "" : " (\(perspective.yAxisUnit))"
    let yTitleLabel = perspective.yAxisName.isEmpty ? "Y Axis Title" : perspective.yAxisName
    yAxisRenderer.titleLabel = yTitleLabel + yUnit
    yAxisRenderer.yAxisTitleOffset = CGFloat(yAxisRenderer.titleLabel.count) * 2.4
    chartView.leftYAxisRenderer = yAxisRenderer

    chartView.extraBottomOffset = CGFloat(20)
    let xAxisRenderer = customXAxisRenderer(viewPortHandler: chartView.viewPortHandler,
                                            xAxis: chartView.xAxis,
                                            transformer: chartView.getTransformer(forAxis: .left)
    )

    let xUnit = perspective.xAxisUnit.isEmpty ? "" : " (\(perspective.xAxisUnit))"
    let xTitleLabel = perspective.xAxisName.isEmpty ? "X Axis Title" : perspective.xAxisName
    xAxisRenderer.titleLabel = xTitleLabel + xUnit
    xAxisRenderer.xAxisTitleOffset = CGFloat(xAxisRenderer.titleLabel.count) * 2.4
    xAxisRenderer.yAxisTitleOffset = CGFloat(15)
    chartView.xAxisRenderer = xAxisRenderer
    
    }
}

