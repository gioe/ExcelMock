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
    
    let kCellDataVcPushIdentifier = "pushDataView"
    var oldViewFrame : CGRect?
    var interactiveTransition: UIPercentDrivenInteractiveTransition!
    
    @IBOutlet var swipeableTableView: UIScrollView! {
        didSet{
            swipeableTableView.showsVerticalScrollIndicator = false
            swipeableTableView.showsHorizontalScrollIndicator = false
            swipeableTableView.isDirectionalLockEnabled = true
            swipeableTableView.isScrollEnabled = false
            swipeableTableView.isPagingEnabled = true
            swipeableTableView.bounces = false
        }
        
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: kCellDataVcPushIdentifier), object: nil, queue: nil, using: catchNotification)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func catchNotification(notification:Notification) -> Void {
        
        guard let userInfo = notification.userInfo,
            let cell  = userInfo["cell"] as? ExcelCellTableViewCell else {
                print("No userInfo found in notification")
                return
        }
        
        performSegue(withIdentifier: "showDataView", sender: cell)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDataView"{
          let cell = sender as! ExcelCellTableViewCell
            
            let destinationVC = segue.destination as! UINavigationController
            let vc = destinationVC.topViewController as! CellDataViewController
            if cell.dataLabel.text != nil{
                vc.dataString = cell.dataLabel.text!
            }
            
        }
    }
    

    func setupScroll(){
        
        for index in (0...dataTable!.numberOfSheets - 1){
            let tableView = SheetsView.init(frame: CGRect(x: view.bounds.width * CGFloat(index), y: 0, width: view.bounds.width - 100, height: view.bounds.height - 100 ), data: dataTable!)
            tableView.layer.borderWidth = 3
            tableView.layer.borderColor = UIColor.black.cgColor
            tableView.index = index
    
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(TableSheetsViewController.handleSelection(sender:)))
            tapGesture.numberOfTapsRequired = 1
            tableView.addGestureRecognizer(tapGesture)
            
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
            
            DispatchQueue.main.async {
                
                if (currentTable.gestureRecognizers?.isEmpty)!{
                    
                    let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(TableSheetsViewController.handleDismiss(sender:)))
                    currentTable.addGestureRecognizer(pinchGesture)
                    
                }
                
                
                self.swipeableTableView.isScrollEnabled = false
                
                currentTable.tablePage.isUserInteractionEnabled = true
                currentTable.tablePage.isPagingEnabled = true
                
            }
          

            
        })
    }
  
    func handleDismiss(sender: AnyObject){
        let gestureRecognizer = sender as! UIPinchGestureRecognizer
        let currentView = gestureRecognizer.view as! SheetsView
        UIView.animate(withDuration: 0.25, delay: 0.0, options: [], animations: {
            
           currentView.frame = self.oldViewFrame!
     
        }, completion: { (finished: Bool) in

            DispatchQueue.main.async {
                currentView.removeGestureRecognizer(gestureRecognizer)
                
                
                if (currentView.gestureRecognizers?.isEmpty)!{
                    let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TableSheetsViewController.handleSelection(sender:)))
                    gestureRecognizer.numberOfTapsRequired = 1
                    currentView.addGestureRecognizer(gestureRecognizer)
                    
                }
                
                self.swipeableTableView.isScrollEnabled = false
                self.swipeableTableView.isPagingEnabled = true
                currentView.tablePage.isUserInteractionEnabled = false
                currentView.tablePage.contentOffset = CGPoint(x: 0, y: 0)
            }
            
            
        })

    }

    
           
}
