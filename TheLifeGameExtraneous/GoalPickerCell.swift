//
//  GoalPickerCell.swift
//  The Life Game
//
//  Created by Liam Keeley on 8/5/18.
//  Copyright © 2018 Liam Keeley. All rights reserved.
//

import UIKit

public class GoalPickerView : UIViewController {
  var categoryName : String
  var nextNode : UIView?
  var previousNode : UIView?
  
  init(name : String, parent : UIView) {
    categoryName = name
    
    super.init(nibName: nil, bundle: nil)
    if parent.subviews.count > 0 {
      self.view = UIView(frame : CGRect(x: 0.0, y: parent.subviews[parent.subviews.count - 1].frame.maxY + 1, width: parent.frame.width, height: (parent.frame.height / 6)))
    }
    else {
      self.view = UIView(frame : CGRect(x : 0.0, y : 0.0, width : parent.frame.width, height : (parent.frame.height)))
    }
    
    let nameTextField : UILabel = UILabel(frame: CGRect(x: 5, y: self.view.frame.midY + (self.view.frame.height - 10) / 2, width: self.view.frame.width - 5, height: self.view.frame.height - 10))
    
    self.view.addSubview(nameTextField)
    let arrowIcon : UIImageView = UIImageView(image: UserData.resizeImage(image: #imageLiteral(resourceName: "IconTest2"), targetSize: CGSize(width: parent.frame.height - 10, height: parent.frame.height - 10)))
    
    arrowIcon.frame = CGRect(x: parent.frame.width - (parent.frame.height - 10) + 5, y: parent.frame.midY + (arrowIcon.image!.size.height / 2), width: arrowIcon.image!.size.width, height: arrowIcon.image!.size.height)
    self.view.addSubview(arrowIcon)
    
    
  }
  
  func tap(sender : UITapGestureRecognizer) {
    if sender.state == .began {
    
    }
    
    else if sender.state == .ended {
      
    }
  }
}
