//
//  ViewController.swift
//  CoreGraphicsLearnSwift
//
//  Created by Denis Andreev on 8/28/16.
//  Copyright © 2016 Denis Andreev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var plusButon: GreenButton!
    @IBOutlet weak var minusButton: MinusButton!
    @IBOutlet weak var counterView: CounterView!
    @IBOutlet weak var graphView: GraphView!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    
    var isGraphShowing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        counterLabel.text = String(counterView.counter)
        maxLabel.text = String(graphView.graphPoints.max()!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pressPluss(_ sender: AnyObject) {
        if counterView.counter < 8 {
            counterView.counter += 1
        }
        counterLabel.text = String(counterView.counter)
    }
    
    @IBAction func pressMinus(_ sender: AnyObject) {
        if counterView.counter > 0 {
            counterView.counter -= 1
        }
        counterLabel.text = String(counterView.counter)
    }

    @IBAction func counterViewTup(gesture:UITapGestureRecognizer?){
        let transitionOptions: UIViewAnimationOptions = [.transitionFlipFromLeft, .showHideTransitionViews]
        if isGraphShowing {
            UIView.transition(from: graphView,
                              to: counterView,
                              duration: 1.0,
                              options: transitionOptions,
                              completion: nil)
        } else {
            UIView.transition(from: counterView,
                              to: graphView, duration: 1.0,
                              options: transitionOptions,
                              completion: nil)
        }
        isGraphShowing = !isGraphShowing
    }
    
}

