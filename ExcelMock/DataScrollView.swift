//
//  DataScrollView.swift
//  ExcelMock
//
//  Created by Matt Gioe on 9/26/16.
//  Copyright © 2016 Matt Gioe. All rights reserved.
//

import UIKit

class DataScrollView : UIScrollView {
    
    var tableArray : [DataTable] = []
    var mainRowArray : [RowModel] = []
    var currentTableIndex : Int = 0
    let kCellDataVcPushIdentifier = "pushDataView"

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init (frame : CGRect, rowArray : [RowModel]){
        
        super.init(frame: frame)
        mainRowArray = rowArray
        
        for index in (0...highestColumnNumber(rowArray: mainRowArray)){
            let tablePage = DataTable.init()
            let header = TableHeaderView.init()
            tablePage.index = index
            header.index = index
            registerDelegatesAndCellsForTable(tablePage)
            tableArray.append(tablePage)
            addSubview(tablePage)
            addSubview(header)
        }
        

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        let viewsArray = subviews
        
        for index in (0...viewsArray.count - 1){
            if viewsArray[index] is DataTable{
                let view = viewsArray[index] as! DataTable
                viewsArray[index].frame = CGRect(x: bounds.width * CGFloat(view.index), y: 50, width: bounds.width, height: bounds.height)
            } else if  viewsArray[index] is TableHeaderView {
                let view = viewsArray[index] as! TableHeaderView
                viewsArray[index].frame = CGRect(x: bounds.width * CGFloat(view.index), y: 0, width: bounds.width, height: 50)
            }
        }
    
        contentSize = CGSize(width: bounds.width * CGFloat(viewsArray.count), height: bounds.height)
        
    }
    
    
    func registerDelegatesAndCellsForTable(_ table : DataTable){
        table.register(ExcelCellTableViewCell.self)
        table.dataSource = self
        table.delegate = self

    }
    
    func highestColumnNumber(rowArray : [RowModel]) -> Int {
        var columnArray : [Int] = []
        for row in rowArray {
            columnArray.append(row.cellArray.count)
        }
        
        
        return columnArray.max()! - 1
        
    }
    
}

extension DataScrollView : UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let view = scrollView as! DataTable
        
        for table in tableArray {
            table.contentOffset = view.contentOffset
        }
    }
}


extension DataScrollView : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let cell = tableView.cellForRow(at: indexPath) as! ExcelCellTableViewCell
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: kCellDataVcPushIdentifier), object: nil, userInfo: ["cell" : cell])
    }
}


extension DataScrollView : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainRowArray.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentTableView = tableView as! DataTable

        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as ExcelCellTableViewCell
        let row = mainRowArray[indexPath.row]
        let cellArray = row.cellArray
        
        if currentTableView.index > (cellArray.count - 1){
             cell.setCellText("")
        } else {
            let cellString = cellArray[currentTableView.index]
            cell.setCellText(cellString.data)
        }
       

        return cell
    
    }
    
}
