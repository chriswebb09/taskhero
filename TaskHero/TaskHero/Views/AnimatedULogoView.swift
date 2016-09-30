//
//  AnimatedULogoView.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/29/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import QuartzCore

open class AnimatedULogoView: UIView {
    fileprivate let strokeEndTimingFunction   = CAMediaTimingFunction(controlPoints: 1.00, 0.0, 0.35, 1.0)
    fileprivate let squareLayerTimingFunction      = CAMediaTimingFunction(controlPoints: 0.25, 0.0, 0.20, 1.0)
    fileprivate let circleLayerTimingFunction   = CAMediaTimingFunction(controlPoints: 0.65, 0.0, 0.40, 1.0)
    fileprivate let fadeInSquareTimingFunction = CAMediaTimingFunction(controlPoints: 0.15, 0, 0.85, 1.0)
    
    fileprivate let radius: CGFloat = 37.5
    fileprivate let squareLayerLength = 21.0
    fileprivate let startTimeOffset = 0.7 * Constants.kAnimationDuration
    
    fileprivate var circleLayer: CAShapeLayer!
    fileprivate var squareLayer: CAShapeLayer!
    fileprivate var lineLayer: CAShapeLayer!
    fileprivate var maskLayer: CAShapeLayer!
}
