//
//  UIView+AutoLayoutHelpers.swift
//  RandomUser
//
//  Created by wearemobilefirst on 16/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import UIKit

public extension UIView {

    /// Set autolayout constraints to stick the current view to another view bounds
    /// - parameter aView: another view
    /// - parameter insets: insets for top, left, right, bottom edge of superview
    /// - return: newly added constraints
    @discardableResult
    func addConstraintsToFill(
        aView: UIView,
        withInsets insets: UIEdgeInsets = UIEdgeInsets.zero
    ) -> [NSLayoutConstraint] {
        self.translatesAutoresizingMaskIntoConstraints = false

        let autolayoutViews = ["currentView": self]
        let horizontalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-\(insets.left)-[currentView]-\(insets.right)-|",
            options: [],
            metrics: nil,
            views: autolayoutViews
        )
        let verticalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-\(insets.top)-[currentView]-\(insets.bottom)-|",
            options: [],
            metrics: nil,
            views: autolayoutViews
        )
        aView.addConstraints(horizontalConstraints)
        aView.addConstraints(verticalConstraints)

        return horizontalConstraints + verticalConstraints
    }


    /// Set autolayout constraints to stick the current view to anotehr view safe area
    /// - parameter aViewSafeArea: another view
    /// - return: newly added constraints
    func addConstraintsToFill(aViewSafeArea aView: UIView) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false

        let constraints = [
            bottomAnchor.constraint(equalTo: aView.safeAreaLayoutGuide.bottomAnchor),
            leadingAnchor.constraint(equalTo: aView.safeAreaLayoutGuide.leadingAnchor),
            trailingAnchor.constraint(equalTo: aView.safeAreaLayoutGuide.trailingAnchor),
            topAnchor.constraint(equalTo: aView.safeAreaLayoutGuide.topAnchor)
        ]

        constraints.forEach { $0.isActive = true }

        return constraints
    }


    /// Set autolayout constraints to fill the view's superview safe area
    @discardableResult
    func addConstraintsToFillSuperViewSafeArea() -> [NSLayoutConstraint] {
        guard let superview = superview else {
            fatalError("Adding constraints before view is added to superview")
        }
        return self.addConstraintsToFill(aViewSafeArea: superview)
    }
    
    
    /// Set autolayout constraints to fill the view's superview
    @discardableResult
    func addConstraintsToFillSuperview() -> [NSLayoutConstraint] {
        guard let superview = superview else {
            fatalError("Adding constraints before view is added to superview")
        }
        return self.addConstraintsToFill(aView: superview)
    }
    
    
    /// Set autolayout constraints to center this view in the view's superview
    func addConstraintsToCenterInSuperview() {
        guard let superview = superview else {
            fatalError("Adding constraints before view is added to superview")
        }
        let centerXConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: superview, attribute: .centerX, multiplier: 1, constant: 0)
        let centerYConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: superview, attribute: .centerY, multiplier: 1, constant: 0)
        superview.addConstraints([centerXConstraint, centerYConstraint])
    }


    /// Add a subview and set autolayout constraints to make the subview fill this view
    func addSubviewFillingSuperview(_ subview: UIView) {
        addSubview(subview)
        subview.addConstraintsToFillSuperview()
    }


    /// Set autolayout constraint to force 16:9 aspect ratio based on the superview width
    @discardableResult
    func addConstraintsToForceWideScreenRatio() -> [NSLayoutConstraint] {
        guard let superview = superview else {
            fatalError("Adding constraints before view is added to superview")
        }
        let height = heightAnchor.constraint(equalTo: superview.widthAnchor, multiplier: 9 / 16)
        height.isActive = true
        return [height]
    }
    
}
