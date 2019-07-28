//
//  PieChartView.swift
//  Spearmint
//
//  Created by Brian Ishii on 7/23/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class PieChartView: UIView {
    var pieChart: PieChart?
    var dataSource: PieChartViewDataSource? {
        didSet {
            guard let pieChart = pieChart else { return }
            
            pieChart.dataSource = dataSource
        }
    }
    
    var angle: CGFloat = CGFloat.pi * 3 / 2 {
        didSet {
            if angle > CGFloat(2 * CGFloat.pi) {
                self.angle = angle.truncatingRemainder(dividingBy: CGFloat(2 * CGFloat.pi))
            } else if angle < CGFloat(0) {
                self.angle = angle + CGFloat(2 * CGFloat.pi)
            }
            guard let pieChart = pieChart else { return }
            UIView.animate(withDuration: 0.1, animations: {
                pieChart.transform = CGAffineTransform(rotationAngle: self.angle)})
            
        }
    }
    var previousTouch: CGPoint?
    
    override init(frame: CGRect) {
        self.pieChart = PieChart(frame: frame)
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.pieChart = PieChart(frame: frame)
        setUp()
    }
    
    func setUp() {
        guard let pieChart = pieChart else { return }
        pieChart.transform = CGAffineTransform(rotationAngle: angle)
        self.addSubview(pieChart)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let touch = touch {
            let beginPoint = touch.location(in: self)
            //print("x: \(beginPoint.x),y: \(beginPoint.y)")
            previousTouch = beginPoint
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let touch = touch {
            let beginPoint = touch.location(in: self)
            //print("x: \(beginPoint.x),y: \(beginPoint.y)")
            
            guard let previousTouch = previousTouch else { return }
            
            if previousTouch != beginPoint {
                let previousVector = CGVector(dx: previousTouch.x - center.x, dy: previousTouch.y - center.y)
                let nextVector = CGVector(dx: beginPoint.x - center.x, dy: beginPoint.y - center.y)
                let delta = acos(previousVector.dotProduct(nextVector) / (previousVector.magnitude * nextVector.magnitude))
                if previousVector.crossProduct(nextVector) > 0 {
                    angle += delta
                } else {
                    angle -= delta
                }
                //print(angle)
                self.previousTouch = beginPoint
                
                
                guard let pieChart = pieChart else { return }

                let tranformedAngle = pieChartViewAngleToPieChartAngle(angle)
                
                var index = 0
                var difference = CGFloat(CGFloat.pi * 2)
                for (i, tick) in pieChart.ticks.enumerated() {
                    var delta = tick - tranformedAngle
                    if delta < difference {
                        index = i
                    }
                }
                if let dataSource = dataSource {
                    dataSource.selectedSegment = index
                }
            }
            

        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let touch = touch {
            let beginPoint = touch.location(in: self)
            print("x: \(beginPoint.x),y: \(beginPoint.y)")
            print(angle)
            guard let pieChart = pieChart else { return }
            
            let tranformedAngle = pieChartViewAngleToPieChartAngle(angle)
            
            var index = 0
            var actualDelta = CGFloat(0)
            var difference = CGFloat(CGFloat.pi * 2)
            for (i, tick) in pieChart.ticks.enumerated() {
                //var radius = CGFloat(frame.width / 2 * 3 / 4)
                //var sectionVector = CGVector(dx: center.x, dy: <#T##CGFloat#>)
                var delta = tick - tranformedAngle
                if delta < difference {
                    actualDelta = delta
                    if delta < 0 {
                        delta *= -1
                    }
                    difference = delta
                    index = i
                }
            }
            print("\(tranformedAngle) \(index) \(pieChart.ticks[index]) \(difference)")
//
//            angle = pieChart.ticks[0] - pieChart.ticks[index]
            angle -= actualDelta
            if let dataSource = dataSource {
                dataSource.selectedSegment = index
            }

        }
        previousTouch = nil
    }
    
//    func pieChartAngleToPieChartViewAngle(_ angle: CGFloat) -> CGFloat {
//        var tranformedAngle = -(angle + CGFloat.pi / 2)
//        if tranformedAngle > CGFloat(2 * CGFloat.pi) {
//            tranformedAngle = tranformedAngle.truncatingRemainder(dividingBy: CGFloat(2 * CGFloat.pi))
//        } else if tranformedAngle < CGFloat(0) {
//            tranformedAngle = tranformedAngle + CGFloat(2 * CGFloat.pi)
//        }
//
//        return tranformedAngle
//    }
    
    func pieChartViewAngleToPieChartAngle(_ angle: CGFloat) -> CGFloat {
        var tranformedAngle = -(angle + CGFloat.pi / 2)
        if tranformedAngle > CGFloat(2 * CGFloat.pi) {
            tranformedAngle = tranformedAngle.truncatingRemainder(dividingBy: CGFloat(2 * CGFloat.pi))
        } else if tranformedAngle < CGFloat(0) {
            tranformedAngle = tranformedAngle + CGFloat(2 * CGFloat.pi)
        }
        
        return tranformedAngle
    }
}
