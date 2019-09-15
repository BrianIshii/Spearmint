//
//  PieChartView.swift
//  Spearmint
//
//  Created by Brian Ishii on 7/23/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class PieChartView: UIView {
    var pieChart: PieChart!
    var title: UILabel!
    var subTitle: UILabel!
    var dataSource: PieChartViewDataSource? {
        didSet {
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
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    func setUp() {
        self.pieChart = PieChart(frame: frame)
        self.pieChart.transform = CGAffineTransform(rotationAngle: angle)
        self.addSubview(pieChart)
        
        title = UILabel()
        title.textAlignment = .center
        title.text = "Title"
        title.translatesAutoresizingMaskIntoConstraints = false
        
        
        subTitle = UILabel()
        subTitle.textAlignment = .center
        subTitle.text = "sub title"
        subTitle.translatesAutoresizingMaskIntoConstraints = false

        setConstraints()
    }
    
    func setConstraints() {
        let centerView = UIView(frame: frame)
        centerView.center = self.center
        centerView.translatesAutoresizingMaskIntoConstraints = false

        centerView.addSubview(title)
        centerView.addSubview(subTitle)
        
        centerView.addConstraints([
            NSLayoutConstraint(item: title!, attribute: .centerX, relatedBy: .equal, toItem: centerView, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: title!, attribute: .top, relatedBy: .equal, toItem: centerView, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: subTitle!, attribute: .centerX, relatedBy: .equal, toItem: centerView, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: subTitle!, attribute: .top, relatedBy: .equal, toItem: title!, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: subTitle!, attribute: .bottom, relatedBy: .equal, toItem: centerView, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: title!, attribute: .height, relatedBy: .equal, toItem: subTitle!, attribute: .height, multiplier: 1, constant: 0),
            ])
        self.addSubview(centerView)
        
        self.addConstraints([
            NSLayoutConstraint(item: centerView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: centerView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: centerView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 200),
            NSLayoutConstraint(item: centerView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100),
            ])
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
                //print("\(tranformedAngle) \(angle)")
                var index = 0
                for (i, tick) in pieChart.ticks.enumerated() {
                    if tranformedAngle.isBetween(tick.start, tick.end) {
                        index = i
                        break
                    }
                }
                
                if let dataSource = dataSource {
                    if dataSource.selectedSegment != index {
                        dataSource.selectedSegment = index
                        
                        if index < dataSource.segments.count {
                            title.text = dataSource.segments[index].text
                            subTitle.text = CurrencyOld.currencyFormatter(Float(dataSource.segments[index].value))

                        }
                    }
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
            for (i, tick) in pieChart.ticks.enumerated() {
                if tranformedAngle.isBetween(tick.start, tick.end) {
                    let centerOfSegment = tick.start + (tick.end - tick.start) / 2
                    actualDelta = min(centerOfSegment - tranformedAngle, centerOfSegment + tranformedAngle)
                    index = i
                    break
                }
            }
            //print("\(tranformedAngle) \(index) \(pieChart.ticks[index]) \(difference)")
//
//            angle = pieChart.ticks[0] - pieChart.ticks[index]
            angle -= actualDelta
            if let dataSource = dataSource {
                dataSource.selectedSegment = index
                
                if index < dataSource.segments.count {
                    title.text = dataSource.segments[index].text
                    subTitle.text = CurrencyOld.currencyFormatter(Float(dataSource.segments[index].value))
                }
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
        
        while tranformedAngle > CGFloat(2 * CGFloat.pi) {
            tranformedAngle = tranformedAngle.truncatingRemainder(dividingBy: CGFloat(2 * CGFloat.pi))
        }
        
        while tranformedAngle < CGFloat(0) {
            tranformedAngle = tranformedAngle + CGFloat(2 * CGFloat.pi)
        }
        
        return tranformedAngle
    }
}
