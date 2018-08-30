//
//  GoalPopover.swift
//  The Life Game
//
//  Created by Liam Keeley on 8/24/18.
//  Copyright © 2018 Liam Keeley. All rights reserved.
//

import UIKit

public class GoalPopover : UIViewController {
  private var goal : Goal
  
  public init(g : Goal, source : UIView) { 
    self.goal = g
    
    //Super
    super.init(nibName: nil, bundle: nil)
    self.modalPresentationStyle = .popover
    self.popoverPresentationController!.sourceView = source
    self.popoverPresentationController!.backgroundColor = self.popoverPresentationController!.sourceView!.backgroundColor
    self.popoverPresentationController!.sourceView = source
    
    let description : UILabel = UILabel(frame: CGRect(x: 2, y: self.view.frame.midY + (self.view.frame.height / 3) / 2, width: self.view.frame.width - 2, height: self.view.frame.height / 3))
    description.text = self.goal.getGoal()
    self.view.addSubview(description)
  }
  
  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
