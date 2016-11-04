//
//  CellDataViewController.swift
//  ExcelMock
//
//  Created by Matt Gioe on 11/2/16.
//  Copyright © 2016 Matt Gioe. All rights reserved.
//

import UIKit

class CellDataViewController: UIViewController {
    
    var dataString : String?
    var pinchGesture : UIPinchGestureRecognizer = UIPinchGestureRecognizer()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)

        let dataLabel = UILabel.init(frame:  CGRect(x: 0, y: 0, width: view.bounds.width, height: 200))
        dataLabel.text = dataString
        view.addSubview(dataLabel)
        pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(CellDataViewController.handleDismiss(sender:)))
        view.addGestureRecognizer(pinchGesture)

        // Do any additional setupafter loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleDismiss(sender: AnyObject){
        
        navigationController?.dismiss(animated: true, completion: nil)
    }
}

