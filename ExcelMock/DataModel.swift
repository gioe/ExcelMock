//
//  DataModel.swift
//  ExcelMock
//
//  Created by Matt Gioe on 11/1/16.
//  Copyright © 2016 Matt Gioe. All rights reserved.
//

import UIKit

class DataModel: NSObject {
    
    var numberOfSheets : Int = 1
    var rowArray : [RowModel] = []
    var cellArray : [CellModel] = []
    let endLineConstant1 = "\r\n"
    let endLineConstant2 = "\n"
    let endLineConstant3 = "\n\n"

    
    let currentRowModel = RowModel()
    
    init(commaSeparatedData : [String]){
        super.init()
        parseArray(dataArray: commaSeparatedData)
    }
    
    func parseArray(dataArray : [String]){
        for object in dataArray{
            
            if (!isDoubleEndLine(object: object)){
                
                if (!isEndLine(object: object)){
                    
                    let currentCell = CellModel.init(dataString: object)
                    currentRowModel.cellArray.append(currentCell)
                    
                } else {
                    let currentCell = CellModel.init(dataString: fixEndLineString(object: object))
                    
                    currentRowModel.cellArray.append(currentCell)
                    
                    let rowCopy = RowModel()
                    rowCopy.cellArray = currentRowModel.cellArray
                    rowArray.append(rowCopy)
                    currentRowModel.cellArray.removeAll()

                }
                
            } else {
                let currentCell = CellModel.init(dataString: fixEndLineString(object: object))
                
                currentRowModel.cellArray.append(currentCell)
                
                let rowCopy = RowModel()
                rowCopy.cellArray = currentRowModel.cellArray
                rowArray.append(rowCopy)
                let emptyRow = RowModel()
                emptyRow.cellArray.append(CellModel.init(dataString: ""))
                rowArray.append(emptyRow)
                currentRowModel.cellArray.removeAll()
                
            }
        }
    }
    
    func isEndLine(object : String) -> Bool {
        return object == endLineConstant1 || object.contains(endLineConstant1) || object == endLineConstant2 || object.contains(endLineConstant2)

    }
    
    func isDoubleEndLine(object : String) -> Bool {
        return object == endLineConstant3 || object.contains(endLineConstant3)
    }
    
    func fixEndLineString(object : String) -> String{
        
        if object.contains(endLineConstant3){
            return object.replacingOccurrences(of: endLineConstant3, with: "")

        } else if object.contains(endLineConstant2) {
            return object.replacingOccurrences(of: endLineConstant2, with: "")

        } else {
            return object.replacingOccurrences(of: endLineConstant1, with: "")

        }

    }
}
