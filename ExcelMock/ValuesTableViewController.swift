//
//  ValuesTableViewController.swift
//  ExcelMock
//
//  Created by Matt Gioe on 9/24/16.
//  Copyright © 2016 Matt Gioe. All rights reserved.
//

import UIKit

class ValuesTableViewController: UIViewController {
    let kSplitConstant = "Split"
    let kUnsplitConstant = "Unsplit"
    var columnArray : [ColumnModel] = []
    var currentTableIndex : Int = 0
    
    var mainScrollView: ValuesTableScrollView! {
        didSet {
            mainScrollView.delegate = self
            mainScrollView.showsVerticalScrollIndicator = false
            mainScrollView.isDirectionalLockEnabled = true
            mainScrollView.isPagingEnabled = true
            mainScrollView.bounces = false
        }
    }
    
    var secondScrollView: ValuesTableScrollView! {
        didSet {
            secondScrollView.delegate = self
            secondScrollView.showsVerticalScrollIndicator = false
            secondScrollView.isDirectionalLockEnabled = true
            secondScrollView.isPagingEnabled = true
            secondScrollView.bounces = false
        }
    }
    
    @IBOutlet weak var headerView: TableHeaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        columnArray = TableModel().columnArray
        headerView.headerLabel.text = columnArray[0].title
        mainScrollView = ValuesTableScrollView.init(frame: CGRect(x: 0, y: 124, width: view.frame.size.width, height: view.frame.size.height), columnArray: columnArray)
        mainScrollView.delegate = self
        view.addSubview(mainScrollView)
        headerView.addButton.addTarget(self, action: #selector(ValuesTableViewController.addToTable), for: UIControlEvents.touchUpInside)
        headerView.pinButton.addTarget(self, action: #selector(ValuesTableViewController.refreshTable), for: UIControlEvents.touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func addToTable(){
        mainScrollView.tableAdjustableDelegate?.addToTableAtIndex(index: currentTableIndex)
    }
    
    func refreshTable(){
        if (headerView.pinButton.titleLabel?.text == kSplitConstant){
            
            headerView.pinButton.setTitle(kUnsplitConstant, for: .normal)

            mainScrollView.removeFromSuperview()

            mainScrollView = ValuesTableScrollView.init(frame: CGRect(x: 0, y: 124, width: view.frame.size.width / 2, height: view.frame.size.height), columnArray: columnArray)
            mainScrollView.contentOffset = CGPoint(x: mainScrollView.frame.size.width * CGFloat(currentTableIndex), y: 0)
            
            secondScrollView = ValuesTableScrollView.init(frame: CGRect(x: mainScrollView.frame.size.width, y: 124, width: view.frame.size.width / 2, height: view.frame.size.height), columnArray: columnArray)
            secondScrollView.delegate = self
            
            view.addSubview(mainScrollView)
            view.addSubview(secondScrollView)
            
        } else {
            
            headerView.pinButton.setTitle(kSplitConstant, for: .normal)

            secondScrollView.removeFromSuperview()
            mainScrollView.removeFromSuperview()

            mainScrollView = ValuesTableScrollView.init(frame: CGRect(x: 0, y: 124, width: view.frame.size.width, height: view.frame.size.height), columnArray: columnArray)
            mainScrollView.contentOffset = CGPoint(x: mainScrollView.frame.size.width * CGFloat(currentTableIndex), y: 0)

            view.addSubview(mainScrollView)
            
        }

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
