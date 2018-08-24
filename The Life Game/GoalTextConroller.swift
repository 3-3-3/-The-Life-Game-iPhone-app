//
//  GoalContainer.swift
//  The Life Game
//
//  Created by Liam Keeley on 5/23/18.
//  Copyright © 2018 Liam Keeley. All rights reserved.
//

import Foundation
import UIKit

//Must be a subview
//Should be used in
public class GoalTextController : UIViewController {
  private var goal : Goal
  private var animation : UIViewPropertyAnimator

  init(goal : Goal) {
    self.goal = goal
    self.view = UIView()
    view = goal.addTextContainer(parentview : view.superview!)
    
    self.animation = UIViewPropertyAnimator(duration: 0.5, curve: .linear, animations: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public override func touchesBegan(_ touches : Set<UITouch>, with even : UIEvent!) {
    
    for sub in view.subviews {
      
      
      for subSub in sub.subviews {

      }
    }
  }
  
  public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
  }
  
  public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    window!.rootViewController = GoalEditView(goal : self.goal)
  }
  
  public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
  
  }

  override public func draw(_ size : CGRect) {

  }
}
