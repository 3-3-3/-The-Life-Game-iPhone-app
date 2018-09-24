//
//  GoalData.swift
//  The Life Game
//
//  Created by Liam Keeley on 9/13/18.
//  Copyright © 2018 Liam Keeley. All rights reserved.
//

import Foundation

@objc public class GoalData : NSObject, ANDLineChartViewDataSource {
  private var data : [Day] //A structure with a date and a point value
  
  override init() {
    data = []
    
    super.init()
  }
  
  init(data : [Day]) {
    self.data = data
    
    super.init()
  }
  
  init(day : Day) {
    data = []
    data.append(day)
    
    super.init()
  }
  
  public func getData() -> [Day] {
    return data
  }
  
  public func addDay(day : Day) -> [Day] {
    self.data.append(day)
    return self.data
  }
  
  public func numberOfElements(in chartView: ANDLineChartView!) -> UInt {
    return UInt (data.count)
  }
  
  public override func responds(to aSelector: Selector!) -> Bool {
    if aSelector == #selector(numberOfElements(in:)) ||
       aSelector == #selector(numberOfGridIntervals(in:)) ||
       aSelector == #selector(chartView(_:valueForElementAtRow:)) ||
       aSelector == #selector(chartView(_:descriptionForGridIntervalValue:)) ||
       aSelector == #selector(maxValueForGridInterval(in:)) ||
       aSelector == #selector(minValueForGridInterval(in:)) {
         return true
     } else {
         return super.responds(to: aSelector)
    }
  }
  
  public func numberOfGridIntervals(in chartView: ANDLineChartView!) -> UInt {
    return UInt (16)
  }
  
  public func chartView(_ chartView: ANDLineChartView!, valueForElementAtRow row: UInt) -> CGFloat {
    return  CGFloat (self.data[Int (row)].points)
  }
  
  public func chartView(_ chartView: ANDLineChartView!, descriptionForGridIntervalValue interval: CGFloat) -> String! {
    /*if interval != 0.0 {
      let intervalValue = (CGFloat (max()) / (15 - interval)).rounded()
      return String(Int (intervalValue))
    }else{
      return "0"
    }*/
    return String (Int (interval))
  }
  
  func max() -> Int {
    var max : Int = 0
    
    for day in self.data {
      if day.points > max  {
        max = day.points
      }
    }
    
    return max
  }
  
  public func maxValueForGridInterval(in chartView: ANDLineChartView!) -> CGFloat {
    return CGFloat (self.max())
  }
  
  public func minValueForGridInterval(in chartView: ANDLineChartView!) -> CGFloat {
    /*var min : Int = Int.max
    
    for day in self.data {
      if day.points < min {
        min = day.points
      }
    }*/
    
    return 0
  }
}
