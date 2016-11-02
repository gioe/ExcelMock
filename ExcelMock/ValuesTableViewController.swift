//
//  ValuesTableViewController.swift
//  ExcelMock
//
//  Created by Matt Gioe on 9/24/16.
//  Copyright © 2016 Matt Gioe. All rights reserved.
//

import UIKit

class ValuesTableViewController: UIViewController {
    var columnArray : [ColumnModel] = []
    var currentTableIndex : Int = 0
    
    var mainScrollView: DataScrollView! {
        didSet {
            mainScrollView.delegate = self
            mainScrollView.showsVerticalScrollIndicator = false
            mainScrollView.isDirectionalLockEnabled = true
            mainScrollView.isPagingEnabled = true
            mainScrollView.bounces = false
        }
    }
    

    
    @IBOutlet weak var headerView: TableHeaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.headerLabel.text = TableModel().columnArray[0].title
        mainScrollView = DataScrollView.init(frame: CGRect(x: 0, y: 124, width: view.frame.size.width, height: view.frame.size.height), columnArray: columnArray)
        mainScrollView.delegate = self
        view.addSubview(mainScrollView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func refreshTable(){
        mainScrollView.removeFromSuperview()

        mainScrollView = DataScrollView.init(frame: CGRect(x: 0, y: 124, width: view.frame.size.width, height: view.frame.size.height), columnArray: columnArray)
        mainScrollView.contentOffset = CGPoint(x: mainScrollView.frame.size.width * CGFloat(currentTableIndex), y: 0)

        view.addSubview(mainScrollView)
        
    }

}

extension ValuesTableViewController : UIScrollViewDelegate{
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
        
        let pageWidth:CGFloat = scrollView.frame.width
        let currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
        headerView.headerLabel.text = columnArray[Int(currentPage)].title
        currentTableIndex = Int(currentPage)
        mainScrollView.currentTableIndex = Int(currentPage)
    }
}
