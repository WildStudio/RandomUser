//
//  UIViewController+Child.swift
//  RandomUser
//
//  Created by wearemobilefirst on 16/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /// Add child viewcontroller.
    ///
    /// - Parameters:
    ///   - child: The child controller to be added as a child.
    func embed(_ child: UIViewController) {
        addChild(child)
        child.didMove(toParent: self)
    }
    
    /// Remove child viewcontroller.
    ///
    /// - Parameter child: The child controller.
    func remove(_ child: UIViewController) {
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
    
}
