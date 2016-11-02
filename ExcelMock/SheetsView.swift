//
//  HighLevelTableView.swift
//  ExcelMock
//
//  Created by Matt Gioe on 10/31/16.
//  Copyright © 2016 Matt Gioe. All rights reserved.
//

import UIKit

class SheetsView: UIView {

    var dataTable : DataModel?
    var view: UIView!
    var columnArray : [ColumnModel] = []
    var index : Int = 0
    var headerLabel: UILabel!
    var tablePage : DataScrollView!
    
    
    init(frame: CGRect, data: DataModel){
        super.init(frame:frame)
        self.dataTable = data
        headerLabel =  UILabel.init()
        headerLabel.textAlignment = .center
        addSubview(headerLabel)
        
        tablePage = DataScrollView.init(frame:  CGRect(x: 0, y: headerLabel.frame.origin.y + headerLabel.bounds.height, width: frame.width, height: bounds.height - headerLabel.bounds.height), rowArray: (dataTable?.rowArray)!)
        tablePage.isUserInteractionEnabled = false
        addSubview(tablePage)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        headerLabel.frame = CGRect(x:0, y: 0, width: bounds.width, height: 20)
        tablePage.frame = CGRect(x: 0, y: headerLabel.frame.origin.y + headerLabel.bounds.height, width: bounds.width, height: bounds.height - headerLabel.bounds.height)
        
    }
        
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
}


