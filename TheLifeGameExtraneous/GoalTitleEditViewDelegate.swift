//
//
//  Created by Liam Keeley on 5/30/18.
//  Copyright © 2018 Liam Keeley. All rights reserved.
//

import Foundation
import UIKit

public class GoalTitleEditViewDelegate : NSObject, UITextFieldDelegate {
  private var goal : Goal
  
  init(goal : Goal) {
    self.goal = goal
    super.init()
  }
   //UITextFieldDelegate Protocol
   public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
     if textField.text != nil {
       return true
    }
    return false
   }
  
  public func textFieldDidEndEditing(_ textField : UITextField, reason : UITextFieldDidEndEditingReason) {
    if reason == .committed {
      goal.setGoalTitle(new: textField.text!)
    } else {
      textField.text = nil
    }
  }
}
