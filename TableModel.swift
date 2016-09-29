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
    
    override init(){
        let column1 = ColumnModel.init(title: "Names", dataArray:["Evangelina Pearlman", "Arthur Prange", "Pok Gillogly", "Filomena Mcalpine", "Gilda Pettaway", "Raymon Westendorf", "Margarette McKim", "Buster Douglas",
                                                                  "Holli Evett"])
        columnArray.append(column1)
        let column2 = ColumnModel(title:"Age", dataArray: ["23", "24", "26", "28", "30", "45", "22","17", "25"])
        columnArray.append(column2)
        let column3 = ColumnModel(title: "Position1", dataArray: ["Catcher", "First Base", "Second Base", "Pitcher", "Center Field", "Catcher", "Third Base", "Shortstop", "Left Field"])
        columnArray.append(column3)
    }
}
