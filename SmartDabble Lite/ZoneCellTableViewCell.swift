//
//  ZoneCellTableViewCell.swift
//  SmartDabble Lite
//
//  Created by Mamajonov Elbek on 11/1/18.
//  Copyright © 2018 Mamajonov Elbek. All rights reserved.
//

import UIKit

class ZoneCellTableViewCell: UITableViewCell {

    @IBOutlet weak var zoneImage: UIImageView!
    @IBOutlet weak var zoneTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
