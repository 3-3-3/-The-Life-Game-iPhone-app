//
//  GeneralData.swift
//  The Life Game
//
//  Created by Liam Keeley on 8/9/18.
//  Copyright © 2018 Liam Keeley. All rights reserved.
//

import Foundation

public class GeneralData {
  //data to  be used universally across the entire app
  public static var allGoals : [Goal] = []
  public static var pickerHierarchy : [PickerNode] = [
    PickerNode(val: "Mind"),
    PickerNode(val : "Heart"),
    PickerNode(val : "Body")
  ]
  
  public static func fillNodes() {
    //Add sub categories to "Mind"
    pickerHierarchy[0].addNext(picker: PickerNode(val : "Knowledge", prev : pickerHierarchy))
    pickerHierarchy[0].addNext(picker : PickerNode(val : "Wisdom", prev : pickerHierarchy))
    pickerHierarchy[0].addNext(picker : PickerNode(val : "Control", prev : pickerHierarchy))

    
    //Add sub categories to heart
    pickerHierarchy[1].addNext(picker : PickerNode(val: "Love", prev: pickerHierarchy))
    pickerHierarchy[1].addNext(picker : PickerNode(val: "Compassion", prev: pickerHierarchy))
    pickerHierarchy[1].addNext(picker : PickerNode(val: "Creation", prev: pickerHierarchy))
    
    //Add sub categories to body
    pickerHierarchy[2].addNext(picker: PickerNode(val: "Power", prev: pickerHierarchy))
    pickerHierarchy[2].addNext(picker: PickerNode(val : "Grace", prev : pickerHierarchy))
    pickerHierarchy[2].addNext(picker: PickerNode(val : "Grace", prev : pickerHierarchy))
    //do any additional filling here
  }
}
