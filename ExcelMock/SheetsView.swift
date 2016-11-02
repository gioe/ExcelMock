//
//  HighLevelTableView.swift
//  ExcelMock
//
//  Created by Matt Gioe on 10/31/16.
//  Copyright © 2016 Matt Gioe. All rights reserved.
//

import UIKit

class SheetsView: UIView {

    var view: UIView!
    var columnArray : [ColumnModel] = []
    var index : Int = 0
    var headerLabel: UILabel!
    var tablePage : DataScrollView!
    
    
    override init(frame: CGRect){
        super.init(frame:frame)
        headerLabel =  UILabel.init()
        headerLabel.textAlignment = .center
        headerLabel.text = TableModel().columnArray[0].title
        addSubview(headerLabel)
        
        tablePage = DataScrollView.init(frame: CGRect(x: 0, y: headerLabel.frame.origin.y + headerLabel.bounds.height, width: frame.width, height: bounds.height - headerLabel.bounds.height), columnArray: TableModel().columnArray)
        tablePage.isScrollEnabled = false
        addSubview(tablePage)
        
    }
    
    override func layoutSubviews() {
        headerLabel.frame = CGRect(x:0, y: 0, width: bounds.width, height: 20)
        tablePage.frame = CGRect(x: 0, y: headerLabel.frame.origin.y + headerLabel.bounds.height, width: bounds.width, height: bounds.height - headerLabel.bounds.height)
        tablePage.layoutIfNeeded()
        super.layoutSubviews()
        
    }
        
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
}


