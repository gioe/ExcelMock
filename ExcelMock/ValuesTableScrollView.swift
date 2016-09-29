//
//  ValuesTableScrollView.swift
//  ExcelMock
//
//  Created by Matt Gioe on 9/26/16.
//  Copyright © 2016 Matt Gioe. All rights reserved.
//

import UIKit

protocol TableAdjustable {
     func addToTableAtIndex(index: Int)
}

class ValuesTableScrollView: UIScrollView {
    
    var tableArray : [DataTable] = []
    var mainColumnArray : [ColumnModel] = []
    var currentTableIndex : Int = 0
    var tableAdjustableDelegate : TableAdjustable?
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init (frame : CGRect, columnArray : [ColumnModel]){
        super.init(frame: frame)
        registerDelgates()
        
        let scrollViewWidth:CGFloat = frame.width
        mainColumnArray = columnArray
        for index in (0...columnArray.count - 1){
            let newWidth = scrollViewWidth * CGFloat(index)
            let tablePage = DataTable.init(frame: CGRect(x: newWidth, y: 0, width: frame.size.width, height: frame.height))
            tablePage.index = index
            regsiterDelegatesAndCellsForTable(table: tablePage)
            tableArray.append(tablePage)
            addSubview(tablePage)
        }
        
        contentSize = CGSize(width: frame.width * CGFloat(columnArray.count), height: frame.height)

    }
    
    func regsiterDelegatesAndCellsForTable(table : DataTable){
        table.dataSource = self
        table.register(ExcelCellTableViewCell.self)
        table.register(AddDataTableViewCell.self)
    }
    
    func registerDelgates(){
        tableAdjustableDelegate = self
    }
    
}

extension ValuesTableScrollView : TableAdjustable {
    
    func addToTableAtIndex(index: Int){
        currentTableIndex = index
        mainColumnArray[index].dataArray.insert("", at: 0)
        for element in tableArray{
            element.reloadData()
        }
        
    }
}

extension ValuesTableScrollView : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let currentTableView = tableView as! DataTable
        return mainColumnArray[currentTableView.index].dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentTableView = tableView as! DataTable

        if (mainColumnArray[currentTableView.index].dataArray[indexPath.row] == ""){
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as AddDataTableViewCell
            cell.textInputField.delegate = self
            return cell

        } else {
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as ExcelCellTableViewCell
            cell.setCellText(text: mainColumnArray[currentTableView.index].dataArray[indexPath.row])
            return cell

        }
        
    }
    
}

extension ValuesTableScrollView : UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        mainColumnArray[currentTableIndex].dataArray[0] = textField.text!
        for element in tableArray{
            element.reloadData()
        }
        return true
    }

}
