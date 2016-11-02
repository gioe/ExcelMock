//
//  CellModel.swift
//  ExcelMock
//
//  Created by Matt Gioe on 11/1/16.
//  Copyright © 2016 Matt Gioe. All rights reserved.
//

import UIKit

class CellModel: NSObject {
    var data : String = ""
    
    init(dataString : String){
        self.data = dataString
    }
}
