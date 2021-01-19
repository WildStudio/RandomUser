//
//  ViewState.swift
//  RandomUser
//
//  Created by Christian Aranda on 19/01/2021.
//  Copyright © 2021 adevinta. All rights reserved.
//

import Foundation

/// Enum describing the available states of a view
public enum ViewState<StateType> {
    /// Initial state and state where no data is available
    case empty
    /// State when the data is being loaded
    case loading
    /// State when new data is available to the view
    case ready(StateType)
    /// State when an error has occured and should be reflected in the view
    case error(Error)
}

public protocol ViewStateProviding: AnyObject {
    /// Type of the ViewState
    associatedtype StateType

    /// Current viewState
    var viewState: ViewState<StateType> { get }

    /// Callback to observe view state changes.
    var onViewStateChange: ((ViewState<StateType>) -> Void)? { get }
}

// MARK: - Equatable

extension ViewState: Equatable {
    public static func == (lhs: ViewState, rhs: ViewState) -> Bool {
        switch (lhs, rhs) {
        case (.empty, .empty), (.loading, .loading), (.ready, .ready), (.error, .error):
            return true
        default:
            return false
        }
    }
}

extension ViewState where StateType: Equatable {
    public static func == (lhs: ViewState<StateType>, rhs: ViewState<StateType>) -> Bool {
        switch (lhs, rhs) {
        case (.empty, .empty), (.loading, .loading), (.error, .error):
            return true
        case let (.ready(lhsValue), .ready(rhsValue)):
            return lhsValue == rhsValue
        default:
            return false
        }
    }
}

// MARK: - Void State Type

extension ViewState where StateType == Void {
    public static var ready: ViewState<Void> {
        return .ready(())
    }
}

