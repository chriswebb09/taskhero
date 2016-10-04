//
//  Helpers.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 10/3/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

extension UIView {
    
    public func constrainEqual(attribute: NSLayoutAttribute, to: AnyObject, toAttribute: NSLayoutAttribute, multiplier: CGFloat = 1, constant: CGFloat = 0) {
        constrainEqual(attribute:attribute, to: to, toAttribute:toAttribute, multiplier: multiplier, constant: constant)
    }
    
    public func constrainEdges(to view: UIView) {
        constrainEqual(attribute: .top, to: view, toAttribute: .top)
        constrainEqual(attribute: .leading, to: view, toAttribute: .leading)
        constrainEqual(attribute: .trailing, to: view, toAttribute: .trailing)
        constrainEqual(attribute: .bottom, to: view, toAttribute: .bottom)
    }
    
    public func centered(inView: UIView? = nil) {
        guard let container = inView ?? self.superview else { fatalError() }
        centerXAnchor.constrainEqual(anchor: container.centerXAnchor)
        centerYAnchor.constrainEqual(anchor: container.centerYAnchor)
    }
}

extension NSLayoutAnchor {
    public func constrainEqual(anchor: NSLayoutAnchor, constant: CGFloat = 0) {
        let constrainer = constraint(equalTo: anchor, constant: constant)
        constrainer.isActive = true
    }
}
