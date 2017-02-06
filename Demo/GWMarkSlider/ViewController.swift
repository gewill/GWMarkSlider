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
    var slider: UISlider!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // markSlider1.minTintColor = UIColor.clearColor()
        // markSlider1.maxTintColor = UIColor.clearColor()
        markSlider1.markValues = [0.3, 0.33]
        markSlider1.markImages = [UIImage(named: "bg")!, UIImage(named: "bg2")!]


        markSlider1.addTarget(self, action: #selector(self.markSliderMarkTouchDown(_:)), for: .editingChanged)
        markSlider1.addTarget(self, action: #selector(self.markSliderValueChanged(_:)), for: .valueChanged)
        
        markSlider1.addTarget(self, action: #selector(self.markSliderTouchDown(_:)), for: .touchDown)
        markSlider1.addTarget(self, action: #selector(self.markSliderTouchUpInside(_:)), for: .touchUpInside)

        markSlider2 = GWMarkSlider()
        markSlider2.frame = CGRect(x: 20, y: 50, width: 200, height: 25)
        markSlider2.trackHeight = 5
        markSlider2.minTintColor = UIColor.purple
        markSlider2.maxTintColor = UIColor.lightGray
        markSlider2.thumbTintColor = UIColor.red
        markSlider2.markValues = [0.1, 0.3, 0.4, 0.6, 0.9]
        self.view.addSubview(markSlider2)



    }

    // MARK: - response methods

    func markSliderMarkTouchDown(_ markSlider: GWMarkSlider) {
        print("\(#function): \(markSlider.selectedMarkIndex)")
    }

    func markSliderValueChanged(_ markSlider: GWMarkSlider) {
        print("\(#function) : \(markSlider.currentValue)")
    }

    func markSliderTouchDown(_ markSlider: GWMarkSlider) {
        print("\(#function) : ↓\(markSlider.currentValue)")
    }

    func markSliderTouchUpInside(_ markSlider: GWMarkSlider) {
        print("\(#function) : ↑\(markSlider.currentValue)")
    }

    @IBAction func changeMarkPostionsButtonClick(_ sender: AnyObject) {
        markSlider1.markValues = [0.3, 0.4, 0.6, 0.1, 0.9]
    }

    // UISlider response methods
    @IBAction func sliderTouchDown(_ sender: UISlider) {
        print("\(#function) : ↓\(sender.value)")
    }

    @IBAction func sliderTouchUpInside(_ sender: UISlider) {
        print("\(#function) : ↑\(sender.value)")
    }

    @IBAction func sliderValueChanged(_ sender: UISlider) {
        print("\(#function): \(sender.value)")
    }

}

