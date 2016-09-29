//
//  AttributesTableViewController.swift
//  ExcelMock
//
//  Created by Matt Gioe on 9/24/16.
//  Copyright © 2016 Matt Gioe. All rights reserved.
//

import UIKit

class AttributesTableViewController: UIViewController {

    @IBOutlet weak var attributesTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attributesTable.register(ExcelCellTableViewCell.self)


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}


extension AttributesTableViewController : UITableViewDataSource{
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as ExcelCellTableViewCell
        return cell
        
    }
}

