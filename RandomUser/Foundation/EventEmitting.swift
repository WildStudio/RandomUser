//
//  EventEmitting.swift
//  RandomUser
//
//  Created by Christian Aranda on 19/01/2021.
//  Copyright © 2021 adevinta. All rights reserved.
//

public protocol EventEmitting: AnyObject {
    
    associatedtype EventType
    
    /// Fired every time a new event is triggered by the conformer.
    /// Events are generally backed by a PublichSubject and do therefore not result in a initial value on observing.
    
    /// Callback to observe view state changes.
    var onEvent: ((EventType) -> Void)? { get }
    
}
