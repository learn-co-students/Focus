//
//  WeeklyGraphView.swift
//  Gouda0916
//
//  Created by Michael Young on 11/28/16.
//  Copyright © 2016 Flatiron. All rights reserved.
//

import UIKit

class WeeklyGraphView: UIView {
    
    // Sample Data
    // Seven Days
    var graphPoints = [0, 10, 8, 2, 9, 7, 10, 9, 0]

    override func draw(_ rect: CGRect) {
        
        let width = rect.width
        let height = rect.height
        
        let context = UIGraphicsGetCurrentContext()
        
        // X Point (Days of the week)
        let margin: CGFloat = 0.0
        let columnXPoint = { (column: Int) -> CGFloat in
            // Gap between Points
            // Used Closure instead of Function
            let spacer = (width - margin * 2 - 4) / CGFloat(self.graphPoints.count - 1)
            var x: CGFloat = CGFloat(column) * spacer
            x += margin + 2
            return x
        }
        
        // Y Point (Velocity Score)
        let topBorder: CGFloat = 60
        let bottomBorder: CGFloat = 50
        let graphHeight = height - topBorder - bottomBorder
        let maxValue = self.graphPoints.max()
        let columnYPoint = { (graphPoint: Int) -> CGFloat in
            // unwrap maxValue
            var y: CGFloat = CGFloat(graphPoint) / CGFloat(maxValue!) * graphHeight
            // changes the origin point from the top-left corneer to the bottom-left corner
            y = graphHeight + topBorder - y
            return y
        }
        
        // draw line graph
        UIColor.themeAccentGoldColor.setFill()
        UIColor.themeAccentGoldColor.setStroke()
        
        // points line
        let graphPath = UIBezierPath()
        // Move to the start of the line
        graphPath.move(to: (CGPoint(x: columnXPoint(0), y: columnYPoint(graphPoints[0]))))
        
        // add points for each item in the graphPoints array at the correct x,y location
        for i in 1..<graphPoints.count {
            let nextPoint = CGPoint(x: columnXPoint(i), y: columnYPoint(graphPoints[i]))
            graphPath.addLine(to: nextPoint)
        }
        // Draw line
        graphPath.lineWidth = 1.0
        graphPath.stroke()
        
        // Save Context State to keep lines clean
        context?.saveGState()
        
        // Clip Path
        // Copy The path
        let clippingPath = graphPath.copy() as! UIBezierPath
        
        // Add Lines to copied path to complete clip area
        clippingPath.addLine(to: (CGPoint(x: columnXPoint(graphPoints.count - 1), y: height)))
        clippingPath.addLine(to: (CGPoint(x: columnXPoint(0), y: height)))
        clippingPath.close()
        
        // Add Clipping Path to context
        clippingPath.addClip()
    
        UIColor.themeAccentGoldColor.withAlphaComponent(0.2).setFill()
        let rectPath = UIBezierPath(rect: self.bounds)
        
        rectPath.fill()
        
        // Restore context State
        context?.restoreGState()
        
//        // Draw Circles on top of Stroke
//        for i in 0..<graphPoints.count {
//            var point = CGPoint(x: columnXPoint(i), y: columnYPoint(graphPoints[i]))
//            point.x -= 5.0/2
//            point.y -= 5.0/2
//            
//            let circle = UIBezierPath(ovalIn: CGRect(origin: point, size: CGSize(width: 2.0, height: 2.0)))
//            UIColor.themeAccentGoldColor.setStroke()
//            circle.stroke()
//            
//        }
        
        // Draw Horizontal lines
        let linePath = UIBezierPath()
        
        // Top Lines
        linePath.move(to: CGPoint(x: margin, y: topBorder))
        linePath.addLine(to: CGPoint(x: width - margin, y: topBorder))
        
        linePath.move(to: CGPoint(x: margin, y: graphHeight / 4 + topBorder))
        linePath.addLine(to: CGPoint(x: width - margin, y: graphHeight / 4 + topBorder))
        
        // Center Line
        linePath.move(to: CGPoint(x: margin, y: graphHeight / 2 + topBorder))
        linePath.addLine(to: CGPoint(x: width - margin, y: graphHeight / 2 + topBorder))
        
        // Bottom Line
        linePath.move(to: CGPoint(x: margin, y: graphHeight / 2 + topBorder + bottomBorder))
        linePath.addLine(to: CGPoint(x: width - margin, y: graphHeight / 2 + topBorder + bottomBorder))
        
        linePath.move(to: CGPoint(x: margin, y: height - bottomBorder))
        linePath.addLine(to: CGPoint(x: width - margin, y: height - bottomBorder))
        
        let lineColor = UIColor.themeDarkGrayColor.withAlphaComponent(0.2)
        lineColor.setStroke()
        
        linePath.lineWidth = 1
        linePath.stroke()
    }
}
















