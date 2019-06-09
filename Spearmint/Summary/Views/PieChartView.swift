//
//  PieChartView.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/11/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import UIKit

class PieChartView: UIView {

    var segments: [Float]
    var paths: [UIBezierPath] = []
    var CApaths: [CAShapeLayer] = []
    var selectedIndex: Int?

    init(frame: CGRect, segments: [Float]) {
        self.segments = segments
        self.paths = []
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.segments = []
        self.paths = []
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        print("draw called")
        drawPieChart()
    }
    
    func drawPieChart() {
        let center = CGPoint(x: frame.width / 2, y: frame.height / 2)
        let radius = CGFloat(frame.width / 2 * 3 / 4)
        let strokeColors = [UIColor.red, UIColor.orange, UIColor.yellow, UIColor.green, UIColor.blue,
        UIColor.purple, UIColor.magenta, UIColor.cyan, UIColor.black, UIColor.brown,
        UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 1), UIColor.init(red: 0.5, green: 0.25, blue: 0.5, alpha: 1)]
        
        var start = CGFloat.pi * 3 / 2
    
        if segments.count == 0 {
            let _ = drawPath(center: center, radius: radius, start: 0, end: CGFloat.pi * 2, color: UIColor.lightGray, lineWidth: frame.width / 75, index: 0)
        return
        }
    
        for i in 0..<(segments.count - 1) {
            let end = CGFloat(start + CGFloat(segments[i]) * 2 * CGFloat.pi)
            let path = drawPath(center: center, radius: radius, start: start, end: end, color: strokeColors[i], lineWidth: frame.width / 25, index: i)
        
            start = end
            paths.append(path)
        }
    
        let restPath = drawPath(center: center, radius: radius, start: start, end: CGFloat.pi * 3 / 2, color: UIColor.lightGray, lineWidth: frame.width / 75, index: segments.count - 1)
    
        paths.append(restPath)
    }
    
    func updatePath(_ index: Int) {
        selectedIndex = index
        self.setNeedsDisplay()
    }
    
    func drawPath(center: CGPoint, radius: CGFloat, start: CGFloat, end: CGFloat, color: UIColor, lineWidth: CGFloat, index: Int) -> UIBezierPath {
        let path = UIBezierPath()
        color.setStroke()
        path.addArc(withCenter: center, radius: radius, startAngle: start, endAngle: end, clockwise: true)
        
        path.lineWidth = lineWidth
        //path.stroke()
        var nextPathLayer: CAShapeLayer
        
        if index < CApaths.count - 1 {
            nextPathLayer = CApaths[index]
        } else {
            nextPathLayer = CAShapeLayer()
        }
        nextPathLayer.path = path.cgPath
        nextPathLayer.lineWidth = lineWidth
        nextPathLayer.strokeColor = color.cgColor
        nextPathLayer.fillColor = UIColor.clear.cgColor
        
        if let selected = selectedIndex {
            if selected == index {
                print("changed width")
                nextPathLayer.lineWidth = lineWidth * 2
            }
        }
        if index < CApaths.count - 1 {
        } else {
            CApaths.append(nextPathLayer)
            self.layer.addSublayer(CApaths[CApaths.count - 1])
        }

        return path
    }
    
    private var lineWidth: CGFloat {
        return frame.width / 75
    }
}
