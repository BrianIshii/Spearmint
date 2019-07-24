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
    var angle: CGFloat = 0 {
        didSet {
            if angle > CGFloat(2 * CGFloat.pi) {
                self.angle = angle.truncatingRemainder(dividingBy: CGFloat(2 * CGFloat.pi))
            } else if angle < CGFloat(0) {
                self.angle = angle + CGFloat(2 * CGFloat.pi)
            }
            guard let pieChart = pieChart else { return }
            pieChart.transform = CGAffineTransform(rotationAngle: angle)
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
        self.addSubview(pieChart)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let touch = touch {
            let beginPoint = touch.location(in: self)
            print("x: \(beginPoint.x),y: \(beginPoint.y)")
            previousTouch = beginPoint
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let touch = touch {
            let beginPoint = touch.location(in: self)
            print("x: \(beginPoint.x),y: \(beginPoint.y)")
            
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
                print(angle)
                self.previousTouch = beginPoint
            }
            

        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let touch = touch {
            let beginPoint = touch.location(in: self)
            print("x: \(beginPoint.x),y: \(beginPoint.y)")
            
            guard let pieChart = pieChart else { return }
            
            var index = 0
            var difference = CGFloat(CGFloat.pi * 2)
            for (i, tick) in pieChart.ticks.enumerated() {
                var delta = tick - angle
                if delta < difference {
                    if delta < 0 {
                        delta *= -1
                    }
                    difference = delta
                    index = i
                }
            }
            print(index)
            
            angle = pieChart.ticks[0] - pieChart.ticks[index]
        }
        previousTouch = nil
    }
}
