//
//  ViewController.swift
//  GWMarkSlider
//
//  Created by Will on 6/28/16.
//  Copyright © 2016 gewill.org. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var markSlider1: GWMarkSlider!
    var markSlider2: GWMarkSlider!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // markSlider1.minTintColor = UIColor.clearColor()
        // markSlider1.maxTintColor = UIColor.clearColor()
        markSlider1.markValues = [0.3, 0.6]

        markSlider1.addTarget(self, action: #selector(self.markSliderEditingChanged(_:)), forControlEvents: .EditingChanged)
        markSlider1.addTarget(self, action: #selector(self.markSliderEditingDidEnd(_:)), forControlEvents: .EditingDidEnd)
        markSlider1.addTarget(self, action: #selector(self.markSliderSelecteValueChanged(_:)), forControlEvents: .ValueChanged)
        // markSlider1.addTarget(self, action: #selector(ViewController.TouchDown(_:)), forControlEvents: .TouchDown)
        // markSlider1.addTarget(self, action: #selector(ViewController.TouchUpInside(_:)), forControlEvents: .TouchUpInside)

        markSlider2 = GWMarkSlider()
        markSlider2.frame = CGRect(x: 20, y: 50, width: 200, height: 25)
        markSlider2.trackHeight = 5
        markSlider2.minTintColor = UIColor.purpleColor()
        markSlider2.maxTintColor = UIColor.lightGrayColor()
        markSlider2.thumbTintColor = UIColor.redColor()
        markSlider2.markValues = [0.1, 0.3, 0.4, 0.6, 0.9]
        self.view.addSubview(markSlider2)

    }

    // MARK: - response methods

    func markSliderEditingChanged(markSlider: GWMarkSlider) {
        print("markSlider value changed: (\(markSlider.currentValue)")
    }

    func markSliderEditingDidEnd(markSlider: GWMarkSlider) {
        print("markSlider value changed end: (\(markSlider.currentValue)")
    }

    func markSliderSelecteValueChanged(markSlider: GWMarkSlider) {

        let point: CGPoint = CGPoint(x: markSlider1.frame.origin.x + markSlider.markCenters[markSlider.selectedMarkIndex].x, y: markSlider1.frame.origin.y + markSlider.markCenters[markSlider.selectedMarkIndex].y)
        let point2 = self.view.convertPoint(markSlider.markCenters[markSlider.selectedMarkIndex], fromView: markSlider)
        print("selectedMarkIndex: (\(markSlider.selectedMarkIndex) \(point) \(point2)")

    }

    func TouchDown(markSlider: GWMarkSlider) {
        print("\(NSDate()):TouchDown)")
    }

    func TouchUpInside(markSlider: GWMarkSlider) {
        print("\(NSDate()):TouchUpInside")
    }

    @IBAction func changeMarkPostionsButtonClick(sender: AnyObject) {
        markSlider1.markValues = [0.3, 0.4, 0.6, 0.1, 0.9]
    }

}

