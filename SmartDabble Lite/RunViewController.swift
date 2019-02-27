//
//  RunViewController.swift
//  SmartDabble Lite
//
//  Created by Mamajonov Elbek on 10/25/18.
//  Copyright © 2018 Mamajonov Elbek. All rights reserved.
//

import UIKit
import SRCountdownTimer
import KBRoundedButton

class RunViewController: UIViewController {
    
    @IBOutlet weak var timeText: UITextField!
    @IBOutlet weak var startButton: KBRoundedButton!
    let alert = UIAlertController(title: "inputAlert", message: "Set the watering time", preferredStyle: .alert)
    @IBOutlet weak var countDownTimer: SRCountdownTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countDownTimer.lineColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        countDownTimer.labelFont?.withSize(15)
        countDownTimer.useMinutesAndSecondsRepresentation = true
        alert.addAction(UIAlertAction(title: "alertButton", style: .default, handler: nil))
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    @IBAction func startAction(_ sender: KBRoundedButton) {
        
        if (timeText.text?.isEmpty)! {
            self.present(alert, animated: true, completion: nil)
        }
        countDownTimer.start(beginingValue: Int(timeText.text!)!*60, interval: 1)
    }
    
    @IBAction func stopAction(_ sender: KBRoundedButton) {
        countDownTimer.start(beginingValue: 1, interval: 1)
    }
    
}
