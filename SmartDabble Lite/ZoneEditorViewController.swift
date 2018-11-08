//
//  ZoneEditorViewController.swift
//  SmartDabble Lite
//
//  Created by Mamajonov Elbek on 11/8/18.
//  Copyright © 2018 Mamajonov Elbek. All rights reserved.
//

import UIKit

class ZoneEditorViewController: UIViewController {

    
    @IBOutlet weak var zoneImage: UIImageView!
    
    @IBOutlet weak var zoneNameTextField: UITextField!
    
    @IBOutlet weak var zoneDescriptionTextView: UITextView!

    @IBOutlet weak var cameraButton: UIButton!{
        didSet {
            cameraButton.isHidden = true
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        cameraButton.isHidden = !editing
        zoneNameTextField.isUserInteractionEnabled = true
        zoneDescriptionTextView.isUserInteractionEnabled = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
