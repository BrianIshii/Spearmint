//
//  PieChartDataSource.swift
//  Spearmint
//
//  Created by Brian Ishii on 7/23/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

class PieChartDataSource: NSObject {
    fileprivate let pieChart: PieChart
    var segments: [PieChartSegment] = PieChartDataSource.temp
    var selectedSegment: Int? {
        didSet {
            guard let selectedSegment = selectedSegment else { return }
            
            if selectedSegment >= segments.count {
                self.selectedSegment = nil
            }
            pieChart.drawPieChart()
        }
    }
    var total: Double? = 100
    
    init(_ pieChart: PieChart) {
        self.pieChart = pieChart
        super.init()
        
        pieChart.dataSource = self
        pieChart.drawPieChart()
    }
    
    func getPieChartData() -> [(segment: PieChartSegment, percentage: Double)] {
        var data: [(segment: PieChartSegment, percentage: Double)] = []
        let total = calculateTotal()
        
        for segment in segments {
            data.append((segment: segment, percentage: segment.value / total))
        }
        
        return data
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
    
    static var temp: [PieChartSegment] {
        return [
            PieChartSegment(text: "one", color: .red, value: 10),
            PieChartSegment(text: "two", color: .orange, value: 10),
            PieChartSegment(text: "three", color: .yellow, value: 10)
        ]
    }
}
