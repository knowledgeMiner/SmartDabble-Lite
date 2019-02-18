//
//  ScheduleViewController.swift
//  SmartDabble Lite
//
//  Created by Mamajonov Elbek on 11/21/18.
//  Copyright © 2018 Mamajonov Elbek. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController {
    
    var state: Bool = false
    @IBOutlet var dayButtons: [UIButton]! {
        didSet {
            
            for button in dayButtons {
                button.isSelected = !state
                if button.isSelected {
                    button.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
//                    button.is
                }
            }
        }
    }
    @IBOutlet weak var height: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dayFunc()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.view.layoutIfNeeded()
        dayFunc()
    }
    
    func dayFunc() {
        let width = self.dayButtons[0].bounds.width
        height.constant = width
        print(width)
        dayButtons.forEach { (button) in
            button.layer.cornerRadius = width/2
        }
    }


}
