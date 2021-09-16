//
//  BiorhythmsTableChartCell.swift
//  Astra
//
//  Created by Andrey Chernyshev on 14.09.2021.
//

import UIKit
import SwiftCharts

final class BiorhythmsTableChartCell: UITableViewCell {
    lazy var legendView = makeLegendView()
    
    private var chart: SwiftCharts.Chart?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension BiorhythmsTableChartCell {
    func setup(element: BiorhythmsTableChartElement) {
        guard chart == nil else {
            return
        }
        
        chart = makeChart(element: element)
    }
}

// MARK: Private
private extension BiorhythmsTableChartCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
}

// MARK: Make constraints
private extension BiorhythmsTableChartCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            legendView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            legendView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            legendView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            legendView.heightAnchor.constraint(equalToConstant: 16.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension BiorhythmsTableChartCell {
    func makeChart(element: BiorhythmsTableChartElement) -> SwiftCharts.Chart {
        let xModel = makeXModel()
        let yModel = makeYModel()
        
        let chartSettings = makeSettings()
        
        let chartFrame = CGRect(x: 11.scale, y: 0, width: 353.scale, height: 212.scale)
        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
        let (xAxisLayer, yAxisLayer, innerFrame) = (coordsSpace.xAxisLayer, coordsSpace.yAxisLayer, coordsSpace.chartInnerFrame)

        let guidelinesLayerSettings = ChartGuideLinesDottedLayerSettings(linesColor: UIColor.black, linesWidth: 0.1)
        let guidelinesLayer = ChartGuideLinesDottedLayer(xAxisLayer: xAxisLayer, yAxisLayer: yAxisLayer, settings: guidelinesLayerSettings)
        
        let lines =  makeLines(element: element,
                               xAxis: xAxisLayer,
                               yAxis: yAxisLayer)
        
        let layers: [ChartLayer] = [xAxisLayer, yAxisLayer, guidelinesLayer] + lines
        
        let chart = SwiftCharts.Chart(
            frame: chartFrame,
            innerFrame: innerFrame,
            settings: chartSettings,
            layers: layers)

        contentView.addSubview(chart.view)
        
        return chart
    }
    
    func makeXModel() -> ChartAxisModel {
        let labelSettings = ChartLabelSettings(font: Fonts.Qanelas.regular(size: 13.scale),
                                               fontColor: UIColor(integralRed: 63, green: 63, blue: 63, alpha: 0.5))
        let todaySettings = ChartLabelSettings(font: Fonts.Qanelas.bold(size: 13.scale),
                                               fontColor: UIColor(integralRed: 63, green: 63, blue: 63))
        
        let dates = [
            Calendar.current.date(byAdding: .day, value: -2, to: Date()),
            Calendar.current.date(byAdding: .day, value: -1, to: Date()),
            Date(),
            Calendar.current.date(byAdding: .day, value: 1, to: Date()),
            Calendar.current.date(byAdding: .day, value: 2, to: Date()),
        ].compactMap { $0 }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd"

        let generator = ChartAxisGeneratorMultiplier(1)
        
        let labelsGenerator = ChartAxisLabelsGeneratorFunc { scalar -> ChartAxisLabel in
            let index = Int(scalar)
            
            guard dates.indices.contains(index) else {
                return ChartAxisLabel(text: "", settings: labelSettings)
            }
            
            let date = dates[index]
            
            let isToday = Calendar.current.isDateInToday(date)
            
            let text = isToday ? "Biorhythms.Today".localized : formatter.string(from: date)
            let settings = isToday ? todaySettings : labelSettings
            
            return ChartAxisLabel(text: text, settings: settings)
        }
        
        return ChartAxisModel(lineColor: UIColor.clear,
                              firstModelValue: 0,
                              lastModelValue: 4,
                              axisTitleLabels: [],
                              axisValuesGenerator: generator,
                              labelsGenerator: labelsGenerator,
                              leadingPadding: .label,
                              trailingPadding: .label)
    }
    
    func makeYModel() -> ChartAxisModel {
        let labelSettings = ChartLabelSettings(font: Fonts.Qanelas.regular(size: 13.scale),
                                               fontColor: UIColor(integralRed: 63, green: 63, blue: 63, alpha: 0.5))

        let generator = ChartAxisGeneratorMultiplier(50)
        
        let labelsGenerator = ChartAxisLabelsGeneratorFunc { scalar -> ChartAxisLabel in
            let text = String(format: "Biorhythms.Percent2".localized, Int(scalar))
            return ChartAxisLabel(text: text, settings: labelSettings)
        }
        
        return ChartAxisModel(lineColor: UIColor.clear,
                              firstModelValue: -100,
                              lastModelValue: 100,
                              axisTitleLabels: [],
                              axisValuesGenerator: generator,
                              labelsGenerator: labelsGenerator,
                              leadingPadding: .label,
                              trailingPadding: .label)
    }
    
    func makeSettings() -> ChartSettings {
        var chartSettings = ChartSettings()
        chartSettings.leading = 11.scale
        chartSettings.top = 0
        chartSettings.trailing = 11.scale
        chartSettings.bottom = 0
        chartSettings.labelsSpacing = 0
        chartSettings.labelsToAxisSpacingX = 16.scale
        chartSettings.labelsToAxisSpacingY = 13.scale
        chartSettings.spacingBetweenAxesX = 0
        chartSettings.spacingBetweenAxesY = 0
        chartSettings.axisTitleLabelsToLabelsSpacing = 0
        chartSettings.axisStrokeWidth = 0
        chartSettings.zoomPan.panEnabled = false
        chartSettings.zoomPan.zoomEnabled = false
        return chartSettings
    }
    
    func makeLines(element: BiorhythmsTableChartElement, xAxis: ChartAxisLayer, yAxis: ChartAxisLayer) -> [ChartLayer] {
        let physicalPoints = element.physical.prefix(5).enumerated().map { index, value -> ((Double, Double)) in
            (Double(index), value)
        }
        let emotionalPoints = element.emotional.prefix(5).enumerated().map { index, value -> ((Double, Double)) in
            (Double(index), value)
        }
        let intellectualPoints = element.intellectual.prefix(5).enumerated().map { index, value -> ((Double, Double)) in
            (Double(index), value)
        }
        
        let lines: [LineChart.ChartLine] = [
            (chartPoints: physicalPoints, color: UIColor(integralRed: 121, green: 155, blue: 202)),
            (chartPoints: emotionalPoints, color: UIColor(integralRed: 234, green: 140, blue: 140)),
            (chartPoints: intellectualPoints, color: UIColor(integralRed: 253, green: 240, blue: 173))
        ]
        
        return lines.map { line in
            let chartPoints = line.chartPoints.map { chartPointScalar in
                ChartPoint(x: ChartAxisValueDouble(chartPointScalar.0), y: ChartAxisValueDouble(chartPointScalar.1))
            }
            
            let lineModel = ChartLineModel(chartPoints: chartPoints,
                                           lineColors: [line.color],
                                           lineWidth: 3.scale,
                                           lineJoin: .round,
                                           lineCap: .square,
                                           animDuration: 0.5, animDelay: 0)
            return ChartPointsLineLayer(xAxis: xAxis.axis, yAxis: yAxis.axis, lineModels: [lineModel])
        }
    }
    
    func makeLegendView() -> BiorhythmsChartLegendView {
        let view = BiorhythmsChartLegendView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
