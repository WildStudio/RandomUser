//
//  Sequence+Unique.swift
//  RandomUser
//
//  Created by wearemobilefirst on 16/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import Foundation

public extension Sequence where Element: Hashable {
    
  var uniqueElements: Set<Element> {
    return self.reduce(into: []) {
      uniqueElements, element in

      if !uniqueElements.contains(element) {
        uniqueElements.update(with: element)
      }
    }
  }
    
}
