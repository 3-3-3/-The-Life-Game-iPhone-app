//
//  Difficulty.swift
//  The Life Game
//
//  Created by Liam Keeley on 5/23/18.
//  Copyright © 2018 Liam Keeley. All rights reserved.
//

import Foundation

public enum Difficulty : Hashable {
  case DIFFICULT
  case MEDIUM
  case EASY

  public var hashValue : Int {
    get {
      switch self {
        case .DIFFICULT :
          return 0
        case .MEDIUM :
          return 1
        case .EASY :
          return 2
      }
    }
  }
}

//Equatable conformance 
public func == (lhs : Difficulty, rhs : Difficulty) -> Bool {
  return lhs.hashValue == rhs.hashValue
}



