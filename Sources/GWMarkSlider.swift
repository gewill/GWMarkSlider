//
//  GWMarkSlider.swift
//  CustomSliderExample
//
//  Created by William Archimede on 04/09/2014.
//  Copyright (c) 2014 HoodBrains. All rights reserved.
//

import UIKit
import QuartzCore

class GWMarkSliderTrackLayer: CALayer {
    weak var markSlider: GWMarkSlider?

    override func drawInContext(ctx: CGContext) {
        guard let slider = markSlider else {
            return
        }

        // Clip
        // 移除tacker 的圆角
//        let cornerRadius = bounds.height * slider.curvaceousness / 2.0
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        CGContextAddPath(ctx, path.CGPath)

        // Fill the track
        CGContextSetFillColorWithColor(ctx, slider.trackTintColor.CGColor)
        CGContextAddPath(ctx, path.CGPath)
        CGContextFillPath(ctx)

        // Fill the highlighted range
        CGContextSetFillColorWithColor(ctx, slider.trackHighlightTintColor.CGColor)
        let lowerValuePosition = CGFloat(slider.positionForValue(slider.currentValue))
        let rect = CGRect(x: lowerValuePosition, y: 0.0, width: bounds.width - lowerValuePosition, height: bounds.height)
        CGContextFillRect(ctx, rect)
    }
}

class GWMarkSliderThumbLayer: CALayer {
    var highlighted: Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }
    weak var markSlider: GWMarkSlider?

    override func drawInContext(ctx: CGContext) {
        guard let slider = markSlider else {
            return
        }

        // 内边距为边线宽度的一半，故此处防止边线超出边界被截断
        let thumbFrame = bounds.insetBy(dx: 0.25, dy: 0.25)
//        let thumbFrame = bounds.insetBy(dx: 10, dy: 10)
//        let thumbFrame = bounds
        let cornerRadius: CGFloat = bounds.height / 2.0
        let thumbPath = UIBezierPath(roundedRect: thumbFrame, cornerRadius: cornerRadius)

        // Fill 填充
        CGContextSetFillColorWithColor(ctx, UIColor.whiteColor().CGColor)
        CGContextAddPath(ctx, thumbPath.CGPath)
        CGContextFillPath(ctx)

        // Outline 边线
        // 画线时候，宽度是左右各占一半
        let strokeColor = slider.thumbTintColor
        CGContextSetStrokeColorWithColor(ctx, strokeColor.CGColor)
        CGContextSetLineWidth(ctx, 0.5)
        CGContextAddPath(ctx, thumbPath.CGPath)
        CGContextStrokePath(ctx)

        if highlighted {
            CGContextSetFillColorWithColor(ctx, UIColor(white: 0.0, alpha: 0.1).CGColor)
            CGContextAddPath(ctx, thumbPath.CGPath)
            CGContextFillPath(ctx)
        }
    }
}

class GWMarkSliderMarkLayer: CALayer {

    weak var markSlider: GWMarkSlider?

    var markPosition: Double = 0.0

    override func drawInContext(ctx: CGContext) {
        guard let slider = markSlider else {
            return
        }

        let thumbFrame = bounds
        let cornerRadius: CGFloat = slider.trackHeight / 2.0
        let thumbPath = UIBezierPath(roundedRect: thumbFrame, cornerRadius: cornerRadius)

        // Fill 填充
        CGContextSetFillColorWithColor(ctx, slider.markTintColor.CGColor)
        CGContextAddPath(ctx, thumbPath.CGPath)
        CGContextFillPath(ctx)

    }
}

@IBDesignable
class GWMarkSlider: UIControl {

    // MARK: - properties

    // 标记点数组：范围 0-1
    var markPositions: [Double] = [Double]() {

        willSet {
            markLayers = [GWMarkSliderMarkLayer]()
        }

        didSet {
            resetMarkLayers()
        }
    }

    var selectedMarkIndex = 0

    @IBInspectable var minimumValue: Double = 0.0 {
        willSet(newValue) {
            assert(newValue < maximumValue, "GWMarkSlider: minimumValue should be lower than maximumValue")
        }
        didSet {
            updateLayerFrames()
        }
    }

    @IBInspectable var maximumValue: Double = 1.0 {
        willSet(newValue) {
            assert(newValue > minimumValue, "GWMarkSlider: maximumValue should be greater than minimumValue")
        }
        didSet {
            updateLayerFrames()
        }
    }

    @IBInspectable var currentValue: Double = 0.2 {
        didSet {
            if currentValue < minimumValue {
                currentValue = minimumValue
            }
            updateLayerFrames()
        }
    }

    @IBInspectable var trackTintColor = UIColor(red: 0.0, green: 0.45, blue: 0.94, alpha: 1.0) {
        didSet {
            trackLayer.setNeedsDisplay()
        }
    }

    @IBInspectable var trackHighlightTintColor = UIColor(white: 0.9, alpha: 1.0) {
        didSet {
            trackLayer.setNeedsDisplay()
        }
    }

    @IBInspectable var thumbTintColor = UIColor(red: 0.0, green: 0.45, blue: 0.94, alpha: 1.0) {
        didSet {
            lowerThumbLayer.setNeedsDisplay()
        }
    }

    @IBInspectable var markTintColor = UIColor.whiteColor() {
        didSet {
            for markLayer in markLayers {
                markLayer.setNeedsDisplay()
            }
        }
    }

    @IBInspectable var trackHeight: CGFloat = 1.0 {
        didSet {
            trackLayer.setNeedsLayout()
        }
    }

    private var previouslocation = CGPoint()

    private let trackLayer = GWMarkSliderTrackLayer()
    private let lowerThumbLayer = GWMarkSliderThumbLayer()
    private var markLayers = [GWMarkSliderMarkLayer]()

    private var thumbWidth: CGFloat {
        return CGFloat(bounds.height)
    }

    override var frame: CGRect {
        didSet {
            updateLayerFrames()
        }
    }

    // MARK: - life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)

        initializeLayers()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        initializeLayers()
    }

    override func layoutSublayersOfLayer(layer: CALayer) {
        super.layoutSublayersOfLayer(layer)
        updateLayerFrames()
    }

    // MARK: - update frames methods
    // UIs
    private func initializeLayers() {
        layer.backgroundColor = UIColor.clearColor().CGColor

        trackLayer.markSlider = self
        trackLayer.contentsScale = UIScreen.mainScreen().scale
        layer.addSublayer(trackLayer)

        lowerThumbLayer.markSlider = self
        lowerThumbLayer.contentsScale = UIScreen.mainScreen().scale
        layer.addSublayer(lowerThumbLayer)

        for markPosition in markPositions {
            let markLayer = GWMarkSliderMarkLayer()
            markLayer.markSlider = self
            markLayer.contentsScale = UIScreen.mainScreen().scale
            markLayer.markPosition = markPosition
            markLayers.append(markLayer)
            layer.addSublayer(markLayer)
        }

    }

    func updateLayerFrames() {
        CATransaction.begin()
        CATransaction.setDisableActions(true)

        trackLayer.frame = bounds.insetBy(dx: 0.0, dy: (bounds.height - trackHeight) / 2)
        trackLayer.setNeedsDisplay()

        let lowerThumbCenter = CGFloat(positionForValue(currentValue))
        lowerThumbLayer.frame = CGRect(x: lowerThumbCenter - thumbWidth / 2.0, y: 0.0, width: thumbWidth, height: thumbWidth)
        lowerThumbLayer.setNeedsDisplay()

        for markLayer in markLayers {
            let markLayerCenter = CGFloat(positionForValue(markLayer.markPosition))
            markLayer.frame = CGRect(x: markLayerCenter - trackHeight, y: (bounds.height - trackHeight) / 2, width: trackHeight * 2, height: trackHeight)
            markLayer.setNeedsDisplay()
        }

        CATransaction.commit()

    }

    private func resetMarkLayers() {

        for markPosition in markPositions {
            let markLayer = GWMarkSliderMarkLayer()
            markLayer.markSlider = self
            markLayer.contentsScale = UIScreen.mainScreen().scale
            markLayer.markPosition = markPosition
            markLayers.append(markLayer)
            layer.insertSublayer(markLayer, below: lowerThumbLayer)
        }

    }

    // 计算value对应thunb图标的中心位置
    // 对应 UISlider，整体的可以滑动的宽度，减少一个thumb图标的宽度
    // thumb的位置就是可滑动的宽度乘以value与（最大值减去最小值）的占例
    // 再加上前面半个thumb的宽度
    func positionForValue(value: Double) -> Double {
        return Double(bounds.width - thumbWidth) * (value - minimumValue) /
            (maximumValue - minimumValue) + Double(thumbWidth / 2.0)
    }

    // MARK: - Touches: UIControl touch change methods
    // Actions

    override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        let location = touch.locationInView(self)

        // Hit test the thumb layers
        if lowerThumbLayer.frame.contains(location) {
            previouslocation = location
            lowerThumbLayer.highlighted = true
            return true
        } else {
            // 点击标记点
            for (index, markLayer) in markLayers.enumerate() {
                if markLayer.frame.contains(location) {
                    selectedMarkIndex = index
                    sendActionsForControlEvents(.ValueChanged)

                    return false
                }
            }
        }

        return false
    }

    override func continueTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        let location = touch.locationInView(self)

        // Determine by how much the user has dragged
        // 和上一次的偏移量
        let deltaLocation = Double(location.x - previouslocation.x)
        let deltaValue = (maximumValue - minimumValue) * deltaLocation / Double(bounds.width - thumbWidth)

        previouslocation = location

        // Update the values
        if lowerThumbLayer.highlighted {
            currentValue = max(min((currentValue + deltaValue), maximumValue), minimumValue)
        }

        sendActionsForControlEvents(.EditingChanged)

        return true
    }

    override func endTrackingWithTouch(touch: UITouch?, withEvent event: UIEvent?) {
        lowerThumbLayer.highlighted = false
    }

}
