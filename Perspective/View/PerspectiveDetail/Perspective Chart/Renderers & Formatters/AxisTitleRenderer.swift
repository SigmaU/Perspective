//
//  AxisTitle.swift
//  Perspective
//
//
//

import UIKit
import Charts


final class customXAxisRenderer: XAxisRenderer {
    var xAxisTitleOffset: CGFloat = 10
    var yAxisTitleOffset: CGFloat = 12
    var titleLabel: String = "Horizontal Axis Title"
    
    override func renderAxisLabels(context: CGContext) {
        // Render the x-labels.
        super.renderAxisLabels(context: context)
        
        // Render the x-axis title using our custom renderer.
        renderTitle(title: titleLabel, inContext: context, x: xAxisTitleOffset, y: yAxisTitleOffset)
    }
}

private extension customXAxisRenderer {
    func renderTitle(title: String, inContext context: CGContext, x: CGFloat, y: CGFloat) {
        guard let xAxis = self.axis as? XAxis else { return }
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: xAxis.labelFont,
            .foregroundColor: xAxis.labelTextColor
        ]
        
        let point = CGPoint(x: viewPortHandler.contentCenter.x - x,
                            y: viewPortHandler.chartHeight - y
        )
        
        // Render the chart title.
        ChartUtils.drawText(context: context,
                            text: title,
                            point: point,
                            attributes: attributes,
                            anchor: .zero,
                            angleRadians: .zero
        )
    }
}

final class customYAxisRenderer: YAxisRenderer {
    var xAxisTitleOffset: CGFloat = 12
    var yAxisTitleOffset: CGFloat = 0
    var titleLabel: String = "Vertical Axis Title"
    
    override func renderAxisLabels(context: CGContext) {
        // Render the y-labels.
        super.renderAxisLabels(context: context)
        
        // Render the y-axis title using our custom renderer.
        renderTitle(title: titleLabel, inContext: context, x: xAxisTitleOffset, y: yAxisTitleOffset)
    }
}

private extension customYAxisRenderer {
    func renderTitle(title: String, inContext context: CGContext, x: CGFloat, y: CGFloat) {
        guard let yAxis = self.axis as? YAxis else { return }
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: yAxis.labelFont,
            .foregroundColor: yAxis.labelTextColor
        ]
        
        // Determine the chart title's y-position.
        let point = CGPoint(x: viewPortHandler.chartWidth - x,
                            y: viewPortHandler.contentCenter.y - y
        )
        
        // Render the chart title.
        ChartUtils.drawText(context: context,
                            text: title,
                            point: point,
                            attributes: attributes,
                            anchor: .zero,
                            angleRadians: .pi / -2
        )
    }
}
