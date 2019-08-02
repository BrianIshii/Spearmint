//
//  PieChart.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/11/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class PieChart: UIView {
    var CApaths: [CAShapeLayer] = []
    var ticks: [(start: CGFloat, end: CGFloat)] = []
    var radius: CGFloat = 0
    var defaultLineWidth: CGFloat = 0
    var segmentLineWidth: CGFloat = 0
    var selectedSegementLineWidth: CGFloat = 0
    var dataSource: PieChartViewDataSource?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    func setUp() {
        radius = CGFloat(frame.width / 2 * 3 / 4)
        defaultLineWidth = frame.width / 75
        segmentLineWidth = frame.width / 25
        selectedSegementLineWidth = segmentLineWidth * 2
    }
    
    func drawPieChart() {
        guard let dataSource = dataSource else { return }

        ticks = []
        var start = CGFloat(0)
    
        let data = dataSource.getPieChartData()
        
        if data.last?.percentage == 1.0 {
            let _ = drawPath(radius: radius, start: 0, end: CGFloat.pi * 2, color: UIColor.lightGray, lineWidth: frame.width / 75, index: 0)
            return
        }
            
        for i in 0..<(data.count) {
            let end = CGFloat(start + CGFloat(data[i].percentage) * 2 * CGFloat.pi)
            drawPath(radius: radius, start: start, end: end, color: data[i].segment.color, lineWidth: segmentLineWidth, index: i)
        
            start = end
        }
    
        if start < (CGFloat.pi * 2) {
            drawPath(radius: radius, start: start, end: CGFloat.pi * 2, color: UIColor.lightGray, lineWidth: defaultLineWidth, index: data.count)
        }
    }
    
    func drawPath(radius: CGFloat, start: CGFloat, end: CGFloat, color: UIColor, lineWidth: CGFloat, index: Int) {
        let path = UIBezierPath()
        path.addArc(withCenter: center, radius: radius, startAngle: start, endAngle: end, clockwise: true)
        path.lineWidth = lineWidth

        var nextPathLayer: CAShapeLayer
        
        ticks.append((start, end))
        
        if index <= CApaths.count - 1 {
            nextPathLayer = CApaths[index]
        } else {
            nextPathLayer = CAShapeLayer()
        }
        nextPathLayer.path = path.cgPath
        nextPathLayer.lineWidth = lineWidth
        nextPathLayer.strokeColor = color.cgColor
        nextPathLayer.fillColor = UIColor.clear.cgColor
        
        if let dataSource = dataSource, let selectedSegment = dataSource.selectedSegment {
            if selectedSegment == index {
                nextPathLayer.lineWidth = selectedSegementLineWidth
            }
        }

        if index <= CApaths.count - 1 {
        } else {
            CApaths.append(nextPathLayer)
            self.layer.addSublayer(nextPathLayer)
        }
        
    }
}
