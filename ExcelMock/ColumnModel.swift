//
//  ColumnModel.swift
//  ExcelMock
//
//  Created by Matt Gioe on 9/26/16.
//  Copyright © 2016 Matt Gioe. All rights reserved.
//

import UIKit

class ColumnModel: NSObject {
    
    var title: String
    var dataArray : [String]

    init(title: String, dataArray: [String]){
        self.title = title
        self.dataArray = dataArray
    }
   
}
