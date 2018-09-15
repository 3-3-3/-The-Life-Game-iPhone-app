//
//  File.swift
//  The Life Game
//
//  Created by Liam Keeley on 9/13/18.
//  Copyright © 2018 Liam Keeley. All rights reserved.
//

import Foundation

public struct Day : Hashable {
  let date : Date
  let points : Int
  
  init(date : Date = Date(), points : Int) {
    self.date = date
    self.points = points
  }
  
  public var hashValue : Int {
    get {
      return self.points
    }
  }
}

public func == (rhs : Day, lhs : Day) -> Bool {
  return rhs.hashValue == lhs.hashValue
}
