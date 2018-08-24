//
//  PointsPickerView.swift
//  The Life Game
//
//  Created by Liam Keeley on 5/29/18.
//  Copyright © 2018 Liam Keeley. All rights reserved.
//

import Foundation
import UIKit

public class PointsPickerView : NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
  private var goal : Goal
  init(goal : Goal) {
    self.goal = goal
    super.init()
  }
  private var difficultyScalar : Int {
    get {
      if self.goal.getDiff() == .EASY {
        return 1
      } else if self.goal.getDiff() == .MEDIUM {
        return 2
      } else {
        return 5
      }
    }
  }
  
  private var lengthScalar : Int {
    get {
      if self.goal.getLength() == .DAILY {
        return 1
      } else if self.goal.getLength() == .WEEKLY {
        return 3
      } else if self.goal.getLength() == .MONTHLY {
        return 6
      } else if self.goal.getLength() == .YEARLY {
        return 20
      } else {
        return 0
      }
    }
  }
  private let possiblePoints : [Int] = [25, 50, 75, 100]
  
  //PickerViewDataSource Protocol
  public func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return possiblePoints.count
  }
  
  //PickerViewDelegate Protocol
  public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
    return UIScreen.main.bounds.height / CGFloat(3) / CGFloat(possiblePoints.count)
  }
  
  public func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
    return UIScreen.main.bounds.width
  }
  
  public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    if row  < possiblePoints.count {
      return String(possiblePoints[row]*difficultyScalar*lengthScalar)
    }
    return nil
  }
  
  public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    goal.setPoints(new : possiblePoints[row]*difficultyScalar*lengthScalar)
  }
}







