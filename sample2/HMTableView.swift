//
//  HMTableView.swift
//  PerfectMVC
//
//  Created by 山崎友弘 on 2015/10/07.
//  Copyright (c) 2015年 yamasaki. All rights reserved.
//

import UIKit

protocol HMTableViewDataSource : NSObjectProtocol {
    func tableView(tableView: HMTableView, numberOfRowsInSection section: Int) -> Int
    func tableView(tableView: HMTableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
}

@objc protocol HMTableViewDelegate : NSObjectProtocol, UIScrollViewDelegate {
    optional func tableView(tableView: HMTableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
}



class HMTableView: UIScrollView {

    weak var myDataSource: HMTableViewDataSource?
    weak var myDelegate: HMTableViewDelegate?
    
    var _cellNum:Int = 0
    let CELL_HEIGHT:CGFloat = 50
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.brownColor()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentSize = CGSize(width: self.frame.width, height: self.frame.height)
    }

    func reloadData(){
        if (myDataSource?.respondsToSelector("tableView:numberOfRowsInSection:") != nil){
            _cellNum = myDataSource!.tableView(self, numberOfRowsInSection: 0)
        }
        
        self.contentSize = CGSize(width: self.frame.width, height:CGFloat( _cellNum) * CELL_HEIGHT)
        
        for var i:Int = 0; i < _cellNum; i++ {
            if (myDataSource?.respondsToSelector("tableView:cellForRowAtIndexPath:") != nil){
                let cell = myDataSource!.tableView(self, cellForRowAtIndexPath: NSIndexPath(forRow: i, inSection: 0))
                cell.center = CGPointMake(self.frame.width / 2, CELL_HEIGHT * CGFloat(i) + cell.frame.height / 2)
                self.addSubview(cell)
            }
        }
    }
}
