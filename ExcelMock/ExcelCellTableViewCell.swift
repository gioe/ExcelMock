//
//  ExcelCellTableViewCell.swift
//  ExcelMock
//
//  Created by Matt Gioe on 9/14/16.
//  Copyright © 2016 Matt Gioe. All rights reserved.
//

import UIKit

class ExcelCellTableViewCell: UITableViewCell {

    @IBOutlet weak var content: UIView!
    @IBOutlet weak var dataLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellText(text : String){
        dataLabel.text = text
    }
    
}
