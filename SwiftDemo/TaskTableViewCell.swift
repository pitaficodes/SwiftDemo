//
//  TaskTableViewCell.swift
//  SwiftDemo
//
//  Created by Asad Ali on 08/09/2014.
//  Copyright (c) 2014 DevBatch. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    
    
    @IBOutlet var lblTitle : UILabel
    @IBOutlet var btnIsCompleted : UIButton
    
    init(style: UITableViewCellStyle, reuseIdentifier: String) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // Initialization code
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
