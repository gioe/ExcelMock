//
//  TableModel
//  ExcelMock
//
//  Created by Matt Gioe on 9/26/16.
//  Copyright © 2016 Matt Gioe. All rights reserved.
//

import UIKit

class TableModel: NSObject {
    
    var tag : Int = 0;
    var columnArray : [ColumnModel] = [];
    var rowArray : [RowModel] = [];
    var tableTitleArray : [String] = [];

    init(rowArray : [RowModel]){
        self.rowArray = rowArray
    }
}
