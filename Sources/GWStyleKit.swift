//
//  GWStyleKit.swift
//  GWMarkSlider
//
//  Created by Will on 2/6/17.
//  Copyright © 2017 gewill.org. All rights reserved.
//



import UIKit

public class GWStyleKit : NSObject {

    //// Cache

    private struct Cache {
        static let theShadowColor: UIColor = UIColor(red: 0.600, green: 0.600, blue: 0.600, alpha: 1.000)
        static let theBorderColor: UIColor = UIColor(red: 0.976, green: 0.659, blue: 0.043, alpha: 1.000)
        static let littleShadow: NSShadow = NSShadow(color: GWStyleKit.theShadowColor, offset: CGSize(width: 0, height: 0.5), blurRadius: 6)
    }

    //// Colors

    public dynamic class var theShadowColor: UIColor { return Cache.theShadowColor }
    public dynamic class var theBorderColor: UIColor { return Cache.theBorderColor }

    //// Shadows

    public dynamic class var littleShadow: NSShadow { return Cache.littleShadow }

    //// Drawing Methods

    public dynamic class func drawBubbleHighlightImageView(frame: CGRect = CGRect(x: 0, y: 56, width: 38, height: 44)) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!

        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: frame.minX + 0.98684 * frame.width, y: frame.minY + 0.43182 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.58817 * frame.width, y: frame.minY + 0.84540 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.98684 * frame.width, y: frame.minY + 0.63803 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.81495 * frame.width, y: frame.minY + 0.80957 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.50000 * frame.width, y: frame.minY + 0.97727 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.55993 * frame.width, y: frame.minY + 0.88762 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.50000 * frame.width, y: frame.minY + 0.97727 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.41183 * frame.width, y: frame.minY + 0.84539 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.50000 * frame.width, y: frame.minY + 0.97727 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.44007 * frame.width, y: frame.minY + 0.88762 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.01316 * frame.width, y: frame.minY + 0.43182 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.18505 * frame.width, y: frame.minY + 0.80957 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.01316 * frame.width, y: frame.minY + 0.63803 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.20987 * frame.width, y: frame.minY + 0.09415 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.01316 * frame.width, y: frame.minY + 0.29350 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.09050 * frame.width, y: frame.minY + 0.17078 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.50000 * frame.width, y: frame.minY + 0.01136 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.29089 * frame.width, y: frame.minY + 0.04214 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.39128 * frame.width, y: frame.minY + 0.01136 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.98684 * frame.width, y: frame.minY + 0.43182 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.76888 * frame.width, y: frame.minY + 0.01136 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.98684 * frame.width, y: frame.minY + 0.19961 * frame.height))
        bezierPath.close()
        context.saveGState()
        context.setShadow(offset: GWStyleKit.littleShadow.shadowOffset, blur: GWStyleKit.littleShadow.shadowBlurRadius, color: (GWStyleKit.littleShadow.shadowColor as! UIColor).cgColor)
        GWStyleKit.theBorderColor.setStroke()
        bezierPath.lineWidth = 1
        bezierPath.lineJoinStyle = .round
        bezierPath.stroke()
        context.restoreGState()


        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.move(to: CGPoint(x: frame.minX + 0.97368 * frame.width, y: frame.minY + 0.43329 * frame.height))
        bezier2Path.addCurve(to: CGPoint(x: frame.minX + 0.58578 * frame.width, y: frame.minY + 0.83713 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.97368 * frame.width, y: frame.minY + 0.63465 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.80644 * frame.width, y: frame.minY + 0.80215 * frame.height))
        bezier2Path.addCurve(to: CGPoint(x: frame.minX + 0.50000 * frame.width, y: frame.minY + 0.96591 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.55831 * frame.width, y: frame.minY + 0.87837 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.50000 * frame.width, y: frame.minY + 0.96591 * frame.height))
        bezier2Path.addCurve(to: CGPoint(x: frame.minX + 0.41422 * frame.width, y: frame.minY + 0.83713 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.50000 * frame.width, y: frame.minY + 0.96591 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.44169 * frame.width, y: frame.minY + 0.87837 * frame.height))
        bezier2Path.addCurve(to: CGPoint(x: frame.minX + 0.02632 * frame.width, y: frame.minY + 0.43329 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.19356 * frame.width, y: frame.minY + 0.80215 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.02632 * frame.width, y: frame.minY + 0.63465 * frame.height))
        bezier2Path.addCurve(to: CGPoint(x: frame.minX + 0.21771 * frame.width, y: frame.minY + 0.10357 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.02632 * frame.width, y: frame.minY + 0.29822 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.10156 * frame.width, y: frame.minY + 0.17839 * frame.height))
        bezier2Path.addCurve(to: CGPoint(x: frame.minX + 0.50000 * frame.width, y: frame.minY + 0.02273 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.29654 * frame.width, y: frame.minY + 0.05278 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.39422 * frame.width, y: frame.minY + 0.02273 * frame.height))
        bezier2Path.addCurve(to: CGPoint(x: frame.minX + 0.97368 * frame.width, y: frame.minY + 0.43329 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.76161 * frame.width, y: frame.minY + 0.02273 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.97368 * frame.width, y: frame.minY + 0.20654 * frame.height))
        bezier2Path.close()
        UIColor.white.setFill()
        bezier2Path.fill()
    }

    public dynamic class func drawBubbleImageView(frame: CGRect = CGRect(x: 0, y: 56, width: 38, height: 44)) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!

        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.move(to: CGPoint(x: frame.minX + 0.97368 * frame.width, y: frame.minY + 0.43329 * frame.height))
        bezier2Path.addCurve(to: CGPoint(x: frame.minX + 0.58578 * frame.width, y: frame.minY + 0.83713 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.97368 * frame.width, y: frame.minY + 0.63465 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.80644 * frame.width, y: frame.minY + 0.80215 * frame.height))
        bezier2Path.addCurve(to: CGPoint(x: frame.minX + 0.50000 * frame.width, y: frame.minY + 0.96591 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.55831 * frame.width, y: frame.minY + 0.87837 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.50000 * frame.width, y: frame.minY + 0.96591 * frame.height))
        bezier2Path.addCurve(to: CGPoint(x: frame.minX + 0.41422 * frame.width, y: frame.minY + 0.83713 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.50000 * frame.width, y: frame.minY + 0.96591 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.44169 * frame.width, y: frame.minY + 0.87837 * frame.height))
        bezier2Path.addCurve(to: CGPoint(x: frame.minX + 0.02632 * frame.width, y: frame.minY + 0.43329 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.19356 * frame.width, y: frame.minY + 0.80215 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.02632 * frame.width, y: frame.minY + 0.63465 * frame.height))
        bezier2Path.addCurve(to: CGPoint(x: frame.minX + 0.21771 * frame.width, y: frame.minY + 0.10357 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.02632 * frame.width, y: frame.minY + 0.29822 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.10156 * frame.width, y: frame.minY + 0.17839 * frame.height))
        bezier2Path.addCurve(to: CGPoint(x: frame.minX + 0.50000 * frame.width, y: frame.minY + 0.02273 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.29654 * frame.width, y: frame.minY + 0.05278 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.39422 * frame.width, y: frame.minY + 0.02273 * frame.height))
        bezier2Path.addCurve(to: CGPoint(x: frame.minX + 0.97368 * frame.width, y: frame.minY + 0.43329 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.76161 * frame.width, y: frame.minY + 0.02273 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.97368 * frame.width, y: frame.minY + 0.20654 * frame.height))
        bezier2Path.close()
        context.saveGState()
        context.setShadow(offset: GWStyleKit.littleShadow.shadowOffset, blur: GWStyleKit.littleShadow.shadowBlurRadius, color: (GWStyleKit.littleShadow.shadowColor as! UIColor).cgColor)
        UIColor.white.setFill()
        bezier2Path.fill()
        context.restoreGState()
    }

}



extension NSShadow {
    convenience init(color: AnyObject!, offset: CGSize, blurRadius: CGFloat) {
        self.init()
        self.shadowColor = color
        self.shadowOffset = offset
        self.shadowBlurRadius = blurRadius
    }
}
