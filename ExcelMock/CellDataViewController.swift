//
//  CellDataViewController.swift
//  ExcelMock
//
//  Created by Matt Gioe on 11/2/16.
//  Copyright © 2016 Matt Gioe. All rights reserved.
//

import UIKit

class CellDataViewController: UIViewController {

    var dataLabel : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataLabel = UILabel.init()
        view.addSubview(dataLabel)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        dataLabel.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 200)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
