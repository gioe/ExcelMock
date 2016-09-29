//
//  TableHeaderView.swift
//  ExcelMock
//
//  Created by Matt Gioe on 9/26/16.
//  Copyright © 2016 Matt Gioe. All rights reserved.
//

import UIKit

class TableHeaderView: UIView {

    var view: UIView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var pinButton: UIButton!
    
    override init(frame: CGRect){
        super.init(frame:frame)
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        setUpView()
    }
    
    func setUpView(){
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(view)
    }
    
    func loadViewFromNib()-> UIView{
        let nib = UINib(nibName: "TableHeaderView", bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
}
