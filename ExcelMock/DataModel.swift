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
    var foundQuote : Bool = false
    var concatenatedCell : String = ""
    
    init(commaSeparatedData : [String]){
        super.init()
        parseArray(dataArray: commaSeparatedData)
    }

    func parseArray(dataArray : [String]){
        for object in dataArray{
            
            if ((object != "\r\n") && (!object.contains("\r\n")) ){
                
                if (object.contains("\" ") || self.foundQuote){
                    self.foundQuote = true
                    self.concatenatedCell += object
                } else if (object.contains(" \"")){
                    self.concatenatedCell += object
                    self.foundQuote = false
                    let currentCell = CellModel.init(dataString: self.concatenatedCell)
                    currentRowModel.cellArray.append(currentCell)
                }  else {
                    let currentCell = CellModel.init(dataString: object)
                    currentRowModel.cellArray.append(currentCell)
                }
                
            } else {
                let currentCell = CellModel.init(dataString: object)
                currentRowModel.cellArray.append(currentCell)
                let rowCopy = currentRowModel
                rowArray.append(rowCopy)
                currentRowModel.cellArray.removeAll()
            }
        }
        
        print(rowArray)
    }
}
