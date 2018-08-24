//
//  LinkedGoalPicker.swift
//  The Life Game
//
//  Created by Liam Keeley on 8/8/18.
//  Copyright © 2018 Liam Keeley. All rights reserved.
//

import Foundation
import UIKit

public class LinkedGoalPicker {
  private var head : GoalPicker?
  private var tail : GoalPicker?
  private var list : [GoalPicker] = []
  
  init(first : GoalPicker) {
    //initializes a LinkedGoalPicker with one element.
    self.head = first
    self.tail = first
    list.append(first)
  }
  
  init() {
    //initializes an empty LinkedGoalPicker
    self.head = nil
    self.tail = nil
  }
  
  public func getHead() -> GoalPicker? {
    return head
  }
  
  public func getList() -> [GoalPicker] {
    return list
  }
  
  public func getTail() -> GoalPicker? {
    return tail
  }
  
    public func add(new : GoalPicker) {
    if self.list.count > 0 {
      self.tail = new
    }
    else {
      self.tail = new
      self.head = new
    }
    self.list.append(new)
  }
  
  //function to append to the 
  public func appendToTail(_ newCategory : String, at : Int) {
    if self.list.count - 1 <= at {
       head = self.list[0]
      let newPicker : GoalPicker = GoalPicker(nexts: nil, prev: self.tail, gs: nil, descript : newCategory, h : self.head!, parent : (self.head?.parent)!)
      self.list[at].nextNodes?.add(new: newPicker)
    }
    
    else {
      print("picker cannot be added to non-existant node")
    }
  }
}
