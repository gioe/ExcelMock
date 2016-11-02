//
//  DataModel.swift
//  ExcelMock
//
//  Created by Matt Gioe on 11/1/16.
//  Copyright © 2016 Matt Gioe. All rights reserved.
//

import UIKit

class DataModel: NSObject {
    
    var rowArray : [RowModel] = []
    var cellArray : [CellModel] = []
    let endLineConstant = "\r\n"
    let currentRowModel = RowModel()
    
    init(commaSeparatedData : [String]){
        super.init()
        parseArray(dataArray: commaSeparatedData)
    }

    func parseArray(dataArray : [String]){
        for object in dataArray{
            
            if ((object != endLineConstant) && (!object.contains(endLineConstant)) ){
                
                    let currentCell = CellModel.init(dataString: object)
                    currentRowModel.cellArray.append(currentCell)
                
            } else {
                let fixedString = object.replacingOccurrences(of: endLineConstant, with: "")
                let currentCell = CellModel.init(dataString: fixedString)

                currentRowModel.cellArray.append(currentCell)
                
                let rowCopy = RowModel()
                rowCopy.cellArray = currentRowModel.cellArray
                rowArray.append(rowCopy)
                currentRowModel.cellArray.removeAll()
                
            }
        }
            
    }

}
