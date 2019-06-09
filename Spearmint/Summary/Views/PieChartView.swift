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
        removePath()
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
        let _ = drawPath(center: center, radius: radius, start: 0, end: CGFloat.pi * 2, color: UIColor.lightGray, lineWidth: frame.width / 75)
        return
        }
    
        for i in 0..<(segments.count - 1) {
            let end = CGFloat(start + CGFloat(segments[i]) * 2 * CGFloat.pi)
            let path = drawPath(center: center, radius: radius, start: start, end: end, color: strokeColors[i], lineWidth: frame.width / 25)
        
            start = end
            paths.append(path)
        }
    
        let restPath = drawPath(center: center, radius: radius, start: start, end: CGFloat.pi * 3 / 2, color: UIColor.lightGray, lineWidth: frame.width / 75)
    
        paths.append(restPath)
    }
    
    func removePath() {
        for path in paths {
            path.removeAllPoints()
        }
        paths.removeAll()
    }
    
    func drawPath(center: CGPoint, radius: CGFloat, start: CGFloat, end: CGFloat, color: UIColor, lineWidth: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        color.setStroke()
        path.addArc(withCenter: center, radius: radius, startAngle: start, endAngle: end, clockwise: true)
        
        path.lineWidth = lineWidth
        path.stroke()
        
        return path
    }
}
