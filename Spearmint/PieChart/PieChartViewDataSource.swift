//
//  PieChartDataSource.swift
//  Spearmint
//
//  Created by Brian Ishii on 7/23/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation
import UIKit

class PieChartViewDataSource: NSObject {
    fileprivate let pieChartView: PieChartView
    var segments: [PieChartSegment] = []
    var selectedSegment: Int? {
        didSet {
            guard let selectedSegment = selectedSegment else { return }
            
            if selectedSegment >= segments.count {
                self.selectedSegment = nil
            }
            
            if selectedSegment != oldValue {
                guard let pieChart = pieChartView.pieChart else { return }
                
                pieChart.drawPieChart()
            }

        }
    }
    
    var total: Double?
    
    init(_ pieChartView: PieChartView) {
        self.pieChartView = pieChartView
        super.init()
        
        pieChartView.dataSource = self
                pieChartView.pieChart?.drawPieChart()
    }
    
    func getPieChartData() -> [(segment: PieChartSegment, percentage: Double)] {
        var data: [(segment: PieChartSegment, percentage: Double)] = []
        let total = calculateTotal()
        
        for segment in segments {
            data.append((segment: segment, percentage: segment.value / total))
        }
        
        return data
    }
    
    func selectSegment(_ index: Int) {
        selectedSegment = index
        
        guard let selectedSegment = selectedSegment else { return }
        guard let pieChart = pieChartView.pieChart else { return }

        var tranformedAngle = pieChartView.pieChartViewAngleToPieChartAngle(pieChart.ticks[selectedSegment])
        pieChartView.angle = tranformedAngle
    }
    
    func calculateTotal() -> Double {
        if let total = self.total {
            return total
        }
        
        var total = 0.0
        
        for segment in segments {
            total += segment.value
        }
        
        return total
    }

    func addSegment(_ segment: PieChartSegment) {
        self.segments.append(segment)
        guard let pieChart = pieChartView.pieChart else { return }
        
        pieChart.drawPieChart()
    }
    
    func setSegments(_ segments: [PieChartSegment]) {
        self.segments = segments
        guard let pieChart = pieChartView.pieChart else { return }
        
        pieChart.drawPieChart()
    }
    
    static var temp: [PieChartSegment] {
        return [
            PieChartSegment(text: "one", color: .red, value: 10),
            PieChartSegment(text: "two", color: .orange, value: 10),
            PieChartSegment(text: "three", color: .yellow, value: 10)
        ]
    }
}
