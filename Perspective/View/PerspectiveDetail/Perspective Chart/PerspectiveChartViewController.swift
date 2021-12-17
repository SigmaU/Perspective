//
//  ChartViewController.swift
//  Perspective
//
//  Created by Csaba Kuti on 15/04/2021.
//

import UIKit
import Charts
import CoreData

final class PerspectiveChartViewController: UIViewController, ChartViewDelegate {
    
    lazy var appDelegate = AppDelegate.shared
    lazy var dataStorage = appDelegate.dataStorage
    lazy var managedContext = dataStorage.viewContext

    var perspectiveID: NSManagedObjectID!
    var perspective: Perspective! {
        self.managedContext.object(with: self.perspectiveID) as? Perspective
    }
    var perspectiveChart: PerspectiveChartType!
    var chartColor: UIColor!
    
    var referenceTimeInterval: TimeInterval = 0
    var entriesDate = [String]()
    var entries: [PerspectiveData] {
        perspective.has?.map { $0 } ?? []
    }
    
    @IBOutlet weak var chartView: CombinedChartView!
    
    var combData = CombinedChartData()
    var dataEntries: [ChartDataEntry] = [ChartDataEntry]()
    var barDataEntries: [BarChartDataEntry] = [BarChartDataEntry]()
    var dataNames: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        perspectiveChart = PerspectiveChartType(ChartType(rawValue: perspective.type)!)
        
        NotificationCenter.default.addObserver(self, selector: #selector(dataChanged), name: .NSManagedObjectContextObjectsDidChange, object: managedContext)
        view.layer.cornerRadius = 7
        setupChart()
    }
    @objc private func dataChanged() {
        setupChart()
    }
    
    private func setupChart() {
        
        dataEntries.removeAll()
        barDataEntries.removeAll()
        entries.forEach {
            if perspectiveChart.hasDate {
                dataEntries.append(ChartDataEntry(x: ($0.x - referenceTimeInterval) / (3600 * 24), y: $0.y, data: $0.name))
                barDataEntries.append(BarChartDataEntry(x: ($0.x - referenceTimeInterval) / (3600 * 24), y: $0.y, data: $0.name))
                dataNames.append($0.name!)
            } else {
                dataEntries.append(ChartDataEntry(x: $0.x, y: $0.y, data: $0.name))
                barDataEntries.append(BarChartDataEntry(x: $0.x, y: $0.y, data: $0.name))
                dataNames.append($0.name!)
            }
        }
        sortChartData(forDataEntries: &dataEntries)
        sortChartData(forDataEntries: &barDataEntries)
        
        chartView.delegate = self
        
        var sequentialSet: LineChartDataSet; var timeSeriesSet: LineChartDataSet
        var timeSeriesScatterSet: ScatterChartDataSet; var contingencySet: ScatterChartDataSet; var habitSet: ScatterChartDataSet
        var habitBarSet: BarChartDataSet
        
        let data = CombinedChartData()
        
        
        switch perspective.type {
        case ChartType.timeSeries.rawValue:
            timeSeriesSet = LineChartDataSet(entries: dataEntries, label: perspective.yAxisName)
            chartColor = perspectiveChart.color.center
            timeSeriesSet.setColor(perspectiveChart.color.center)
            timeSeriesSet.setDrawHighlightIndicators(false)
            timeSeriesSet.drawCirclesEnabled = false
//            timeSeriesSet.mode = .horizontalBezier
            timeSeriesScatterSet = ScatterChartDataSet(entries: dataEntries, label: perspective.yAxisName + " Scatter Dots")
            timeSeriesScatterSet.setColor(perspectiveChart.color.center)
            timeSeriesScatterSet.setScatterShape(.circle)
            timeSeriesScatterSet.scatterShapeHoleColor = UIColor.white
            timeSeriesScatterSet.scatterShapeHoleRadius = 1.5
            timeSeriesScatterSet.scatterShapeSize = 7.5
            timeSeriesScatterSet.setDrawHighlightIndicators(false)
            
            data.scatterData = ScatterChartData(dataSets: [timeSeriesScatterSet])
            data.lineData = LineChartData(dataSets: [timeSeriesSet])
            chartView.xAxis.gridColor = perspectiveChart.color.gray
            chartView.rightAxis.gridColor = perspectiveChart.color.gray
        case ChartType.contingency.rawValue:
            contingencySet = ScatterChartDataSet(entries: dataEntries, label: perspective.yAxisName)
            chartColor = perspectiveChart.color.major
            contingencySet.setColor(perspectiveChart.color.gray)
            contingencySet.setScatterShape(.circle)
            contingencySet.scatterShapeHoleColor = chartColor
            contingencySet.scatterShapeHoleRadius = 4.2
            contingencySet.scatterShapeSize = 14.5
            contingencySet.setDrawHighlightIndicators(false)
            data.scatterData = ScatterChartData(dataSets: [contingencySet])
            chartView.xAxis.gridColor = perspectiveChart.color.gray
            chartView.rightAxis.gridColor = perspectiveChart.color.gray
        case ChartType.habit.rawValue:
            habitSet = ScatterChartDataSet(entries: dataEntries, label: perspective.yAxisName)
            chartColor = perspectiveChart.color.center
            habitSet.setColor(perspectiveChart.color.gray)
            habitSet.setScatterShape(.square)
            habitSet.scatterShapeHoleColor = perspectiveChart.color.center
            habitSet.scatterShapeHoleRadius = 4
            habitSet.scatterShapeSize = 13.5
            habitSet.setDrawHighlightIndicators(false)
            data.scatterData = ScatterChartData(dataSets: [habitSet])
            
            chartView.xAxis.drawGridLinesEnabled = false
            chartView.rightAxis.drawGridLinesEnabled = false
            
            habitBarSet = BarChartDataSet(entries: barDataEntries, label: perspective.yAxisName + " Bars")
            habitBarSet.setColor(perspectiveChart.color.major)
            data.barData = BarChartData(dataSets: [habitBarSet])
            data.barData.barWidth = 0.02
            chartView.xAxis.gridColor = perspectiveChart.color.gray
            chartView.rightAxis.gridColor = perspectiveChart.color.gray
        default:
            sequentialSet = LineChartDataSet(entries: dataEntries, label: perspective.yAxisName)
            chartColor = perspectiveChart.color.black
            sequentialSet.setColor(perspectiveChart.color.black)
            sequentialSet.drawCirclesEnabled = false
            sequentialSet.setDrawHighlightIndicators(false)
            data.lineData = LineChartData(dataSets: [sequentialSet])
        }
        
        data.setValueFont(.systemFont(ofSize: 7, weight: .light))
        
        let marker = BalloonMarker(color: chartColor, font: UIFont.systemFont(ofSize: 12), textColor: .white, insets: UIEdgeInsets(top: 8.0, left: 8.0, bottom: 20.0, right: 8.0))
        marker.chartSize = chartView.frame.size
        marker.chartType = ChartType(rawValue: perspectiveChart.type)
        marker.xUnitM = perspective.xAxisUnit
        marker.yUnitM = perspective.yAxisUnit
        marker.xAxisName = perspective.xAxisName
        marker.yAxisName = perspective.yAxisName
        marker.displayRoundedValue = true
        marker.cornerRadius = 7
        chartView.marker = marker
        
        combData = data
        chartView.data = data
        
        
        if chartView.data!.entryCount > 0 {
            chartView.xAxis.setLabelCount(Int(5.0), force: true)
        }
        
        if perspectiveChart.hasDate {
            if let minTimeInterval = (dataEntries.map { $0.x }).min() {
                    referenceTimeInterval = minTimeInterval
                }
            
            let customFormatter = ChartXAxisFormatter(referenceTimeInterval: referenceTimeInterval, dateFormatter: axisDateFormatter(format: "dd MMM"))
            chartView.xAxis.valueFormatter = customFormatter
        }
        
        setupChartUIProperties()
        setupAxisTitles()
    }
    
    private func sortChartData(forDataEntries: inout [ChartDataEntry]) {
        forDataEntries.sort(by: { $0.x < $1.x })
    }
    private func sortChartData(forDataEntries: inout [BarChartDataEntry]) {
        forDataEntries.sort(by: { $0.x < $1.x })
    }
    
    private func setupChartUIProperties() {
        
        chartView.backgroundColor = .white
        chartView.maxVisibleCount = 0
        chartView.legend.enabled = false
        chartView.rightAxis.enabled = true
        chartView.leftAxis.enabled = false
        chartView.xAxis.labelPosition = XAxis.LabelPosition.bottom
        chartView.setScaleEnabled(true)
        chartView.scaleXEnabled = true
        chartView.scaleYEnabled = true
        chartView.doubleTapToZoomEnabled = false
        chartView.pinchZoomEnabled = true
        chartView.xAxis.avoidFirstLastClippingEnabled = true
        chartView.xAxis.spaceMin = 2
        
        let xDataRange = chartView.data!.xMax - chartView.data!.xMin
        let xRangeOffset = xDataRange < 5 ? Double(xDataRange) + 1.0 : Double((xDataRange * 11) / 100).rounded()
        chartView.xAxis.axisMaximum = (chartView.data?.xMax ?? 0.0) + xRangeOffset
        
        
        chartView.rightAxis.removeAllLimitLines()
        let horizontalLimit = ChartLimitLine(limit: perspective.horizontalLine)
        horizontalLimit.lineColor = perspectiveChart.color.gray
        chartView.rightAxis.addLimitLine(horizontalLimit)
        
        chartView.xAxis.removeAllLimitLines()
        let verticalLimit = ChartLimitLine(limit: perspective.verticalLine)
        verticalLimit.lineColor = perspectiveChart.color.gray
        chartView.xAxis.addLimitLine(verticalLimit)
    }
}
