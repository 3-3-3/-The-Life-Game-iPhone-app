//
//  Goal.swift
//  The Life Game
//
//  Created by Liam Keeley on 5/22/18.
//  Copyright © 2018 Liam Keeley. All rights reserved.
//Conforms to UITextFieldDelegate

import Foundation
import UIKit

public class Goal : Hashable {
  //a "goal"; defined by the goal, a title, the points it offers, its difficulty, and length
  private var  goal : String
  private var goalTitle : String
  private var  points : Int
  private var diff : Difficulty
  private var length : Length
  private var timer : Timer?
  var textContainer : UIView?
  public var hashValue: Int {
    get {
      return self.goal.hashValue
    }
  }

  init(g : String, t : String, p : Int, d : Difficulty, l : Length) {
    self.goal = g
    self.goalTitle = t
    self.points = p
    self.diff = d
    self.length = l
    
    if length == .DAILY {
      timer = Timer.scheduledTimer(timeInterval: 60*60*23, target: self, selector: #selector(fired(repeats:)), userInfo: nil, repeats: true) //Once every day
    }
    else if length == .WEEKLY {
      timer = Timer.scheduledTimer(timeInterval: 60*60*24*7, target: self, selector: #selector(fired(repeats:)), userInfo: nil, repeats: true) //Once a week
    }
    else if length == .MONTHLY {
      timer = Timer.scheduledTimer(timeInterval: 60*60*24*7*30.4375, target: self, selector: #selector(fired(repeats:)), userInfo: nil, repeats: true) //Once a month
    }
    else if length == .YEARLY {
      timer = Timer.scheduledTimer(timeInterval: 60*60*24*365.25, target: self, selector: #selector(fired(repeats:)), userInfo: nil, repeats: true) //Once an average year
    }
    else {
      timer = nil
    }
  }
  
  @objc func fired(repeats : Bool)  {
    // code for when timer fires
    
  }

  //getters and setters
  public func getGoal() -> String {
    return goal
  }

  public func setGoal(new : String) {
    goal = new
  }
  
  public func getGoalTitle() -> String {
    return goalTitle
  }
  
  public func setGoalTitle(new : String) {
    goalTitle = new
  }

  public func getPoints() -> Int {
    return points
  }

  public func setPoints(new : Int) {
    points = new
  }

  public func getDiff() -> Difficulty {
    return diff;
  }

  public func setDiff(new : Difficulty) {
    diff = new
  }

  public func getLength() -> Length {
    return length
  }

  public func setLength(new : Length) {
    self.length = new
  }
  
  func formatTimer() -> String? {
    if timer != nil {
      let remainingTime : Double = timer!.fireDate.timeIntervalSinceNow
      
      if remainingTime > 60*60*24 {
        return String (Int ((remainingTime / (60*60*24)).rounded())) + " Days"
      }
      else {
        return String (Int ((remainingTime / (60 * 60)).rounded())) + ":" + String ((Int (remainingTime) % (60*60)) / 60)
      }
    } else {
      return nil
    }
  }
  
  //Formats a text container that holds the view
  public func addTextContainer(parentview : UIView) -> UIView {
    if parentview.subviews.count > 0 {
      textContainer = UIView(frame : CGRect(x : parentview.frame.minX, y : (parentview.subviews[parentview.subviews.count-1].frame.maxY + 1), width : parentview.bounds.width, height : parentview.bounds.height / 6))
    } else {
      textContainer = UIView(frame : CGRect(x : parentview.bounds.minX, y : parentview.bounds.minY,  width : parentview.bounds.width, height : parentview.bounds.height / 6))
    }
    
    textContainer!.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    
    textContainer!.addSubview(UIView(frame : CGRect(x : textContainer!.bounds.minX + 2, y : textContainer!.bounds.minY + 2, width : textContainer!.bounds.width - 4, height : textContainer!.bounds.height - 4)))
    
    if self.getDiff() == .DIFFICULT {
      textContainer!.subviews[0].backgroundColor = Color.DIFFICULTCOLOR
    } else if self.getDiff() == .MEDIUM {
      textContainer!.subviews[0].backgroundColor = Color.MEDIUMCOLOR
    } else {
      textContainer!.subviews[0].backgroundColor = Color.EASYCOLOR
    }
    
    let titleTextView : UITextField = UITextField(frame : CGRect(x : textContainer!.subviews[0].bounds.minX + 5,
                                                                 y : textContainer!.subviews[0].bounds.midY - ((textContainer!.subviews[0].bounds.height - 10) / 2),
                                                                 width : textContainer!.subviews[0].bounds.width - 25,
                                                                 height : textContainer!.subviews[0].bounds.height - 10))
    titleTextView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
    titleTextView.text = self.getGoalTitle()
    titleTextView.isUserInteractionEnabled = false
    
    let pointsTextView : UITextField = UITextField(frame : CGRect(x : textContainer!.subviews[0].bounds.midX,
                                                                  y : textContainer!.subviews[0].bounds.midY - ((textContainer!.subviews[0].bounds.height - 10)/2),
                                                                  width : 30,
                                                                  height : textContainer!.bounds.height - 10))
    pointsTextView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
    pointsTextView.text = String (self.points)
    pointsTextView.isUserInteractionEnabled = false
    
    let timerTextView : UITextField = UITextField(frame : CGRect(x : textContainer!.subviews[0].bounds.width - 75,
                                                                 y : textContainer!.subviews[0].bounds.midY - ((textContainer!.subviews[0].bounds.height
                                                                  - 10) / 2),
                                                                 width : 65 ,
                                                                 height : textContainer!.bounds.height - 10))
    timerTextView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
    timerTextView.text = self.formatTimer()
    timerTextView.isUserInteractionEnabled = false
    
    
    /*titleTextView.addConstraint(NSLayoutConstraint(item: titleTextView,
                                                     attribute: .leftMargin,
                                                     relatedBy: .equal,
                                                     toItem: nil,
                                                     attribute: .left,
                                                     multiplier: 2,
                                                     constant: 2))
    
    titleTextView.addConstraint(NSLayoutConstraint(item: pointsTextView,
                                                     attribute: .right,
                                                     relatedBy: .equal,
                                                     toItem: titleTextView,
                                                     attribute: .left,
                                                     multiplier: 2,
                                                     constant: titleTextView.superview!.bounds.midX))
   
   pointsTextView.addConstraint(NSLayoutConstraint(item: pointsTextView,
                                                     attribute: .right,
                                                     relatedBy: .equal,
                                                     toItem: timerTextView,
                                                     attribute: .left,
                                                     multiplier: 2,
                                                     constant: 10))
  
  timerTextView.addConstraint(NSLayoutConstraint(item: timerTextView,
                                                   attribute: .rightMargin,
                                                   relatedBy: .equal,
                                                   toItem: nil,
                                                   attribute: .left,
                                                   multiplier: 2,
                                                   constant: 2)) */
    
    
    textContainer!.addSubview(titleTextView)
    textContainer!.addSubview(pointsTextView)
    textContainer!.addSubview(timerTextView)
    
    parentview.addSubview(textContainer!)
    return textContainer!
  }
}

public func == (lhs : Goal, rhs : Goal) -> Bool {
  return lhs.hashValue == rhs.hashValue
}







