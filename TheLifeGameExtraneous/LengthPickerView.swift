//
//  LengthPickerView.swift
//  The Life Game
//
//  Created by Liam Keeley on 5/30/18.
//  Copyright © 2018 Liam Keeley. All rights reserved.
//

import Foundation
import UIKit

public class LengthPickerView : NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
  private var goal : Goal
  private let possibleLengths : [Length] = [.DAILY, .WEEKLY, .MONTHLY, .YEARLY, .STATIC]
  
  init(goal : Goal) {
    self.goal = goal
    super.init()
  }

  //PickerViewDataSource Protocol
  public func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return possibleLengths.count
  }
  
  //PickerViewDelegate Protocol
  public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
    return UIScreen.main.bounds.height / CGFloat(3) / CGFloat(possibleLengths.count)
  }
  
  public func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
    return UIScreen.main.bounds.width
  }
  
  public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    switch (row) {
      case 0 : return "Daily"
      case 1 : return "Weekly"
      case 2 : return "Monthly"
      case 3 : return "Yearly"
      case 4 : return "Static"
      default : return "row"
    }
  }
  
  public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    switch (row) {
      case 0 : goal.setLength(new : possibleLengths[row])
      case 1 : goal.setLength(new : possibleLengths[row])
      case 2 : goal.setLength(new : possibleLengths[row])
      case 3 : goal.setLength(new : possibleLengths[row])
      default : break 
    }
  }
}

