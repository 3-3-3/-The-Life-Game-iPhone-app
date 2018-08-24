//
//  DifficultyPickerView.swift
//  The Life Game
//
//  Created by Liam Keeley on 5/29/18.
//  Copyright © 2018 Liam Keeley. All rights reserved.
//

import Foundation
import UIKit

public class DifficultyPickerView : NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
  private var goal : Goal
  private let possibleDifficulties : [String] = ["Difficult", "Medium", "Easy"]
  
  init(goal : Goal) {
    self.goal = goal
    super.init()
  }
  
   //PickerViewDataSource Protocol
  public func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return possibleDifficulties.count
  }
  
   //PickerViewDelegate Protocol
  public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
    return 30
  }
  
  public func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
    return UIScreen.main.bounds.width
  }
  
  public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
      return possibleDifficulties[row]
  }
  
  public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    switch (row) {
      case 0 :
        goal.setDiff(new : .DIFFICULT)
      case 1 :
        goal.setDiff(new : .MEDIUM)
      case 2 :
        goal.setDiff(new : .EASY)
      default :
        break
    }
  }
}

