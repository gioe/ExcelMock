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
    var mainColumnArray : [ColumnModel] = []
    var currentTableIndex : Int = 0
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init (frame : CGRect, columnArray : [ColumnModel]){
        
        super.init(frame: frame)
        mainColumnArray = columnArray
        
        for index in (0...columnArray.count - 1){
            let tablePage = DataTable.init()
            tablePage.index = index
            regsiterDelegatesAndCellsForTable(tablePage)
            tableArray.append(tablePage)
            addSubview(tablePage)
        }
        

    }
    
    override func layoutSubviews() {
        let viewsArray = subviews
        for index in (0...mainColumnArray.count - 1){
            if viewsArray[index] is DataTable{
                let currentView = viewsArray[index] as! DataTable
                currentView.frame = CGRect(x: bounds.width * CGFloat(index), y: 0, width: bounds.width, height: bounds.height)
            }
        }
    
        contentSize = CGSize(width: bounds.width * CGFloat(mainColumnArray.count), height: bounds.height)
        super.layoutSubviews()
        
    }
    
    
    func regsiterDelegatesAndCellsForTable(_ table : DataTable){
        table.register(ExcelCellTableViewCell.self)
        table.dataSource = self
        table.delegate = self

    }
    
}


extension DataScrollView : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let cell = tableView.cellForRow(at: indexPath) as! ExcelCellTableViewCell
        UIView.animate(withDuration: 0.25, delay: 0.0, options: [], animations: {
            
            cell.transform = CGAffineTransform(scaleX: 1.6, y: 1.6)
            
        }, completion: { (finished: Bool) in
            
        
            
        })

    }
}


extension DataScrollView : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let currentTableView = tableView as! DataTable
        return mainColumnArray[currentTableView.index].dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentTableView = tableView as! DataTable

        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as ExcelCellTableViewCell
        cell.setCellText(mainColumnArray[currentTableView.index].dataArray[indexPath.row])
        return cell
    
    }
    
}
