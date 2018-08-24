//
//  GoalEditView.swift
//  The Life Game
//
//  Created by Liam Keeley on 5/25/18.
//  Copyright © 2018 Liam Keeley. All rights reserved.
//

import Foundation
import UIKit

public class GoalEditView : UIViewController {
  private var containerView : UIView
  
  //labels
  private var goalTitle : UILabel
  private var goalDescription : UILabel
  private var goalPoints : UILabel
  private var difficulty : UILabel
  private var length : UILabel
  
  //Controls
  private var goalTitleInput : UITextField
  private var goalDescriptionInput : UITextField
  
  private var goalPointsInput : UIPickerView
  private var goalPointsField : UITextField
  
  private var difficultyInput : UIPickerView
  private var difficultyField : UITextField
  
  private var lengthInput : UIPickerView
  private var lengthField : UITextField
  
  private var topBorder : UIView
  
  //private var delete : UIButton
  //private var back : UIButton
  
  private var goal : Goal
  
  private var dividerOne : UIView
  //private var dividerTwo : UIView
  //private var dividerThree : UIView
  
  init(goal : Goal) {
    self.goal = goal
    
    
    //Style
    containerView = UIView(frame: CGRect(x : 0, y : 0, width : UIScreen.main.bounds.width, height : UIScreen.main.bounds.height))
    if goal.getDiff() == Difficulty.DIFFICULT {
      containerView.backgroundColor = Color.DIFFICULTCOLOR
    } else if goal.getDiff() == Difficulty.MEDIUM {
      containerView.backgroundColor = Color.MEDIUMCOLOR
    } else {
      containerView.backgroundColor = Color.EASYCOLOR
    }
    
    topBorder = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/12))
    topBorder.backgroundColor = UIColor(red: 0.8275, green: 0.8275, blue: 0.8275, alpha: 1.0)
    containerView.addSubview(topBorder)
    
    dividerOne = UIView(frame : CGRect(x : 0, y : 1.5*(20+UIScreen.main.bounds.height-220)/5, width : UIScreen.main.bounds.width, height : 1))
    dividerOne.backgroundColor =  UIColor(red: 0.8275, green: 0.8275, blue: 0.8275, alpha: 1.0)
    containerView.addSubview(dividerOne)
    
    //goalTitle
    goalTitle = UILabel(frame : CGRect(x : 5, y : (20 + UIScreen.main.bounds.height-220)/5, width : 80, height : 25))
    goalTitle.backgroundColor = UIColor(red : 0.0, green : 0.0, blue : 0.0, alpha : 0.0)
    goalTitle.textColor = UIColor(red: 0.1294, green: 0.1961, blue: 0.2196, alpha: 1.0)
    goalTitle.adjustsFontSizeToFitWidth = true
    goalTitle.text = "Title: "
    containerView.addSubview(goalTitle)
    
    
    goalTitleInput = UITextField(frame: CGRect(x : 85, y : (20 + UIScreen.main.bounds.height-220)/5, width : UIScreen.main.bounds.width-5-85, height : 25)) //Comes directrly after goalTitle; goes until 5 pixels from the end of the screen
    goalTitleInput.textColor = UIColor(red : 1.0, green : 1.0, blue : 1.0, alpha : 1.0)
    goalTitleInput.borderStyle = .roundedRect
    goalTitleInput.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
    goalTitleInput.placeholder = goal.getGoalTitle()
    goalTitleInput.delegate = GoalTitleEditViewDelegate(goal : goal)
    containerView.addSubview(goalTitleInput)
    
    //goal description
    goalDescription = UILabel(frame : CGRect(x : 5, y : (2 * (20 + UIScreen.main.bounds.height - 220))/5, width : 80, height : 25))
    goalDescription.backgroundColor = UIColor(red : 0.0, green : 0.0, blue : 0.0, alpha : 0.0)
    goalDescription.textColor = UIColor(red: 0.1294, green: 0.1961, blue: 0.2196, alpha: 1.0)
    goalDescription.adjustsFontSizeToFitWidth = true
    goalDescription.text = "Description: "
    containerView.addSubview(goalDescription)
    
    goalDescriptionInput = UITextField(frame : CGRect(x : 85, y : (2 * (20 + UIScreen.main.bounds.height - 220))/5, width : UIScreen.main.bounds.width - 5 - 85, height : 25))
    goalDescriptionInput.textColor = UIColor(red : 1.0, green : 1.0, blue : 1.0, alpha : 1.0)
    goalDescriptionInput.borderStyle = .roundedRect
    goalDescriptionInput.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
    goalDescriptionInput.placeholder = goal.getGoalTitle()
    goalDescriptionInput.delegate = GoalDescriptionEditViewDelegate(goal : goal)
    containerView.addSubview(goalDescriptionInput)
    
    
    goalPoints = UILabel(frame : CGRect(x : 5, y : (3 * (20 + UIScreen.main.bounds.height - 220))/5, width : 80, height : 25))
    goalPoints.backgroundColor = UIColor(red : 0.0, green : 0.0, blue : 0.0, alpha : 0.0)
    goalPoints.textColor = UIColor(red: 0.1294, green: 0.1961, blue: 0.2196, alpha: 1.0)
    goalPoints.adjustsFontSizeToFitWidth = true
    goalPoints.text = "Points: "
    containerView.addSubview(goalPoints)
    
    goalPointsInput = UIPickerView(frame : CGRect(x : 0, y : UIScreen.main.bounds.height/3, width : UIScreen.main.bounds.width, height : UIScreen.main.bounds.height/3))
    goalPointsInput.dataSource = PointsPickerView(goal : goal)
    goalPointsInput.delegate = PointsPickerView(goal : goal)
    goalPointsInput.showsSelectionIndicator = true
    
    goalPointsField = UITextField(frame : CGRect(x : 85, y : (3 * (20 + UIScreen.main.bounds.height - 220)/5), width : UIScreen.main.bounds.width - 5 - 85, height : 25))
    goalPointsField.borderStyle = .roundedRect
    goalPointsField.inputView = goalPointsInput
    containerView.addSubview(goalPointsField)
    
    difficulty = UILabel(frame : CGRect(x : 5, y : 4 * (20 + UIScreen.main.bounds.height - 220)/5, width : 80, height : 25))
    difficulty.backgroundColor = UIColor(red : 0.0, green : 0.0, blue : 0.0, alpha : 0.0)
    difficulty.textColor = UIColor(red: 0.1294, green: 0.1961, blue: 0.2196, alpha: 1.0)
    difficulty.adjustsFontSizeToFitWidth = true
    difficulty.text = "Difficulty: "
    containerView.addSubview(difficulty)
    
    difficultyInput = UIPickerView(frame : CGRect(x : 0, y : UIScreen.main.bounds.height/3, width : UIScreen.main.bounds.width, height : UIScreen.main.bounds.height/3))
    let difficultyDelegateData = DifficultyPickerView(goal : goal)
    difficultyInput.delegate = difficultyDelegateData
    difficultyInput.dataSource = difficultyDelegateData
    difficultyInput.showsSelectionIndicator = true
    
    difficultyField = UITextField(frame : CGRect(x : 85, y : 4 * (20 + UIScreen.main.bounds.height - 220)/5, width : UIScreen.main.bounds.width - 5 - 85, height : 25))
    difficultyField.borderStyle = .roundedRect
    difficultyField.inputView = difficultyInput
    containerView.addSubview(difficultyField)
    
    length = UILabel(frame : CGRect(x : 5, y : (20 + UIScreen.main.bounds.height - 220), width : 80, height : 25))
    length.backgroundColor = UIColor(red : 0.0, green : 0.0, blue : 0.0, alpha : 0.0)
    length.textColor = UIColor(red: 0.1294, green: 0.1961, blue: 0.2196, alpha: 1.0)
    length.adjustsFontSizeToFitWidth = true
    length.text = "Length: "
    containerView.addSubview(length)
    
    lengthInput = UIPickerView(frame : CGRect(x : 0, y : UIScreen.main.bounds.height/3, width : UIScreen.main.bounds.width, height : UIScreen.main.bounds.height/3))
    lengthInput.backgroundColor = UIColor(red: 0.8275, green: 0.8275, blue: 0.8275, alpha: 1.0)
    lengthInput.delegate = LengthPickerView(goal : goal)
    lengthInput.dataSource = LengthPickerView(goal : goal)
    lengthInput.showsSelectionIndicator = true
    
    lengthField = UITextField(frame : CGRect(x : 85, y : 20 + UIScreen.main.bounds.height - 220, width : UIScreen.main.bounds.width - 85 - 5, height : 25))
    lengthField.inputView = lengthInput
    lengthField.borderStyle = .roundedRect
    containerView.addSubview(lengthField)
    
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public override func loadView() {
    self.view = containerView
  }
  
  public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    for touch in touches {
      if touch.view! == self.view {
        print("success")
        self.view.endEditing(false)
      }
    }
    super.touchesEnded(touches, with: event)
  }
}

