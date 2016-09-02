//
//  CounterView.swift
//  CoreGraphicsLearnSwift
//
//  Created by Denis Andreev on 8/30/16.
//  Copyright © 2016 Denis Andreev. All rights reserved.
//

import UIKit

let NoOfGlasses = 8
let p: CGFloat = CGFloat(M_PI)

@IBDesignable class CounterView: UIView {

    @IBInspectable var counter: Int = 0 {
        didSet {
            if counter <= NoOfGlasses {
                setNeedsDisplay()
            }
        }
    }
    
    @IBInspectable var outlineColor: UIColor = UIColor.blue
    @IBInspectable var counterColor: UIColor = UIColor.orange
    
    override func draw(_ rect: CGRect) {
        
        let center = CGPoint(x: bounds.width/2, y: bounds.height/2)
        let radius: CGFloat = max(bounds.width, bounds.height)
        
        let arcWidth: CGFloat = 76
        
        let startAngle: CGFloat = 3 * p / 4
        let endAngle: CGFloat = p / 4
        
        var path = UIBezierPath(arcCenter: center,
                                radius: radius/2 - arcWidth/2,
                                startAngle: startAngle,
                                endAngle: endAngle,
                                clockwise: true)
        
        path.lineWidth = arcWidth
        counterColor.setStroke()
        path.stroke()
        
        
        let angleDifference: CGFloat = 2*p - startAngle + endAngle
        let arcLengPerGlass = angleDifference / CGFloat(NoOfGlasses)
        let outlineEndAngle = arcLengPerGlass * CGFloat(counter) + startAngle
        
        var outPath = UIBezierPath(arcCenter: center,
                                   radius: bounds.width/2 - 2.5,
                                   startAngle: startAngle,
                                   endAngle: outlineEndAngle, clockwise: true)
        
        outPath.addArc(withCenter: center,
                       radius: bounds.width/2 - arcWidth + 2.5,
                       startAngle: outlineEndAngle,
                       endAngle: startAngle,
                       clockwise: false)
        
        outPath.close()
        outPath.lineWidth = 5.0
        outlineColor.setStroke()
        outPath.stroke()
        
        
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        
        outlineColor.setFill()
        
        let markerWidth:CGFloat = 5.0
        let markerSize:CGFloat = 10.0
        
        var markerPath = UIBezierPath(rect:
            CGRect(x: -markerWidth/2,
                   y: 0,
                   width: markerWidth,
                   height: markerSize))
        
        
        context?.translateBy(x: rect.width/2, y: rect.height/2)
        
        for i in 1...NoOfGlasses {
            context?.saveGState()
            var angle = arcLengPerGlass * CGFloat(i) + startAngle - p/2
            context?.rotate(by: angle)
            context?.translateBy(x: 0, y: rect.height/2 - markerSize)
            markerPath.fill()
            context?.restoreGState()
        }
        context?.restoreGState()
        
        
    }
    
    
}
