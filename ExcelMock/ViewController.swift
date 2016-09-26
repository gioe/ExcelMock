//
//  ViewController.swift
//  ExcelMock
//
//  Created by Matt Gioe on 9/14/16.
//  Copyright © 2016 Matt Gioe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var mainTableView: UITableView!
    let numberArray = [1, 2, 3, 4, 5, 6, 7]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerNibs()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func registerNibs(){
        mainTableView?.register(UINib.init(nibName: "ExcelCellTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
    }


}

extension ViewController: UITableViewDelegate{
    
}

extension ViewController: UITableViewDataSource{
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return numberArray.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ExcelCellTableViewCell
        cell.setCellText(text: String(numberArray[indexPath.row]))
        return cell
    }
    
}
