//
//  FormulasTableViewController.swift
//  ExcelMock
//
//  Created by Matt Gioe on 9/24/16.
//  Copyright © 2016 Matt Gioe. All rights reserved.
//

import UIKit

class FormulasTableViewController: UIViewController {

    @IBOutlet weak var formulasTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formulasTable.register(ExcelCellTableViewCell.self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension FormulasTableViewController : UITableViewDataSource{
    
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
