//
//  BottomLayoutButton.swift
//  The Life Game
//
//  Created by Liam Keeley on 7/24/18.
//  Copyright © 2018 Liam Keeley. All rights reserved.
//

import Foundation
import UIKit

public class MainInterfaceControllerButton : UIViewController {
  var interfaceID : Int //which of the three interfaces it is connected to
  var mainInterface : Main //Main
  var xPosition : CGFloat //its xPosition in lowerLayoutBar's coordinate plain
  var icon : UIImage //the icon to be used for this button
  var tap : UITapGestureRecognizer //tapper; called on touch
  
  init(interfaceID : Int, m : Main, xPos : CGFloat, icon : UIImage, parent : UIView) {
    mainInterface = m
    self.icon = icon
    xPosition = xPos
    self.interfaceID = interfaceID
  
    
    switch self.interfaceID {
      case 1 :
        self.tap = UITapGestureRecognizer(target: self.mainInterface, action: #selector(mainInterface.changeMainInterfaceToFirst))
      case 2 :
        self.tap = UITapGestureRecognizer(target: self.mainInterface, action: #selector(mainInterface.changeMainInterfaceToSecond))
      case 3 :
        self.tap = UITapGestureRecognizer(target: self.mainInterface, action: #selector(mainInterface.changeMainInterfaceToThird))
      default :
        print("interfaceID does not refer to an actual interface: interface set to first")
        self.tap = UITapGestureRecognizer(target: self.mainInterface, action: #selector(mainInterface.changeMainInterfaceToFirst))
    }
    
    super.init(nibName: nil, bundle: nil)
    
    self.view = UIView(frame : CGRect(x : xPosition, y : 0, width : (parent.frame.width / 3), height : parent.frame.height))
    view!.backgroundColor = Color.BACKGROUND_FOUR
    
    view!.addGestureRecognizer(tap)
    
    let main : UIView = UIView(frame : CGRect(x : 2.5, y : 2.5, width : (parent.frame.width / 3) - 2.5, height : parent.frame.height - 5))
    main.backgroundColor = Color.BACKGROUND_THREE
    main.isUserInteractionEnabled = false
    view!.addSubview(main)
    
    let iconView : UIImageView = UIImageView(image: UserData.resizeImage(image: icon, targetSize: CGSize(width: self.view!.frame.width - self.view!.frame.width / 4, height: self.view!.frame.height - self.view!.frame.height / 4)))
    
    iconView.frame = CGRect(x: (main.frame.width / 2) - (iconView.image!.size.width / 2), y: (main.frame.height / 2) - (iconView.image!.size.height / 2.4), width: iconView.image!.size.width, height: iconView.image!.size.height)
    view!.addSubview(iconView)
  }
  
  public override func loadView() {
    print("loadview")
    self.becomeFirstResponder()
  }
  
  public override func viewDidLoad() {
    print("viewdidload ")
    print(self.isFirstResponder)
    super.viewDidLoad()
  }
  
  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}



