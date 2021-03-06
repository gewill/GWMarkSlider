//
//  GWMarkImageView.swift
//  GWMarkSlider
//
//  Created by Will on 2/6/17.
//  Copyright © 2017 gewill.org. All rights reserved.
//

import UIKit

@IBDesignable
class GWMarkImageView: UIView {


    @IBInspectable var image: UIImage? {
        didSet {
            imageView?.image = image
        }
    }

    @IBInspectable var isHighlighted: Bool = false {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    var markValue: Double = 0.0

    private var imageView: UIImageView!


    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }

    private func setupViews() {

        self.backgroundColor = UIColor.clear

        imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        self.insertSubview(imageView, at: 0)
    }




    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {

        isHighlighted ? GWStyleKit.drawBubbleHighlightImageView(frame: self.bounds) : GWStyleKit.drawBubbleImageView(frame: self.bounds)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

//        imageView?.frame = CGRect(x: self.bounds.width * 1 / 38.0, y: self.bounds.width * 1 / 38.0, width: self.bounds.width * 36 / 38.0, height: self.bounds.width * 36 / 38.0)
        imageView.frame = CGRect(x: self.bounds.width * 0.5 / 38.0, y: self.bounds.width * 0.5 / 38.0, width: self.bounds.width * 37 / 38.0, height: self.bounds.width * 37 / 38.0)
        imageView.layer.cornerRadius = bounds.width / 2.0
    }


}
