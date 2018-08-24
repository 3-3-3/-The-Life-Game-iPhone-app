//
//  GoalPicker.swift
//  The Life Game
//
//  Created by Liam Keeley on 8/7/18.
//  Copyright © 2018 Liam Keeley. All rights reserved.
//

import Foundation
import UIKit

public class GoalPicker {
  var nextNodes : LinkedGoalPicker? //an array of all the next possible picker views
  var prevNode : GoalPicker? //the previous picker view or nil
  var goals : [Goal]? //if the picker view displays goals and not more picker views, then this; else nil, and vice versa
  var description : String //a description of the category
  var head : GoalPicker?
  var parent : UIViewController
  
  init(nexts : LinkedGoalPicker?, prev : GoalPicker?, gs : [Goal]?, descript : String, h : GoalPicker?, parent : UIViewController) {
    //nexts : the next GoalPickers, prev : the previous GoalPicker, gs : the goals for the categories, if any, descript : a descripotion of the category (i.e. "Heart"), h : the head goalpicker for this category (one of the first three goalpickers; only nil if one of these three
    description = descript
    nextNodes = nexts
    prevNode = prev
    goals = gs
    head = h
    self.parent = parent
    
    if nextNodes != nil {
      for picker in nextNodes!.getList() {
        if let p = parent as? Main {
          p.third.addSubview(picker.pickButton(parent: p.third))
        }
      }
    }
    
    else if goals != nil {
      for goal in goals! {
        if let p = parent as? Main {
          p.third.addSubview(goal.addTextContainer(parentview: p.third))
        }
      }
    }
  }
  
  public func pickButton(parent : UIView) -> UIView {
    //define view to be used by prevNode to pick self
    //parent : the parent view that this view is being added to
    var selector : UIView
    if parent.subviews.count > 0 {
      selector = UIView(frame: CGRect(x: 0, y: parent.subviews[parent.subviews.count - 1].frame.maxY + 2, width: parent.frame.width, height: parent.frame.height / 6))
    }
    else {
      selector = UIView(frame: CGRect(x: 0, y: parent.subviews[parent.subviews.count - 1].frame.maxY + 2, width: parent.frame.width, height: parent.frame.height / 6))
    }
    
    let description : UILabel = UILabel(frame: CGRect(x : 0, y : selector.frame.midY + (selector.frame.height - 10) / 2, width : selector.frame.width, height : selector.frame.height - 10))
    description.text = self.description
    description.isUserInteractionEnabled = false
    description.backgroundColor = nil
  
    return selector
  }
  
  func sortByDifficulty(_ goalsArray : [Goal]) -> [Goal] {
    var returnArray : [Goal] = goalsArray
    //iterate the contents of the array besides the first
    for num in 1 ... returnArray.count - 1 {
      //save the goal for the current iteration
      let next : Goal = returnArray[num]
      
      var i : Int = num
      //Find the place to insert the value in the first n values; Shift the values to the right
      while i > 0 && next.getDiff().hashValue < returnArray[i-1].getDiff().hashValue {
        returnArray[i] = returnArray[i - 1]
        i = i - 1
      }
      //set the position for the current iteration to the value
      returnArray[i] = next
    }
    return returnArray
  }
  
}
