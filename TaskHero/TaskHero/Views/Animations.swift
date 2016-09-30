//
//  Animations.swift
//  TaskHero
//
//  Created by Christopher Webb-Orenstein on 9/29/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class Animations {
    
    var duration = 0.7
    var delay = 0.0
    var damping = 0.7
    var velocity = 0.7
    
    func springWithDelay(duration: TimeInterval, delay: TimeInterval, animations: (() -> Void)!) {
        
        UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: [], animations: {
            
            animations()
            
            }, completion: { finished in
                
        })
    }
    
}
