//
//  MinusButton.swift
//  CoreGraphicsLearnSwift
//
//  Created by Denis Andreev on 8/28/16.
//  Copyright © 2016 Denis Andreev. All rights reserved.
//

import UIKit

@IBDesignable class MinusButton: UIButton {

    override func draw(_ rect: CGRect) {
        var path = UIBezierPath(ovalIn: rect)
        UIColor.red.setFill()
        path.fill()
        
        let plusHeight: CGFloat = 3.0
        let plusWidth: CGFloat = min(bounds.width, bounds.height) * 0.6
        
        var plusPath = UIBezierPath()
        plusPath.lineWidth = plusHeight
        
        
        plusPath.move(to: CGPoint(x: bounds.width/2 - plusWidth/2 + 0.5,
                                  y: bounds.height/2 + 0.5))
        plusPath.addLine(to: CGPoint(x: bounds.width/2 + plusWidth/2 + 0.5,
                                     y:bounds.height/2 + 0.5))

        UIColor.white.setStroke()
        plusPath.stroke()
        
    }

    
    
}
