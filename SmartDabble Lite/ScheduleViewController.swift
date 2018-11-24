//
//  ScheduleViewController.swift
//  SmartDabble Lite
//
//  Created by Mamajonov Elbek on 11/21/18.
//  Copyright © 2018 Mamajonov Elbek. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController {

    @IBOutlet var dayButtons: [UIButton]!
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
