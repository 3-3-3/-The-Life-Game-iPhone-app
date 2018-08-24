//
//  DifficultyPickerView.swift
//  TheLifeGameTestOne
//
//  Created by Liam Keeley on 6/10/18.
//  Copyright © 2018 Liam Keeley. All rights reserved.
//

import Foundation
import UIKit

public class DifficultyPickerView : NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
  public func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return 3
  }
  
  public func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
    return UIScreen.main.bounds.width
  }
  
  public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
    return 50
  }
  
  public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    var returnValue : String
    switch (row) {
      case 0 : returnValue = "first"
      case 1 : returnValue = "Secone"
      case 2 : returnValue = "Third"
      default : returnValue = "fdklads;"
    }
    return returnValue
  }
}
