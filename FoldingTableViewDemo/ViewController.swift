//
//  ViewController.swift
//  FoldingTableViewDemo
//
//  Created by Mjwon on 2017/7/10.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import UIKit
import FoldTableView

class ViewController: UIViewController,FoldTableViewDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableView = FoldTableView.init(frame: CGRect(x:0,y:0,width:375,height:667), style: .plain);
        tableView.foldDelegate = self;
        tableView.defOpenIdx = 2;
        tableView.otherIsClose = false;
        self.view.addSubview(tableView);
        
    }
    
    
    func numberOfSectionForFoldTableView(tableView: FoldTableView) -> Int {
        
        return self.titleSource.count;
        
    }
    
    func foldTableView(tableView: FoldTableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 44.0;
    }
    
    func foldTableView(tableView: FoldTableView, heightForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        return 60.0;
    }
    func foldTableView(tableView: FoldTableView, titleForHeaderInSection section: Int) -> String {
        
        return self.titleSource[section] as! String;
    }
    
    func foldTableView(tableView: FoldTableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.numbers[section] as! Int;
    }
    
//    func foldingTableView(tableView: FoldingTableView, descriptionForHeaderInSection section: Int) -> String {
//        return "this is end";
//    }
    
    func foldTableView(tableView: FoldTableView, backgroundColorForHeaderInSection section: Int) -> UIColor {
        
//        if section == 0 {
//            return UIColor.init(colorLiteralRed: 217/255.0, green: 38/255.0, blue: 26/255, alpha: 1);
//        }
        
        return UIColor.white;
    }
    
    func foldTableView(tableView: FoldTableView, textColorForTitleInSection section: Int) -> UIColor {
        
//        if section == 0 {
//            return UIColor.white;
//        }
        
        return UIColor.black;
    }
    
    /**
    func clickBackgroundColor() -> UIColor {
        
        return UIColor.init(colorLiteralRed: 217/255.0, green: 38/255.0, blue: 26/255, alpha: 1);
    }
    
    func clickHeaderTitleColor() -> UIColor {
        return UIColor.white;
    }*/
    
    
    func foldTableView(tableView: FoldTableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "demoCell");
        
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "demoCell");
        }
        
        cell?.textLabel?.text = String.init(format:"%ld", indexPath.row);
        
        return cell!;
    }
    
    lazy var numbers:NSMutableArray = {
    
        let a = NSMutableArray.init();
        
        for i in 0..<self.titleSource.count{
        
            a.add(Int(arc4random()%5)+1);
            
        }
        return a;
        
    }();
    
    lazy var titleSource:NSMutableArray = {
    
        let a = NSMutableArray.init(array: ["事件描述","1D成立团队","2D问题描述","3D临时控制对策","4D原因分析","5D永久措施","6D改善效果确认","7D预防措施","8D回顾与培训"]);
        
        return a;
    
    }();
    
    
    deinit {
        print("----deinit-----");
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

