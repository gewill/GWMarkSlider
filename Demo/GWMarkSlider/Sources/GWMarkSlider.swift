//
//  GWMarkSlider.swift
//
//
//  Created by Will on 6/28/16.
//  Copyright © 2016 gewill.org. All rights reserved.
//

import UIKit
import QuartzCore

@objc class GWMarkSliderTrackLayer: CALayer {
    weak var markSlider: GWMarkSlider?

    override func draw(in ctx: CGContext) {
        guard let slider = markSlider else {
            return
        }

        // Clip
        // 移除tacker 的圆角
//        let cornerRadius = bounds.height * slider.curvaceousness / 2.0
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: 0)
        ctx.addPath(path.cgPath)

        // Fill min track
        ctx.setFillColor(slider.minTintColor.cgColor)
        ctx.addPath(path.cgPath)
        ctx.fillPath()

        // Fill max track
        ctx.setFillColor(slider.maxTintColor.cgColor)
        let currentValuePosition = CGFloat(slider.positionForValue(slider.currentValue))
        let rect = CGRect(x: currentValuePosition, y: 0.0, width: bounds.width - currentValuePosition, height: bounds.height)
        ctx.fill(rect)
    }
}

/// 当前进度点
@objc class GWMarkSliderThumbLayer: CALayer {
    var highlighted: Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }
    weak var markSlider: GWMarkSlider?

    override func draw(in ctx: CGContext) {
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
        ctx.setFillColor(UIColor.white.cgColor)
        ctx.addPath(thumbPath.cgPath)
        ctx.fillPath()

        // Outline 边线
        // 画线时候，宽度是左右各占一半
        let strokeColor = slider.thumbTintColor
        ctx.setStrokeColor(strokeColor.cgColor)
        ctx.setLineWidth(0.5)
        ctx.addPath(thumbPath.cgPath)
        ctx.strokePath()

        if highlighted {
            ctx.setFillColor(UIColor(white: 0.0, alpha: 0.1).cgColor)
            ctx.addPath(thumbPath.cgPath)
            ctx.fillPath()
        }
    }
}

///标记点
@objc class GWMarkSliderMarkLayer: CALayer {

    weak var markSlider: GWMarkSlider?

    var markValue: Double = 0.0

    override func draw(in ctx: CGContext) {
        guard let slider = markSlider else {
            return
        }

        let thumbFrame = bounds
//        let cornerRadius: CGFloat = slider.trackHeight / 2.0
        let thumbPath = UIBezierPath(roundedRect: thumbFrame, cornerRadius: 0)

        // Fill 填充
        ctx.setFillColor(slider.markTintColor.cgColor)
        ctx.addPath(thumbPath.cgPath)
        ctx.fillPath()

    }
}

@IBDesignable
@objc class GWMarkSlider: UIControl {

    // MARK: - properties

    // 标记点数组：范围 0-1
    var markValues: [Double] = [Double]() {
        didSet {
            resetMarkLayers()
        }
    }

    var markImages: [UIImage] = [UIImage]() {
        didSet {
            resetMarkImageViews()
        }
    }

    var selectedMarkIndex = 0 {
        didSet {
            guard selectedMarkIndex < markValues.count else {
                return
            }
            guard selectedMarkIndex < markImages.count else {
                return
            }

            for (index, markImageView) in markImageViews.enumerated() {
                markImageView.isHighlighted = index == selectedMarkIndex
                if index == selectedMarkIndex {
                    self.bringSubview(toFront: markImageView)
                }
            }
        }
    }

    var markCenters: [CGPoint] {
        var centers = [CGPoint]()
        for markValue in markValues {
            centers.append(CGPoint(x: CGFloat(positionForValue(markValue)), y: bounds.height / 2))
        }
        return centers
    }

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

    @IBInspectable var minTintColor = UIColor(red: 0.0, green: 0.45, blue: 0.94, alpha: 1.0) {
        didSet {
            trackLayer.setNeedsDisplay()
        }
    }

    @IBInspectable var maxTintColor = UIColor(white: 0.9, alpha: 1.0) {
        didSet {
            trackLayer.setNeedsDisplay()
        }
    }

    @IBInspectable var thumbTintColor = UIColor(red: 0.0, green: 0.45, blue: 0.94, alpha: 1.0) {
        didSet {
            thumbLayer.setNeedsDisplay()
        }
    }

    @IBInspectable var markTintColor = UIColor.white {
        didSet {
            for markLayer in markLayers {
                markLayer.setNeedsDisplay()
            }
        }
    }

    @IBInspectable var trackHeight: CGFloat = 4.0 {
        didSet {
            trackLayer.setNeedsLayout()
        }
    }

    fileprivate var previouslocation = CGPoint()

    fileprivate let trackLayer = GWMarkSliderTrackLayer()
    fileprivate let thumbLayer = GWMarkSliderThumbLayer()
    fileprivate var markLayers = [GWMarkSliderMarkLayer]()
    fileprivate var markImageViews = [GWMarkImageView]()

    fileprivate var markImageViewWidth: CGFloat = 38
    fileprivate var markImageViewHeight: CGFloat = 44
    fileprivate var markImageViewBottom: CGFloat = 6

    fileprivate var thumbWidth: CGFloat = 12

    override var frame: CGRect {
        didSet {
            updateLayerFrames()
            updateViewFrames()
        }
    }

    // MARK: - life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupUI()
    }

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        updateLayerFrames()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateViewFrames()
    }

    // MARK: - update frames methods
    // UIs
    fileprivate func setupUI() {
        layer.backgroundColor = UIColor.clear.cgColor

        trackLayer.markSlider = self
        trackLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(trackLayer)

        thumbLayer.markSlider = self
        thumbLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(thumbLayer)

        // show in Iterface Builder
        resetMarkLayers()
        resetMarkImageViews()
    }

    func updateLayerFrames() {
        CATransaction.begin()
        CATransaction.setDisableActions(true)

        trackLayer.frame = CGRect(x: 0.0, y: markImageViewHeight + markImageViewBottom + (thumbWidth - trackHeight) / 2.0, width: bounds.width, height: trackHeight)
        trackLayer.setNeedsDisplay()

        let lowerThumbCenter = CGFloat(positionForValue(currentValue))
        thumbLayer.frame = CGRect(x: lowerThumbCenter - thumbWidth / 2.0, y: markImageViewHeight + markImageViewBottom, width: thumbWidth, height: thumbWidth)
        thumbLayer.setNeedsDisplay()

        for markLayer in markLayers {
            let markLayerCenterX = CGFloat(positionForValue(markLayer.markValue))
            markLayer.frame = CGRect(x: markLayerCenterX - trackHeight / 2.0, y: markImageViewHeight + markImageViewBottom + (thumbWidth - trackHeight) / 2.0, width: trackHeight, height: trackHeight)
            markLayer.setNeedsDisplay()
        }

        CATransaction.commit()

    }

    func updateViewFrames() {
        for markImageView in markImageViews {
            let markImageViewCenterX = CGFloat(positionForValue(markImageView.markValue))
            markImageView.frame = CGRect(x: markImageViewCenterX - markImageViewWidth / 2.0, y: 0, width: markImageViewWidth, height: markImageViewHeight)
            markImageView.setNeedsDisplay()
        }
    }

    fileprivate func resetMarkLayers() {

        for markValue in markValues {
            let markLayer = GWMarkSliderMarkLayer()
            markLayer.markSlider = self
            markLayer.contentsScale = UIScreen.main.scale
            markLayer.markValue = markValue
            markLayers.append(markLayer)
            layer.insertSublayer(markLayer, below: thumbLayer)
        }
    }

    fileprivate func resetMarkImageViews() {

        for (index, markValue) in markValues.enumerated() {
            let markImageView = GWMarkImageView()
            markImageView.markValue = markValue
            if index < markImages.count {
                markImageView.image = markImages[index]
            }
            markImageViews.append(markImageView)

            markImageView.tag = index
            markImageView.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.markImageViewClicked(_:)))
            markImageView.addGestureRecognizer(tap)

            self.addSubview(markImageView)
        }
    }


    // 计算value对应thunb图标的中心位置的x坐标
    // 对应 UISlider，整体的可以滑动的宽度，减少一个thumb图标的宽度
    // thumb的位置就是可滑动的宽度乘以value与（最大值减去最小值）的占例
    fileprivate func positionForValue(_ value: Double) -> Double {
        return Double(bounds.width) * (value - minimumValue) /
        (maximumValue - minimumValue)
    }

    // MARK: - Touches: UIControl touch change methods
    // Actions
    // 改为和UISlider一致

    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)

        // Hit test the thumb layers
        if thumbLayer.frame.contains(location) {
            previouslocation = location
            thumbLayer.highlighted = true
//            sendActions(for: .touchDown)

            return true
        } else {
            // 点击标记点
            for (index, markLayer) in markLayers.enumerated() {
                if markLayer.frame.contains(location) {
                    selectedMarkIndex = index
                    sendActions(for: .editingChanged)

                    return false
                }
            }

        }

        return false
    }

    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)

        // Determine by how much the user has dragged
        // 和上一次的偏移量
        let deltaLocation = Double(location.x - previouslocation.x)
        let deltaValue = (maximumValue - minimumValue) * deltaLocation / Double(bounds.width - thumbWidth)

        previouslocation = location

        // Update the values
        if thumbLayer.highlighted {
            currentValue = max(min((currentValue + deltaValue), maximumValue), minimumValue)
        }

        sendActions(for: .valueChanged)

        return true
    }

    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        if let location = touch?.location(in: self) {
            if thumbLayer.frame.contains(location) {
                thumbLayer.highlighted = false
//                sendActions(for: .touchUpInside)
            }
        }

    }

    // MARK: - response methods
    func markImageViewClicked(_ sender: UITapGestureRecognizer) {
        guard let markImageView = sender.view as? GWMarkImageView else { return }
        guard markImageView.tag < markValues.count else { return }

        selectedMarkIndex = markImageView.tag
        sendActions(for: .editingChanged)
    }

}
