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
  
  public func formatTimer() -> String? {
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
  
  //Formats a text container that holds the view, sets self.textContainer to that view, and returns the views viewController
  public func addTextContainer(parentview : UIView) -> UIViewController {
    let container : UIViewController = GoalTextContainer(parentview: parentview, goal: self)
    parentview.addSubview(container.view)
    
    return container
  }
}

public func == (lhs : Goal, rhs : Goal) -> Bool {
  return lhs.hashValue == rhs.hashValue
}


//A viewcontroller class defining the behaviors of GoalTextContainer, such as those used in the main interface
public class GoalTextContainer : UIViewController {
  private var goal : Goal
  private var parentview : UIView
  
  public init(parentview : UIView, goal : Goal) {
    print("Initialization began")
    self.parentview = parentview
    self.goal = goal
    
    //Super
    super.init(nibName: nil, bundle: nil)
    
    if parentview.subviews.count > 0 {
      self.view = UIView(frame : CGRect(x : parentview.frame.minX, y : (parentview.subviews[parentview.subviews.count-1].frame.maxY + 1), width : parentview.bounds.width, height : parentview.bounds.height / 6))
    } else {
      self.view = UIView(frame : CGRect(x : parentview.bounds.minX, y : parentview.bounds.minY,  width : parentview.bounds.width, height : parentview.bounds.height / 6))
    }
    
    self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    
    self.view.addSubview(UIView(frame : CGRect(x : self.view.bounds.minX + 2, y : self.view.bounds.minY + 2, width : self.view.bounds.width - 4, height : self.view.bounds.height - 4)))
    
    if goal.getDiff() == .DIFFICULT {
      self.view.subviews[0].backgroundColor = Color.DIFFICULTCOLOR
    } else if goal.getDiff() == .MEDIUM {
      self.view.subviews[0].backgroundColor = Color.MEDIUMCOLOR
    } else {
      self.view.subviews[0].backgroundColor = Color.EASYCOLOR
    }
    
    let titleTextView : UITextField = UITextField(frame : CGRect(x : self.view.subviews[0].bounds.minX + 5,
                                                                 y : self.view.subviews[0].bounds.midY - ((self.view.subviews[0].bounds.height - 10) / 2),
                                                                 width : self.view.subviews[0].bounds.width - 25,
                                                                 height : self.view.subviews[0].bounds.height - 10))
    titleTextView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
    titleTextView.text = goal.getGoalTitle()
    titleTextView.isUserInteractionEnabled = false
    
    let pointsTextView : UITextField = UITextField(frame : CGRect(x : self.view.subviews[0].bounds.midX,
                                                                  y : self.view.subviews[0].bounds.midY - ((self.view.subviews[0].bounds.height - 10)/2),
                                                                  width : 30,
                                                                  height : self.view.bounds.height - 10))
    pointsTextView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
    pointsTextView.text = String (goal.getPoints())
    pointsTextView.isUserInteractionEnabled = false
    
    let timerTextView : UITextField = UITextField(frame : CGRect(x : self.view.subviews[0].bounds.width - 75,
                                                                 y : self.view.subviews[0].bounds.midY - ((self.view.subviews[0].bounds.height
                                                                  - 10) / 2),
                                                                 width : 65 ,
                                                                 height : self.view.bounds.height - 10))
    timerTextView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
    timerTextView.text = goal.formatTimer()
    timerTextView.isUserInteractionEnabled = false
    
    
    self.view.addSubview(titleTextView)
    self.view.addSubview(pointsTextView)
    self.view.addSubview(timerTextView)
    
    
    
    //Super
    

    
    self.view.isUserInteractionEnabled = true
    
    print("self.view gesture recognizers: \n")
    print(self.view.gestureRecognizers as Any)
    print("\n")
    //print("textContainer gesture recognizers: ")
    //print(self.textContainer?.gestureRecognizers as Any)
  }
  
  public override func viewDidLoad() {
    print("ViewDidLoad")
    let longPress : UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressAction(sender:)))
    longPress.allowableMovement = 20
    longPress.minimumPressDuration = 0.5
    longPress.numberOfTapsRequired = 0
    longPress.numberOfTouchesRequired = 0
    
    self.view.addGestureRecognizer(longPress)
    print(self.view.gestureRecognizers as Any)
    
    super.viewDidLoad()
  }
  
  
  @objc func longPressAction(sender : UIGestureRecognizer) {
    print("Long Press Recieved")
    
    if let p = sender as? UILongPressGestureRecognizer {
      guard p.state == .began else {
        return
      }
    }
    let popover : GoalPopover = GoalPopover(g: self.goal, source: parentview)
    self.present(popover, animated: true, completion: nil)
  }
  
  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}







