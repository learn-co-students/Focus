//
//  WeeklyGraphView.swift
//  Gouda0916
//
//  Created by Michael Young on 11/28/16.
//  Copyright © 2016 Flatiron. All rights reserved.
//

import UIKit

class WeeklyGraphView: UIView {
    
    let store = DataStore.sharedInstance
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func draw(_ rect: CGRect) {
        
        let rectWidth = rect.width
        let rectHeight = rect.height
        let context = UIGraphicsGetCurrentContext()
        let margin: CGFloat = 20.0
        
        // X Point (Days of the week)
        let columnXPoint = { (column: Int) -> CGFloat in
            // Gap between Points
            let spacer = (rectWidth - margin * 2 - 4) / CGFloat(self.store.graphPoints.count - 1)
            var x: CGFloat = CGFloat(column) * spacer
            x += margin + 2
            return x
        }
        
        // Y Point (Velocity Score)
        let topBorder: CGFloat = 60
        let bottomBorder: CGFloat = 50
        let graphHeight = rectHeight - topBorder - bottomBorder
        let maxValue = 10
        let columnYPoint = { (graphPoint: Int) -> CGFloat in
            var y: CGFloat = CGFloat(graphPoint) / CGFloat(maxValue) * graphHeight
            // Change the origin point from the top-left corneer to the bottom-left corner
            y = graphHeight + topBorder - y
            return y
        }
        
        UIColor.themeAccentGoldColor.setFill()
        UIColor.themeAccentGoldColor.setStroke()
        
        // Points line
        let graphPath = UIBezierPath()
        // Move to the start of the line
        graphPath.move(to: (CGPoint(x: columnXPoint(0), y: columnYPoint(store.graphPoints[0]))))
        
        // Add points for each item in the graphPoints array at the correct x,y location
        for i in 1..<store.graphPoints.count {
            let nextPoint = CGPoint(x: columnXPoint(i), y: columnYPoint(store.graphPoints[i]))
            graphPath.addLine(to: nextPoint)
        }
        
        graphPath.lineWidth = 1.0
        graphPath.stroke()
        animate(graphPath: graphPath)
        
        context?.saveGState()
        clip(path: graphPath, height: rectHeight, bottomBorder: bottomBorder, columnXPoint: columnXPoint)
        context?.restoreGState()
        
        //drawCirlceOn(columnXPoint: columnXPoint, columnYPoint: columnYPoint)
        
        horizontalGraphLines(margin: margin,
                             width: rectWidth,
                             height: rectHeight,
                             graphHeight: graphHeight,
                             topBorder: topBorder,
                             bottomBorder: bottomBorder)
        
        verticalGraphLines(margin: margin,
                           width: rectWidth,
                           height: rectHeight,
                           graphHeight: graphHeight,
                           topBorder: topBorder,
                           bottomBorder: bottomBorder)
    }
    
    func animate(graphPath: UIBezierPath) {
        
        let pathLayer: CAShapeLayer = CAShapeLayer()
        
        pathLayer.frame = self.bounds
        pathLayer.path = graphPath.cgPath
        pathLayer.strokeColor = UIColor.white.cgColor
        pathLayer.fillColor = nil
        pathLayer.lineWidth = 2.0
        pathLayer.lineJoin = kCALineCapRound
        
        self.layer.addSublayer(pathLayer)
        
        let pathAnimation: CABasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        pathAnimation.duration = 1.0
        pathAnimation.fromValue = 1.0
        pathAnimation.toValue = 0.0
        
        pathLayer.add(pathAnimation, forKey: "strokeEnd")
        pathLayer.strokeEnd = 0.0
    }
    
    func clip(path: UIBezierPath, height: CGFloat, bottomBorder: CGFloat, columnXPoint: (Int) -> CGFloat) {
        
        let clippingPath = path.copy() as! UIBezierPath
        
        clippingPath.addLine(to: (CGPoint(x: columnXPoint(store.graphPoints.count - 1), y: height - bottomBorder)))
        clippingPath.addLine(to: (CGPoint(x: columnXPoint(0), y: height - bottomBorder)))
        clippingPath.close()
        clippingPath.addClip()
        
        UIColor.themeAccentGoldColor.withAlphaComponent(0.2).setFill()
        let rectPath = UIBezierPath(rect: self.bounds)
        rectPath.fill()
    }
    
    func drawCirlceOn(columnXPoint: (Int) -> CGFloat, columnYPoint: (Int) -> CGFloat) {
        
        for i in 1..<store.graphPoints.count - 1 {
            var point = CGPoint(x: columnXPoint(i), y: columnYPoint(store.graphPoints[i]))
            point.x -= 5.0/2
            point.y -= 5.0/2
            
            let circle = UIBezierPath(ovalIn: CGRect(origin: point, size: CGSize(width: 2.0, height: 2.0)))
            UIColor.themeDarkGreenColor.setStroke()
            circle.stroke()
        }
    }
    
    func horizontalGraphLines(margin: CGFloat, width: CGFloat, height: CGFloat, graphHeight: CGFloat, topBorder: CGFloat, bottomBorder: CGFloat) {
        
        let linePath = UIBezierPath()
        
        linePath.move(to: CGPoint(x: margin, y: topBorder))
        linePath.addLine(to: CGPoint(x: width - margin, y: topBorder))
        
        linePath.move(to: CGPoint(x: margin, y: graphHeight / 4 + topBorder))
        linePath.addLine(to: CGPoint(x: width - margin, y: graphHeight / 4 + topBorder))
        
        linePath.move(to: CGPoint(x: margin, y: graphHeight / 2 + topBorder))
        linePath.addLine(to: CGPoint(x: width - margin, y: graphHeight / 2 + topBorder))
        
        linePath.move(to: CGPoint(x: margin, y: (graphHeight / 2) + (graphHeight / 4) + topBorder))
        linePath.addLine(to: CGPoint(x: width - margin, y: (graphHeight / 2) + (graphHeight / 4) + topBorder))
        
        linePath.move(to: CGPoint(x: margin, y: height - bottomBorder))
        linePath.addLine(to: CGPoint(x: width - margin, y: height - bottomBorder))
        
        let lineColor = UIColor.themeDarkGrayColor.withAlphaComponent(0.2)
        lineColor.setStroke()
        
        linePath.lineWidth = 1
        linePath.stroke()
    }
    
    func verticalGraphLines(margin: CGFloat, width: CGFloat, height: CGFloat, graphHeight: CGFloat, topBorder: CGFloat, bottomBorder: CGFloat) {
        
        let linePath = UIBezierPath()
        
        linePath.move(to: CGPoint(x: (width / 8.55) + margin, y: topBorder))
        linePath.addLine(to: CGPoint(x: (width / 8.55) + margin, y: graphHeight + topBorder))
        
        linePath.move(to: CGPoint(x: (width / 4) + (margin / 2), y: topBorder))
        linePath.addLine(to: CGPoint(x: (width / 4) + (margin / 2), y: graphHeight + topBorder))
        
        linePath.move(to: CGPoint(x: (width / 3) + margin, y: topBorder))
        linePath.addLine(to: CGPoint(x: (width / 3) + margin, y: graphHeight + topBorder))
        
        // Center
        linePath.move(to: CGPoint(x: width / 2, y: topBorder))
        linePath.addLine(to: CGPoint(x: width / 2, y: graphHeight + topBorder))
        
        linePath.move(to: CGPoint(x: width - (width / 3) - margin, y: topBorder))
        linePath.addLine(to: CGPoint(x: width - (width / 3) - margin, y: graphHeight + topBorder))
        
        linePath.move(to: CGPoint(x: width - (width / 4) - (margin / 2), y: topBorder))
        linePath.addLine(to: CGPoint(x: width - (width / 4) - (margin / 2), y: graphHeight + topBorder))
        
        linePath.move(to: CGPoint(x: width - (width / 8.55) - margin, y: topBorder))
        linePath.addLine(to: CGPoint(x: width - (width / 8.55) - margin, y: graphHeight + topBorder))
        
        let lineColor = UIColor.themeDarkGrayColor.withAlphaComponent(0.2)
        lineColor.setStroke()
        
        linePath.lineWidth = 1
        linePath.stroke()
    }
}
