//
//  Main.swift
//  The Life Game
//
//  Created by Liam Keeley on 7/20/18.
//  Copyright © 2018 Liam Keeley. All rights reserved.
//

import Foundation
import UIKit

public class Main : UIViewController {
  public static let screenSegment : CGFloat = UIScreen.main.bounds.height / 15
  var mainView : UIView //A view that encompasses the entire main interface
  var lowerBarControl : UIView //A view that encompasses the bottom layout bar; its subviews are buttons that switch between the three main interfaces
  var upperUserInfo : UIView //A view that says some generic things about the user
  var mainInterfaceID : UIView //A view that identifies which of the three interfaces is being used
  var interfaceBackDrop : UIView //The background for the three main interfaces; its subviews are those interfaces

  
  
  //three main interfaces
  var first : UIScrollView
  var second : UIScrollView
  var third : UIScrollView
  
  var firstChart : ANDLineChartView
  var mindChart : ANDLineChartView
  var bodyChart : ANDLineChartView
  var heartChart : ANDLineChartView
  
  var firstChartDataSource : GoalData?
  var mindChartDataSource : GoalData?
  var bodyChartDataSource : GoalData?
  var heartChartDataSource : GoalData?
  
  var charts : [Int : [String : ANDLineChartView]] = [:]
  
  var firstID : UIView
  var secondID : UIView
  var thirdID : UIView
  
  
  
  var eventTimer : Timer? = nil //A timer used across the entire app; when it fires, views should update themselves

  init() {
    mainView = UIView(frame : CGRect(x : 0,
                                     y : 0,
                                     width : UIScreen.main.bounds.width,
                                     height : UIScreen.main.bounds.height))
    
    lowerBarControl = UIView(frame : CGRect(x : 0,
                                            y : UIScreen.main.bounds.height - Main.screenSegment,
                                            width : UIScreen.main.bounds.width,
                                            height : Main.screenSegment))
    lowerBarControl.backgroundColor = Color.BACKGROUND_ONE 
    
    upperUserInfo = UIView(frame : CGRect(x : 0,
                                          y : 0,
                                          width : UIScreen.main.bounds.width,
                                          height : Main.screenSegment*1.5))
    upperUserInfo.backgroundColor = Color.BACKGROUND_TWO
    
    mainInterfaceID = UIView(frame : CGRect(x : 0,
                                            y : upperUserInfo.bounds.maxY,
                                            width : UIScreen.main.bounds.width,
                                            height : Main.screenSegment * 3))
    mainInterfaceID.backgroundColor = Color.BACKGROUND_ONE
    
    
    
    interfaceBackDrop = UIView(frame : CGRect(x : 0,
                                              y : mainInterfaceID.frame.maxY,
                                              width : UIScreen.main.bounds.width,
                                              height : Main.screenSegment * 9.5))
    
    first = UIScrollView(frame : CGRect(x : 0,
                                        y : 0,
                                        width : UIScreen.main.bounds.width,
                                        height : Main.screenSegment * 9.5))
    
    firstChart = ANDLineChartView(frame : CGRect(x : 0,
                                        y : 0,
                                        width : UIScreen.main.bounds.width,
                                        height : Main.screenSegment * 9.5))
    firstChartDataSource = GoalData(data : UserData.pastTotal)
    firstChart.dataSource = firstChartDataSource
    
    
    mindChart = ANDLineChartView(frame : CGRect(x : 0,
                                        y : 0,
                                        width : UIScreen.main.bounds.width,
                                        height : Main.screenSegment * 9.5))
    mindChartDataSource = GoalData(data : UserData.pastMind)
    mindChart.dataSource = mindChartDataSource
    mindChart.backgroundColor = Color.MINDCOLOR
    mindChart.chartBackgroundColor = Color.MINDCOLOR
    
    
    bodyChart = ANDLineChartView(frame : CGRect(x : 0,
                                        y : 0,
                                        width : UIScreen.main.bounds.width,
                                        height : Main.screenSegment * 9.5))
    bodyChartDataSource = GoalData(data : UserData.pastBody)
    bodyChart.dataSource = bodyChartDataSource
    bodyChart.backgroundColor = Color.BODYCOLOR
    bodyChart.chartBackgroundColor = Color.BODYCOLOR
    
    heartChart = ANDLineChartView(frame : CGRect(x : 0,
                                        y : 0,
                                        width : UIScreen.main.bounds.width,
                                        height : Main.screenSegment * 9.5))
    heartChartDataSource = GoalData(data : UserData.pastHeart)
    heartChart.dataSource = heartChartDataSource
    heartChart.backgroundColor = Color.HEARTCOLOR
    heartChart.chartBackgroundColor = Color.HEARTCOLOR
    
    charts[0] = ["Total" : firstChart]
    charts[1] = ["Mind" : mindChart]
    charts[2] = ["Body" : bodyChart]
    charts[3] = ["Heart" : heartChart]
    
    for i in stride(from: 0, to: 3, by : 1) {
      for chart in charts[i]!.values {
        first.addSubview(chart)
      }
    }
    
    heartChart.isHidden = true
    mindChart.isHidden = true
    bodyChart.isHidden = true
    
    firstID = UIView()
    
    second = UIScrollView(frame : CGRect(x : 0,
                                        y : 0,
                                        width : UIScreen.main.bounds.width,
                                        height : Main.screenSegment * 9.5))
    
    second.backgroundColor = Color.BACKGROUND_THREE
    var content : CGFloat = 0.0
    
    for _ in UserData.goals {
      content += second.bounds.height / 6 + 1
    }
    second.contentSize = CGSize(width : second.frame.width, height : content)
    secondID = UIView()
    
    


    third = UIScrollView(frame : CGRect(x : 0,
                                        y : 0,
                                        width : UIScreen.main.bounds.width,
                                        height : Main.screenSegment * 9.5))
    
    
    third.backgroundColor = Color.BACKGROUND_THREE
    thirdID = UIView()

    interfaceBackDrop.addSubview(first)
    interfaceBackDrop.addSubview(second)
    interfaceBackDrop.addSubview(third)

    super.init(nibName: nil, bundle: nil)
    //SUPERCALL; do setup here that needs to be done after Super.init
    //Populate third with category pickers
    GeneralData.fillNodes()
    print(GeneralData.pickerHierarchy[0].getNextNodes()[0].getValue())
    for cat in GeneralData.pickerHierarchy {
      switch cat.getValue() {
        case "Heart" :
          third.addSubview(cat.pickButton(parent: third, color : Color.HEARTCOLOR))
        case "Mind" :
          third.addSubview(cat.pickButton(parent : third, color : Color.MINDCOLOR))
        case "Body" :
          third.addSubview(cat.pickButton(parent : third, color : Color.BODYCOLOR))
        default :
          third.addSubview(cat.pickButton(parent : third, color : Color.BACKGROUND_FOUR))
      }
    }
  
  
    eventTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
    
    //Populate second with the users goals
    UserData.goals = sortByType(UserData.goals)
    for goal in UserData.goals {
      let goalContainer : GoalTextContainer = GoalTextContainer(parentview: second, goal: goal)
      print("GoalTextContainer has been initialized")
      
      second.addSubview(goalContainer.view)
      print("GoalTextContainer added to second")
      print(goalContainer.isViewLoaded)
    }
    
    let lowerBarControlButtonOne : UIView = MainInterfaceControllerButton(interfaceID : 1, m : self, xPos : 0, icon : #imageLiteral(resourceName: "chart-icon"), parent : lowerBarControl).view!
    lowerBarControl.addSubview(lowerBarControlButtonOne)
    
    let lowerBarControlButtonTwo : UIView = MainInterfaceControllerButton(interfaceID : 2, m : self, xPos : lowerBarControlButtonOne.frame.maxX, icon : #imageLiteral(resourceName: "Image-1"), parent : lowerBarControl).view!
    lowerBarControl.addSubview(lowerBarControlButtonTwo)
    
    let lowerBarControlButtonThree : UIView = MainInterfaceControllerButton(interfaceID : 3, m : self, xPos : lowerBarControlButtonTwo.frame.maxX, icon : #imageLiteral(resourceName: "IconTest"), parent :  lowerBarControl).view!
    lowerBarControl.addSubview(lowerBarControlButtonThree)
    
    self.firstID = UIView(frame : self.mainInterfaceID.bounds)
    self.secondID = UIView(frame : self.mainInterfaceID.bounds)
    self.thirdID = UIView(frame : self.mainInterfaceID.bounds)
    
    let leftArrow = UIImageView(image : #imageLiteral(resourceName: "LeftArrow"))
    //Image : https://www.flaticon.com/packs/free-basic-ui-elements
    leftArrow.translatesAutoresizingMaskIntoConstraints = false
    leftArrow.isUserInteractionEnabled = true
    let leftTap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(leftArrow(sender:)))
    leftArrow.addGestureRecognizer(leftTap)
    
    let rightArrow = UIImageView(image : #imageLiteral(resourceName: "RightArrow"))
    //Image : https://www.flaticon.com/packs/free-basic-ui-elements
    rightArrow.translatesAutoresizingMaskIntoConstraints = false
    rightArrow.isUserInteractionEnabled = true
    let rightTap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(rightArrow(sender:)))
    rightArrow.addGestureRecognizer(rightTap)
    
    let chartTitle = UILabel()
    chartTitle.translatesAutoresizingMaskIntoConstraints = false
    chartTitle.textAlignment = .center
    chartTitle.font = UIFont(name : chartTitle.font.fontName, size : 50)
    chartTitle.text = "Total"
    
    firstID.addSubview(chartTitle)
    firstID.addSubview(leftArrow)
    firstID.addSubview(rightArrow)
  
    let views = [
      "firstID" : firstID,
      "leftArrow" : leftArrow,
      "rightArrow" : rightArrow,
      "chartTitle" : chartTitle
    ]
    
    
    //only call on views with a superview
    /*func centerFromTop(_ view : UIView) -> CGFloat {
      return ((view.superview!.bounds.height / 2.0) - (view.frame.width / 2.0))
    }*/
    
    let arrowButtonScalar : CGFloat = 60.0
    let hFormatString = "H:|-10-[leftArrow(\(arrowButtonScalar))]-[chartTitle]-[rightArrow(==leftArrow)]-10-|"
    let vLeftString = "V:|-\(((self.mainInterfaceID.bounds.height / 2.0) - (arrowButtonScalar / 2)))-[leftArrow(\(arrowButtonScalar))]"
    let vRightString = "V:[rightArrow(\(arrowButtonScalar))]"
    let vChartString = "V:[chartTitle(\(arrowButtonScalar))]"
    let vLeftConstraint = NSLayoutConstraint.constraints(withVisualFormat: vLeftString, options: .alignAllLeading, metrics: nil, views: views)
    let vRightConstraint = NSLayoutConstraint.constraints(withVisualFormat: vRightString, options: .alignAllLeading, metrics: nil, views: views)
    let vChartConstraint = NSLayoutConstraint.constraints(withVisualFormat: vChartString, options: .alignAllLeading, metrics: nil, views: views)
    let hConstraints = NSLayoutConstraint.constraints(withVisualFormat: hFormatString, options: .alignAllCenterY, metrics: nil, views: views)
    NSLayoutConstraint.activate(hConstraints)
    NSLayoutConstraint.activate(vLeftConstraint)
    NSLayoutConstraint.activate(vRightConstraint)
    NSLayoutConstraint.activate(vChartConstraint)
    
    
    
    mainInterfaceID.addSubview(firstID)
    mainInterfaceID.addSubview(secondID)
    mainInterfaceID.addSubview(thirdID)
    thirdID.isHidden = true
    secondID.isHidden = true
    
    
    
    
    
    
    
    
    
    mainView.addSubview(upperUserInfo)
    mainView.addSubview(mainInterfaceID)
    mainView.addSubview(interfaceBackDrop)
    mainView.addSubview(lowerBarControl)

    interfaceBackDrop.subviews[1].isHidden = false
    interfaceBackDrop.subviews[0].isHidden = true
    interfaceBackDrop.subviews[2].isHidden = true
    
    //a swipe gesture recognizer that should update the main interfaces in a similar fashion as the mian interface buttons created above
    let swiper : UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(changeMainInterfaceSwipe(sender:)))
    first.addGestureRecognizer(swiper)
    second.addGestureRecognizer(swiper)
    third.addGestureRecognizer(swiper)
  }

  
  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  @objc func pickTapper(sender : UITapGestureRecognizer) {
    for view in third.subviews {
      view.removeFromSuperview()
    }
  }
  
  //selector function (can be used by objective-c methods when wrapped in a selector) to be use by the main timer to update views; put code here and call functions for anything that needs to be updated
  @objc func timerFired() -> String {
    //print("goal text container not initialized")
    return "Fired"
  }
  
  public override func loadView() {
    self.view = mainView
  }
  
  @objc func leftArrow(sender : UITapGestureRecognizer) {
    print("left tap")
    for i in stride(from: 0, to: self.charts.count, by: 1) {
      for chart in charts[i]!.values {
        if chart.isHidden == false {
          chart.isHidden = true
          print("chart \(i) is visible \n")
          //If it is not the first chart
          if i != 0 {
            for c in charts[i-1]!.values {
              c.isHidden = false
            }
            
            if let t = firstID.subviews[0] as? UILabel {
              for title in charts[i-1]!.keys {
                t.text = title
              }
            }
            return
          }
          else {
            for c in charts[charts.count-1]!.values {
              print("heart chart should be visible form left tap")
              c.isHidden = false
            }
            
            if let t = firstID.subviews[0] as? UILabel {
              for title in charts[charts.count-1]!.keys {
                t.text = title
              }
            }
            return
          }
        }
      }
    }
  }
  
  @objc func rightArrow(sender : UITapGestureRecognizer) {
    for i in stride(from: 0, to: self.charts.count, by: 1) {
      for chart in charts[i]!.values {
        if chart.isHidden == false {
          if i <=  (charts.count-2) { //any case but the last
            chart.isHidden = true
            for c in charts[i+1]!.values {
              c.isHidden = false
              print("\(i), \(i+1) is hidden: \(c.isHidden)")
            }
            
            if let t = firstID.subviews[0] as? UILabel {
              for title in charts[i+1]!.keys {
                t.text = title
              }
            }
            return
          }else{
            for c in charts[0]!.values {
              c.isHidden = false
              for c in charts[0]!.values {
                c.isHidden = false
              }
              if let t = firstID.subviews[0] as? UILabel {
                for title in charts[0]!.keys {
                  t.text = title
                }
              }
            }
            return
          }
        }
      }
    }
  }
  
  //Selector functions to update
  @objc public func changeMainInterfaceToSecond(sender : UITapGestureRecognizer) {
    print("changed to second")
    interfaceBackDrop.subviews[1].isHidden = false
    interfaceBackDrop.subviews[0].isHidden = true
    interfaceBackDrop.subviews[2].isHidden = true
  }
  
  @objc public func changeMainInterfaceToThird() {
    print("changed to third")
    interfaceBackDrop.subviews[0].isHidden = true
    interfaceBackDrop.subviews[1].isHidden = true
    interfaceBackDrop.subviews[2].isHidden = false
  }
  
  @objc public func changeMainInterfaceToFirst() {
    print("changed to first")
    interfaceBackDrop.subviews[1].isHidden = true
    interfaceBackDrop.subviews[0].isHidden = false
    interfaceBackDrop.subviews[2].isHidden = true
  }
  
  @objc public func changeMainInterfaceSwipe(sender : UIGestureRecognizer) {
    print("swiped")
    if let swipeGesture = sender as? UISwipeGestureRecognizer {
      print("downcast from gesture to swipegesture successful")
      print(swipeGesture.direction)
      if swipeGesture.direction == UISwipeGestureRecognizerDirection.right {
        for i in stride(from: 1, to: interfaceBackDrop.subviews.count - 1, by: 1) {
          if interfaceBackDrop.subviews[i].isHidden == false {
            interfaceBackDrop.subviews[i].isHidden = true
            interfaceBackDrop.subviews[i - 1].isHidden = false
          }
        }
      }
      
    
      else if swipeGesture.direction == UISwipeGestureRecognizerDirection.left {
        print("right")
        for i in stride(from: 0, to: interfaceBackDrop.subviews.count - 2, by: 1) {
          if interfaceBackDrop.subviews[i].isHidden == false {
            interfaceBackDrop.subviews[i].isHidden = true
            interfaceBackDrop.subviews[i + 1].isHidden = false
          }
        }
      }
    }
  }
  
  /*A sort function that should theoretically sort an array of goals by two criteria
      *switch the first criteria, and create neceasary arrays for the passed criteria.
      *Iterate over goalsArray, and then switch its possible outcomes (i.e. .BODY for Type)
      *call a sort function on each of those filled arrays for the secondCriteria (insertion sort)
      *return
  */
  func sortBy(_ goalsArray : [Goal], firstCriteria : String = "Type", secondCriteria : String = "Length") -> [Goal] {
    var returnArray : [Goal] = goalsArray
    
    switch firstCriteria {
      case "Length" :
        var stat : [Goal] = []
        var daily : [Goal] = []
        var weekly : [Goal] = []
        var monthly : [Goal] = []
        var yearly : [Goal] = []
      
        for goal in returnArray {
          switch goal.getLength() {
            case .STATIC :
              stat.append(goal)
            case .DAILY :
              daily.append(goal)
            case .WEEKLY :
              weekly.append(goal)
            case .MONTHLY :
              monthly.append(goal)
            case .YEARLY :
              yearly.append(goal)
          }
        }
      
        switch secondCriteria {
          case "Points" :
            stat = sortByPoints(stat)
            daily = sortByPoints(daily)
            weekly = sortByPoints(weekly)
            monthly = sortByPoints(monthly)
            yearly = sortByPoints(yearly)
          case "Title" :
            stat = sortByTitle(stat)
            daily = sortByTitle(daily)
            weekly = sortByTitle(weekly)
            monthly = sortByTitle(monthly)
            yearly = sortByTitle(yearly)
          default :
            stat = sortByType(stat)
            daily = sortByType(daily)
            weekly = sortByType(weekly)
            monthly = sortByType(monthly)
            yearly = sortByType(yearly)
        }
      
        for g in stat {
          returnArray.append(g)
        }
    
        for g in daily {
          returnArray.append(g)
        }
    
        for g in weekly {
          returnArray.append(g)
        }
    
        for g in monthly {
          returnArray.append(g)
        }
    
        for g in yearly {
          returnArray.append(g)
        }
      case "Points" :
        var twentyFives : [Goal] = []
        var fifties : [Goal] = []
        var seventyFives : [Goal] = []
        var oneHundreds : [Goal] = []
      
        for goal in returnArray {
          switch goal.getPoints() {
            case 25 :
              twentyFives.append(goal)
            case 50 :
              fifties.append(goal)
            case 75 :
              seventyFives.append(goal)
            case 100 :
              oneHundreds.append(goal)
            default :
              fatalError("Impossible points for goal")
          }
          
          switch secondCriteria {
            case "Length" :
              twentyFives = sortByLength(twentyFives)
              fifties = sortByLength(fifties)
              seventyFives = sortByLength(seventyFives)
              oneHundreds = sortByLength(oneHundreds)
            case "Title" :
              twentyFives = sortByTitle(twentyFives)
              fifties = sortByTitle(fifties)
              seventyFives = sortByTitle(seventyFives)
              oneHundreds = sortByTitle(oneHundreds)
            default :
              twentyFives = sortByType(twentyFives)
              fifties = sortByType(fifties)
              seventyFives = sortByType(seventyFives)
              oneHundreds = sortByType(oneHundreds)
          }
          for g in oneHundreds {
            returnArray.append(g)
          }
          
          for g in seventyFives {
            returnArray.append(g)
          }
          
          for g in fifties {
            returnArray.append(g)
          }

          for g in twentyFives {
            returnArray.append(g)
          }
      }
      case "Title" : //no secondary sort; alphabetical
        returnArray = sortByTitle(returnArray)
      
      default :
        var mind : [Goal] = []
        var body : [Goal] = []
        var heart : [Goal] = []
      
        for goal in returnArray {
          if goal.getDiff() == .MIND {
            mind.append(goal)
          }
          else if goal.getDiff() == .BODY {
            body.append(goal)
          }
          else {
            heart.append(goal)
          }
        }
      
        switch secondCriteria {
          case "Points" :
            mind = sortByPoints(mind)
            body = sortByPoints(body)
            heart = sortByPoints(heart)
          case "Title" :
            mind = sortByTitle(mind)
            body = sortByTitle(body)
            heart = sortByTitle(heart)
          default :
            mind = sortByLength(mind)
            body = sortByLength(body)
            heart = sortByLength(heart)
        }
        for g in mind {
          returnArray.append(g)
        }
        for g in body {
          returnArray.append(g)
        }
        for g in heart {
          returnArray.append(g)
        }
    }
    return returnArray
  }
  /*
  Sort functions by (Insertion sort) (O(n^2) Algorithm):
    *Type
    *Length
    *Points
    *Title
  */
  func sortByType(_ goalsArray : [Goal]) -> [Goal] {
    var returnArray : [Goal] = goalsArray
    //iterate the contents of the array besides the first
    for num in 1 ... returnArray.count - 1 {
      //save the goal for the current iteration
      let next : Goal = returnArray[num]
      
      var i : Int = num
      //Find the place to insert the value in the first n values; Shift the values to the right
      while i > 0 && next.getDiff().hashValue < returnArray[i-1].getDiff().hashValue {
        returnArray[i] = returnArray[i - 1]
        i = i - 1
      }
      //set the position for the current iteration to the value
      returnArray[i] = next
    }
    return returnArray
  }
  
  func sortByLength(_ goalsArray : [Goal]) -> [Goal] {
    var returnArray : [Goal] = goalsArray
    for num in 1 ... returnArray.count - 1 {
      let next : Goal = returnArray[num]
      
      var i : Int = num
      while i > 0 && next.getLength().hashValue < returnArray[i-1].getLength().hashValue {
        returnArray[i] = returnArray[i - 1]
        i = i - 1
      }
      returnArray[i] = next
    }
    return returnArray
  }
  
  func sortByPoints(_ goalsArray : [Goal]) -> [Goal] {
    var returnArray : [Goal] = goalsArray
    for num in 1 ... returnArray.count - 1 {
      let next : Goal = returnArray[num]
      
      var i : Int = num
      while i > 0 && next.getPoints() < returnArray[i-1].getPoints() {
        returnArray[i] = returnArray[i - 1]
        i = i - 1
      }
      returnArray[i] = next
    }
    return returnArray
  }
  
  func sortByTitle(_ goalsArray : [Goal]) -> [Goal] {
    var returnArray : [Goal] = goalsArray
    for num in 1 ... returnArray.count - 1 {
      let next : Goal = returnArray[num]
      
      var i : Int = num
      while i > 0 && next.getGoalTitle().hashValue < returnArray[i-1].getGoalTitle().hashValue {
        returnArray[i] = returnArray[i - 1]
        i = i - 1
      }
      returnArray[i] = next
    }
    return returnArray
  }
}

