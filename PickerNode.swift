//
//  File.swift
//  The Life Game
//
//  Created by Liam Keeley on 8/15/18.
//  Copyright © 2018 Liam Keeley. All rights reserved.
//

import UIKit

public class PickerNode {
  private var value : String
  private var prevNodes : [PickerNode]?
  private var nextNodes : [PickerNode] = []
  private var quote : String?
  private var color : UIColor!
  
  init(val : String) {
    value = val
  }
  
  init(val : String, quote : String) {
    value = val
    self.quote = quote
  }
  
  init(val : String, prev : [PickerNode]?) {
    value = val
    prevNodes = prev
  }
  
  
  public func addNext(picker : PickerNode) {
    self.nextNodes.append(picker)
  }
  
  public func addNext(val : String, prev : [PickerNode]? = nil) {
    if self.prevNodes != nil {
      self.nextNodes.append(PickerNode(val : val, prev : self.prevNodes![0].nextNodes))
    }
    else {
      self.nextNodes.append(PickerNode(val : val, prev : prev))
    }
    
    for picker in self.nextNodes {
      print("node")
      print(picker.getValue())
    }
  }
  
  //getters/setters
  public func getNextNodes() -> [PickerNode] {
    return nextNodes
  }
  
  public func getPrevNodes() -> [PickerNode]? {
    return prevNodes
  }
  
  public func getQuote() -> String? {
    return quote
  }
  
  public func setQuote(new : String) {
    self.quote = new
  }
  
  public func getValue() -> String {
    return self.value
  }
  
  public func getColor() -> UIColor! {
    return self.color
  }

  
  //A button used by third to display categories as dictated by GeneralData.allCategories
  public func pickButton(parent : UIView, color : UIColor) -> UIView {
    self.color = color
    var selector : PickerButton
    if parent.subviews.count > 0 {
      selector = PickerButton(frame: CGRect(x: 0, y: parent.subviews[parent.subviews.count - 1].frame.maxY + 2, width: parent.frame.width, height: parent.frame.height / 3), n : self)
    }
    else {
      selector = PickerButton(frame: CGRect(x: 0, y: 0, width: parent.frame.width, height: parent.frame.height / 3), n : self)
    }
    
    let description : UILabel = UILabel(frame: CGRect(x : 0, y : 0, width : selector.frame.width, height : selector.frame.height / 3))
    description.text = self.value
    description.isUserInteractionEnabled = false
    
    let quoteLabel : UILabel = UILabel(frame : CGRect(x : selector.frame.width / 12, y : description.frame.maxY, width : selector.frame.width - (selector.frame.width / 6), height : 2*selector.frame.height / 3))
    quoteLabel.font = UIFont(name: "HelveticaNeue-Italic", size: 15.0)
    quoteLabel.textAlignment = .justified
    quoteLabel.numberOfLines = 0
    quoteLabel.text = self.quote

    selector.addSubview(description)
    selector.addSubview(quoteLabel)
    
    selector.backgroundColor = self.color
    let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: selector, action: #selector(selector.tapped(sender:)))
    selector.addGestureRecognizer(tap)
    let rightSwipe : UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: selector, action: #selector(selector.rightSwipe(sender:)))
    selector.addGestureRecognizer(rightSwipe)
    return selector
  }
}

public class GoalNode : PickerNode {
  private var goal : Goal
  
  init(goal : Goal) {
    self.goal = goal
    super.init(val : goal.getGoalTitle())
  }
  
  public override func pickButton(parent: UIView, color: UIColor = Color.BACKGROUND_FOUR) -> UIView {
    var selector : UIView = self.goal.addTextContainer(parentview: parent)
    if selector.gestureRecognizers != nil {
      for gesture in selector.gestureRecognizers! {
        selector.removeGestureRecognizer(gesture)
      }
    }
    
    //add gesture recognizers to selector so that it can
    
    return selector
  }
}

public class PickerButton : UIView {
  var node : PickerNode
  
  init(frame : CGRect, n : PickerNode) {
    node = n
    super.init(frame : frame)
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  @objc func tapped(sender : UITapGestureRecognizer) {
    if sender.state == .began {
      print("touches began")
    }
    
    print("sender tapped")
    let parent : UIView? = sender.view!.superview
    for view in parent!.subviews {
      print("View removed")
      view.removeFromSuperview()
    }
    
    if let p = sender.view! as? PickerButton {
      print("downcast from view to PickerButton successful")
      for node in p.node.getNextNodes() {
        print("will add pickerButton")
        parent!.addSubview(node.pickButton(parent: parent!, color : (self.backgroundColor)!))
      }
    }
  }
  
  @objc func rightSwipe(sender : UISwipeGestureRecognizer) {
    if sender.direction == .right {
      if let picker = sender.view! as? PickerButton {
        let parent : UIView? = picker.superview
        for view in picker.superview!.subviews {
          view.removeFromSuperview()
        }
        
        if picker.node.getPrevNodes() != nil {
          for node in picker.node.getPrevNodes()! {
            parent?.addSubview(node.pickButton(parent: parent!, color: node.getColor()))
          }
        }
      }
    }
  }
}
