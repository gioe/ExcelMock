//
//  TablesSwipeViewController.swift
//  ExcelMock
//
//  Created by Matt Gioe on 10/31/16.
//  Copyright © 2016 Matt Gioe. All rights reserved.
//

import UIKit
class TableSheetsViewController: UIViewController {

    var singleTap : UITapGestureRecognizer = UITapGestureRecognizer()
    var pinchGesture : UIPinchGestureRecognizer = UIPinchGestureRecognizer()
    var finishedAnimation : Bool = false
    var oldViewFrame : CGRect?
    
    var oldHeaderFrame : CGRect?

    var oldTableFrame : CGRect?


     var interactiveTransition: UIPercentDrivenInteractiveTransition!
    
    @IBOutlet var swipeableTableView: UIScrollView! {
        didSet{
            swipeableTableView.showsVerticalScrollIndicator = false
            swipeableTableView.showsHorizontalScrollIndicator = false
            swipeableTableView.isDirectionalLockEnabled = true
            swipeableTableView.isPagingEnabled = true
            swipeableTableView.bounces = false
        }
        
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        setupScroll()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setupScroll(){
        
        for index in (0...4){
            let tableView = SheetsView.init(frame: CGRect(x: view.bounds.width * CGFloat(index), y: 0, width: view.bounds.width - 150, height: view.bounds.height - 150 ))
            tableView.index = index
    
            singleTap = UITapGestureRecognizer(target: self, action: #selector(TableSheetsViewController.handleSelection(sender:)))
            singleTap.numberOfTapsRequired = 1
            tableView.addGestureRecognizer(singleTap)
            
            pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(TableSheetsViewController.handleDismiss(sender:)))
            tableView.addGestureRecognizer(pinchGesture)
        
            tableView.center.x = view.center.x + (view.bounds.width * CGFloat(index))
            tableView.center.y = view.center.y
            swipeableTableView.addSubview(tableView)
            
        }
        
        swipeableTableView.contentSize = CGSize(width: swipeableTableView.frame.width * 5, height: swipeableTableView.frame.height)


    }
    
    func handleSelection(sender: AnyObject){
        let gestureRecognizer = sender as! UITapGestureRecognizer
        let currentTable = gestureRecognizer.view as! SheetsView
        
        currentTable.headerLabel!.text = ""
        UIView.animate(withDuration: 0.25, delay: 0.0, options: [], animations: {
            self.oldViewFrame = currentTable.frame
            currentTable.frame = CGRect(x: self.swipeableTableView.contentOffset.x, y: 20, width: self.view.bounds.width, height: self.view.bounds.height)
            
        }, completion: { (finished: Bool) in
            currentTable.removeGestureRecognizer(gestureRecognizer)
            self.swipeableTableView.isScrollEnabled = false
            
            currentTable.tablePage.isScrollEnabled = true
            currentTable.tablePage.isPagingEnabled = true
            currentTable.tablePage.isUserInteractionEnabled = true
            
        })
    }
  
    func handleDismiss(sender: AnyObject){
        let gestureRecognizer = sender as! UIPinchGestureRecognizer
        let currentView = gestureRecognizer.view as! SheetsView
        currentView.headerLabel!.text = TableModel().columnArray[0].title
        UIView.animate(withDuration: 0.25, delay: 0.0, options: [], animations: {
            
           currentView.frame = self.oldViewFrame!
     
        }, completion: { (finished: Bool) in
            
            self.singleTap = UITapGestureRecognizer(target: self, action: #selector(TableSheetsViewController.handleSelection(sender:)))
            self.singleTap.numberOfTapsRequired = 1
            currentView.addGestureRecognizer(self.singleTap)
            self.swipeableTableView.isScrollEnabled = true
            currentView.tablePage.isScrollEnabled = false
            currentView.tablePage.isPagingEnabled = false
            
        })

    }

    
           
}
