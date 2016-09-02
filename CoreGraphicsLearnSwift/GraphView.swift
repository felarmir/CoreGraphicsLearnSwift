//
//  GraphView.swift
//  CoreGraphicsLearnSwift
//
//  Created by Denis Andreev on 8/31/16.
//  Copyright © 2016 Denis Andreev. All rights reserved.
//

import UIKit

@IBDesignable class GraphView: UIView {

    var graphPoints:[Int] = [1, 8, 5, 9, 2, 3, 6, 4, 9, 2, 4]
    
    @IBInspectable var startColor: UIColor = UIColor.red
    @IBInspectable var endColor: UIColor = UIColor.green
    
    override func draw(_ rect: CGRect) {
        var path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: UIRectCorner.allCorners,
                                cornerRadii: CGSize(width: 8.0, height: 8.0))
        path.addClip()
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        let colors = [startColor.cgColor, endColor.cgColor] as CFArray
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colorLocation:[CGFloat] = [0.0, 1.0]
        
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: colorLocation)

        var startPoint = CGPoint.zero
        var endPoint = CGPoint(x:0, y:self.bounds.height)
        
        context.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(rawValue: UInt32(0)))

        
        let width = bounds.width
        let height = bounds.height
        
        let margin:CGFloat = 20.0
        var columnXPoint = {
            (column:Int) -> CGFloat in
            let spacer = (width - margin*2 - 4) / CGFloat((self.graphPoints.count - 1))
            var x:CGFloat = CGFloat(column) * spacer
            x += margin + 2
            return x
        }
        
        let topBorder:CGFloat = 60
        let bottomBorder:CGFloat = 50
        let graphHeight = height - topBorder - bottomBorder
        let maxValue = graphPoints.max()
        var cloumnYPoint = {
            (graphPoint:Int) -> CGFloat in
            var y:CGFloat = CGFloat(graphPoint) / CGFloat(maxValue!) * graphHeight
            y = graphHeight + topBorder - y
            return y
        }
        
        
        UIColor.white.setFill()
        UIColor.white.setStroke()
        
        var graphPath = UIBezierPath()
        graphPath.move(to: CGPoint(x: columnXPoint(0), y: cloumnYPoint(graphPoints[0])))
        for i in 1..<graphPoints.count {
            let nextPoint = CGPoint(x: columnXPoint(i), y: cloumnYPoint(graphPoints[i]))
            graphPath.addLine(to: nextPoint)
        }
        graphPath.stroke()
        context.saveGState()
        
        var clippingPath = graphPath.copy() as! UIBezierPath
        clippingPath.addLine(to: CGPoint(x: columnXPoint(graphPoints.count - 1 ),
                                         y: height))
        clippingPath.addLine(to: CGPoint(x: columnXPoint(0),
                                         y: height))
        clippingPath.close()
        clippingPath.addClip()
        
        //
        //  gradient
        //
        let highestYPoint = cloumnYPoint(maxValue!)
        startPoint = CGPoint(x: margin, y: highestYPoint)
        endPoint = CGPoint(x:margin, y:self.bounds.height)
        
        context.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: .drawsAfterEndLocation)
        
        context.restoreGState()
        
        graphPath.lineWidth = 2.0
        graphPath.stroke()
        //========
        for i in 0..<graphPoints.count {
            var point = CGPoint(x:columnXPoint(i), y:cloumnYPoint(graphPoints[i]))
            point.x -= 5.0/2
            point.y -= 5.0/2
            
            let circle = UIBezierPath(ovalIn:
                CGRect(origin: point, size: CGSize(width: 5.0, height: 5.0)))
            circle.fill()
        }
        
        var linePath = UIBezierPath()
        
        linePath.move(to: CGPoint(x: margin, y: topBorder))
        linePath.addLine(to: CGPoint(x: width-margin, y: topBorder))
        
        
        linePath.move(to: CGPoint(x: margin, y: graphHeight/2 + topBorder))
        linePath.addLine(to: CGPoint(x: width-margin, y: graphHeight/2 + topBorder))
        
        linePath.move(to: CGPoint(x: margin, y: height - bottomBorder))
        linePath.addLine(to: CGPoint(x: width-margin, y: height - bottomBorder))
        
        let color = UIColor(white: 1.0, alpha: 0.3)
        color.setStroke()
        
        linePath.lineWidth = 1.0
        linePath.stroke()
        
    }
    

}
