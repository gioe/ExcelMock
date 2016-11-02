//
//  TablesSwipeViewController.swift
//  ExcelMock
//
//  Created by Matt Gioe on 10/31/16.
//  Copyright © 2016 Matt Gioe. All rights reserved.
//

import UIKit
class TableSheetsViewController: UIViewController {

    var dataTable : DataModel? {
        didSet{
            setupScroll()
        }
    }
    
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

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setupScroll(){
        
        for index in (0...dataTable!.numberOfSheets){
            let tableView = SheetsView.init(frame: CGRect(x: view.bounds.width * CGFloat(index), y: 0, width: view.bounds.width - 100, height: view.bounds.height - 100 ), data: dataTable!)
            tableView.layer.borderWidth = 3
            tableView.layer.borderColor = UIColor.black.cgColor
            tableView.index = index
    
            singleTap = UITapGestureRecognizer(target: self, action: #selector(TableSheetsViewController.handleSelection(sender:)))
            singleTap.numberOfTapsRequired = 1
            tableView.addGestureRecognizer(singleTap)
            
            tableView.center.x = view.center.x + (view.bounds.width * CGFloat(index))
            tableView.center.y = view.center.y
            swipeableTableView.addSubview(tableView)
            
        }
        
        swipeableTableView.contentSize = CGSize(width: swipeableTableView.frame.width * CGFloat(dataTable!.numberOfSheets), height: swipeableTableView.frame.height)

    }
    
    func handleSelection(sender: AnyObject){
        let gestureRecognizer = sender as! UITapGestureRecognizer
        let currentTable = gestureRecognizer.view as! SheetsView
        
        UIView.animate(withDuration: 0.25, delay: 0.0, options: [], animations: {
            self.oldViewFrame = currentTable.frame
            currentTable.frame = CGRect(x: self.swipeableTableView.contentOffset.x, y: 20, width: self.view.bounds.width, height: self.view.bounds.height)
            
        }, completion: { (finished: Bool) in
            currentTable.removeGestureRecognizer(gestureRecognizer)
            
            self.pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(TableSheetsViewController.handleDismiss(sender:)))
            currentTable.addGestureRecognizer(self.pinchGesture)
            
            self.swipeableTableView.isScrollEnabled = false
            
            currentTable.tablePage.isUserInteractionEnabled = true
            currentTable.tablePage.isPagingEnabled = true

            
        })
    }
  
    func handleDismiss(sender: AnyObject){
        let gestureRecognizer = sender as! UIPinchGestureRecognizer
        let currentView = gestureRecognizer.view as! SheetsView
        UIView.animate(withDuration: 0.25, delay: 0.0, options: [], animations: {
            
           currentView.frame = self.oldViewFrame!
     
        }, completion: { (finished: Bool) in

            currentView.removeGestureRecognizer(gestureRecognizer)

            self.singleTap = UITapGestureRecognizer(target: self, action: #selector(TableSheetsViewController.handleSelection(sender:)))
            self.singleTap.numberOfTapsRequired = 1
            currentView.addGestureRecognizer(self.singleTap)
            self.swipeableTableView.isScrollEnabled = true
            currentView.tablePage.isUserInteractionEnabled = false
            currentView.tablePage.contentOffset = CGPoint(x: 0, y: 0)
            
        })

    }

    
           
}
