//
//  Length.swift
//  The Life Game
//
//  Created by Liam Keeley on 5/23/18.
//  Copyright © 2018 Liam Keeley. All rights reserved.
//

import Foundation

public enum Length : Hashable {
  case YEARLY
  case MONTHLY
  case WEEKLY
  case DAILY
  case STATIC
  
  public var hashValue : Int {
    get {
      switch self {
        case .YEARLY :
          return 0
        case .MONTHLY :
          return 1
        case .WEEKLY :
          return 2
        case .DAILY :
          return 3
        case .STATIC :
          return 4
      }
    }
  }
}

//Equatable
public func == (lhs : Length, rhs : Length) -> Bool {
  return lhs.hashValue == rhs.hashValue
}




