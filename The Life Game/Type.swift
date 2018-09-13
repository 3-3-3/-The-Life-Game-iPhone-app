//
//  Difficulty.swift
//  The Life Game
//
//  Created by Liam Keeley on 5/23/18.
//  Copyright © 2018 Liam Keeley. All rights reserved.
//

import Foundation

public enum Type : Hashable {
  case MIND
  case BODY
  case HEART

  public var hashValue : Int {
    get {
      switch self {
        case .MIND :
          return 0
        case .BODY :
          return 1
        case .HEART :
          return 2
      }
    }
  }
}

//Equatable conformance 
public func == (lhs : Type, rhs : Type) -> Bool {
  return lhs.hashValue == rhs.hashValue
}



