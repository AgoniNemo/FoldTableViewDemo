//
//  FoldTableView.swift
//  FoldTableView
//
//  Created by Mjwon on 2017/7/13.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import UIKit

@objc protocol FoldTableViewDelegate:class,NSObjectProtocol{
    
    func numberOfSectionForFoldTableView(tableView:FoldTableView) -> Int;
    
    func foldTableView(tableView:FoldTableView,heightForHeaderInSection section:Int)-> CGFloat;
    
    func foldTableView(tableView:FoldTableView,heightForRowAtIndexPath indexPath:IndexPath) ->CGFloat;
    
    func foldTableView(tableView:FoldTableView,numberOfRowsInSection section:Int) -> Int;
    
    func foldTableView(tableView:FoldTableView,cellForRowAtIndexPath indexPath:IndexPath) -> UITableViewCell;
    
    @objc optional func foldSectionHeaderClickAtIndex(index:Int);
    
    @objc optional func foldTableView(tableView:FoldTableView,arrowImageForSection section:Int) ->UIImage;
    
    @objc optional func foldTableView(tableView:FoldTableView,titleForHeaderInSection section:Int)->String;
    
    @objc optional func foldTableView(tableView:FoldTableView,descriptionForHeaderInSection section:Int)->String;
    
    @objc optional func foldTableView(tableView:FoldTableView,backgroundColorForHeaderInSection section:Int)->UIColor;
    
    @objc optional func clickBackgroundColor()->UIColor;
    
    @objc optional func clickHeaderTitleColor()->UIColor;
    
    @objc optional func foldTableView(tableView:FoldTableView,fontForTitleInSection section:Int)->UIFont;
    
    @objc optional func foldTableView(tableView:FoldTableView,fontForDescriptionInSection section:Int)->UIFont;
    
    @objc optional func foldTableView(tableView:FoldTableView,textColorForTitleInSection section:Int)->UIColor;
    
    @objc optional func foldTableView(tableView:FoldTableView,textColorForDescriptionInSection section:Int)->UIColor;
    
}


class FoldTableView: UITableView,UITableViewDelegate,UITableViewDataSource {

    weak open var _foldDelegate: FoldTableViewDelegate!
    
    /** 是否在打开其他组时，关闭当前组(默认为true)*/
    var otherIsClose:Bool?;
    
    private var headerViews:NSMutableArray?;
    private var _viewModels:NSMutableArray?;
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.setupDelegateAndDataSource();
        self.otherIsClose = true;
    }
    
    
    var foldDelegate:FoldTableViewDelegate?{
        
        didSet{
            _foldDelegate = foldDelegate;
            self.reloadData();
        }
    }
    func setupDelegateAndDataSource() -> Void {
        
        print(self);
        
        self.delegate = self;
        self.dataSource = self;
        
        if (self.style == .plain) {
            self.tableFooterView = UIView.init();
        }
        self.headerViews = NSMutableArray.init();
        
        NotificationCenter.default.addObserver(self, selector: #selector(onChangeStatusBarOrientationNotification), name: NSNotification.Name.UIApplicationDidChangeStatusBarOrientation, object: nil)
        
    }
    
    func onChangeStatusBarOrientationNotification(notification:NSNotification) -> Void {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.reloadData();
        }
    }
    
    
    func backgroundColorForSection(section:Int) -> UIColor {
        
        let result = foldDelegate?.responds(to: #selector(foldDelegate?.foldTableView(tableView:backgroundColorForHeaderInSection:)));
        
        if self.foldDelegate != nil ,result == true{
            return self.foldDelegate!.foldTableView!(tableView: self, backgroundColorForHeaderInSection: section)
        }
        return UIColor.white;
    }
    
    func clickBackgroundColor() -> UIColor {
        
        let result = foldDelegate?.responds(to: #selector(foldDelegate?.clickBackgroundColor));
        
        if self.foldDelegate != nil,result == true{
            
            return self.foldDelegate!.clickBackgroundColor!();
        }
        
        return UIColor.white;
    }
    
    func clickTitleColor() -> UIColor {
        
        let result = foldDelegate?.responds(to: #selector(foldDelegate?.clickHeaderTitleColor));
        
        if self.foldDelegate != nil,result==true{
            
            return self.foldDelegate!.clickHeaderTitleColor!();
        }
        return UIColor.black;
    }
    
    func titleForSection(section:Int) -> String {
        
        let result = foldDelegate?.responds(to: #selector(foldDelegate?.foldTableView(tableView:titleForHeaderInSection:)));
        
        if self.foldDelegate != nil,result==true{
            
            return self.foldDelegate!.foldTableView!(tableView: self, titleForHeaderInSection: section);
        }
        
        return String.init();
    }
    
    func titleFontForSection(section:Int) -> UIFont {
        
        let result = foldDelegate?.responds(to: #selector(foldDelegate?.foldTableView(tableView:fontForTitleInSection:)));
        
        if self.foldDelegate != nil,result == true{
            
            return self.foldDelegate!.foldTableView!(tableView: self, fontForTitleInSection: section);
        }
        
        return UIFont.boldSystemFont(ofSize: 16);
        
    }
    
    func titleColorForSection(section:Int) -> UIColor {
        
        let result = foldDelegate?.responds(to: #selector(foldDelegate?.foldTableView(tableView:textColorForTitleInSection:)));
        
        if self.foldDelegate != nil,result == true{
            
            return self.foldDelegate!.foldTableView!(tableView: self, textColorForTitleInSection: section);
        }
        return UIColor.black;
    }
    
    func descriptionForSection(section:Int) -> String {
        
        let result = foldDelegate?.responds(to: #selector(foldDelegate?.foldTableView(tableView:descriptionForHeaderInSection:)));
        
        if self.foldDelegate != nil,result == true{
            
            return self.foldDelegate!.foldTableView!(tableView: self, descriptionForHeaderInSection: section);
        }
        
        return String.init();
    }
    
    func descriptionFontForSection(section:Int) -> UIFont {
        
        
        let result = foldDelegate?.responds(to: #selector(foldDelegate?.foldTableView(tableView:fontForDescriptionInSection:)));
        
        if self.foldDelegate != nil,result == true{
            
            return self.foldDelegate!.foldTableView!(tableView: self, fontForDescriptionInSection: section);
        }
        
        return UIFont.boldSystemFont(ofSize: 13);
        
    }
    
    func descriptionColorForSection(section:Int) -> UIColor {
        
        
        let result = foldDelegate?.responds(to: #selector(foldDelegate?.foldTableView(tableView:textColorForDescriptionInSection:)));
        
        if self.foldDelegate != nil , result == true{
            
            return self.foldDelegate!.foldTableView!(tableView: self, textColorForDescriptionInSection: section);
        }
        
        return UIColor.white;
    }
    
    func arrowImageForSection(section:Int) -> UIImage {
        
        let result = foldDelegate?.responds(to: #selector(foldDelegate?.foldTableView(tableView:arrowImageForSection:)));
        
        if self.foldDelegate != nil , result == true{
            
            let image:UIImage = (self.foldDelegate?.foldTableView!(tableView: self, arrowImageForSection: section))!;
            
            return image;
        }
        
        return #imageLiteral(resourceName: "towards_white_open")
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        let result = foldDelegate?.responds(to: #selector(foldDelegate?.foldTableView(tableView:heightForRowAtIndexPath:)));
        
        if self.foldDelegate != nil,result == true{
            
            return self.foldDelegate!.foldTableView(tableView: self, heightForRowAtIndexPath: indexPath);
        }
        return self.rowHeight;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        let result = foldDelegate?.responds(to: #selector(foldDelegate?.numberOfSectionForFoldTableView(tableView:)));
        
        if self.foldDelegate != nil,result == true{
            
            return self.foldDelegate!.numberOfSectionForFoldTableView(tableView: self);
        }
        return self.numberOfSections;
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let model:FoldModel = self.viewModels[section] as! FoldModel;
        
        if model.state == true {
            
            let result = foldDelegate?.responds(to: #selector(foldDelegate?.foldTableView(tableView:numberOfRowsInSection:)));
            
            if self.foldDelegate != nil,result == true{
                
                return Int(self.foldDelegate!.foldTableView(tableView: self, numberOfRowsInSection: section));
            }
            
        }
        return 0;
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let result = foldDelegate?.responds(to: #selector(foldDelegate?.foldTableView(tableView:cellForRowAtIndexPath:)));
        
        if self.foldDelegate != nil,result==true{
            
            return self.foldDelegate!.foldTableView(tableView:self,cellForRowAtIndexPath:indexPath);
        }
        
        return UITableViewCell.init(style: .default, reuseIdentifier: "DefaultCellIndentifier");
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        let result = foldDelegate?.responds(to: #selector(foldDelegate?.foldTableView(tableView:heightForHeaderInSection:)));
        
        if self.foldDelegate != nil,result==true{
            
            return self.foldDelegate!.foldTableView(tableView:self,heightForHeaderInSection:section);
        }
        return self.sectionHeaderHeight;
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let model:FoldModel = self.viewModels[section] as! FoldModel;
        
        
        let shv = FoldSectionHeader.init(frame:CGRect(x:0,y:0,width:self.frame.size.width,height:self.tableView(self, heightForHeaderInSection: section)));
        shv.backgroundColor = model.bgColor;
        shv.title = model.title;
        shv.image = self.arrowImageForSection(section: section);
        
        shv.sectionState = model.state! ?.show:.flod;
        shv.titleColor = model.titleColor;
        shv.descrip = model.descrip;
        
        
        shv.headerClick = {[weak self](view:FoldSectionHeader)->Void in
            self?.headerActionWithSection(section: section, view: view);
        };
        
        self.headerViews?.add(shv);
        
        return shv;
        
    }
    
    
    func headerActionWithSection(section:Int,view:FoldSectionHeader) -> Void {
        
        self.beginUpdates();
        
        for (idx,obj) in self.viewModels.enumerated() {
            
            let model:FoldModel = obj as! FoldModel;
            
            if(model.state == true && (section != idx) && (self.otherIsClose == true)){
                model.state = false;
                model.bgColor = UIColor.white;
                model.titleColor = UIColor.black;
                
                let shv:FoldSectionHeader = self.headerViews![idx] as! FoldSectionHeader;
                shv.sectionState = .flod;
                shv.backgroundColor = UIColor.white;
                shv.titleColor = UIColor.black;
                
                self.deleteRows(at: self.deleteRowWithSection(section: idx) as! [IndexPath], with: .fade)
                
                break;
            }
        }
        
        let model:FoldModel = self.viewModels[section] as! FoldModel;
        let b:Bool = (model.state)!;
        
        if(b){
            self.deleteRows(at: self.deleteRowWithSection(section: section) as! [IndexPath], with: .fade)
        }else{
            self.insertRows(at: self.insertRowWithSection(section: section) as! [IndexPath], with: .fade);
        }
        
        model.state = b ? false:true;
        model.bgColor = (model.state)! ? self.clickBackgroundColor():UIColor.white;
        model.titleColor = (model.state)! ? self.clickTitleColor():UIColor.black;
        
        self.viewModels.replaceObject(at: section, with: model);
        
        view.backgroundColor = model.bgColor;
        view.titleColor = model.titleColor;
        
        self.headerViews?.replaceObject(at: section, with: view);
        
        self.endUpdates();
    }
    
    
    func insertRowWithSection(section:Int) -> NSMutableArray {
        
        let insert:Int = self.foldDelegate!.foldTableView(tableView: self, numberOfRowsInSection: section);
        
        let indexPaths = NSMutableArray.init();
        
        for i in 0..<insert {
            indexPaths.add(IndexPath.init(row: i, section: section))
        }
        
        return indexPaths;
        
    }
    
    func deleteRowWithSection(section:Int) -> NSMutableArray{
        
        let delete:Int = self.foldDelegate!.foldTableView(tableView: self, numberOfRowsInSection: section);
        
        let indexPaths = NSMutableArray.init();
        
        for i in 0..<delete {
            indexPaths.add(IndexPath.init(row: i, section: section))
        }
        
        return indexPaths;
    }
    
    var viewModels:NSMutableArray{
        get{
            if _viewModels == nil {
                _viewModels = NSMutableArray.init();
            }
            
            if (_viewModels!.count > 0) {
                if _viewModels!.count > self.numberOfSections{
                    _viewModels!.removeObjects(in: NSRange(location:self.numberOfSections-1,length:_viewModels!.count - self.numberOfSections));
                }else if (_viewModels!.count < self.numberOfSections){
                    let des = self.numberOfSections - _viewModels!.count;
                    let index = self.numberOfSections;
                    
                    for i in des..<index {
                        _viewModels!.add(creatModel(section: i));
                    }
                }
                
            }else{
                for i in 0..<self.numberOfSections {
                    
                    _viewModels!.add(creatModel(section: i));
                }
            }
            
            return _viewModels!;
        }
        
    }
    
    func creatModel(section:Int) -> FoldModel {
        let model = FoldModel.init();
        model.state = false;
        model.bgColor = self.backgroundColorForSection(section: section);
        model.titleColor = self.titleColorForSection(section: section);
        model.title = self.titleForSection(section: section);
        model.descrip = self.descriptionForSection(section: section);
        
        return model;
    }
    
    /** 默认打开的组(默认全部不打开)*/
    public var defOpenIdx:Int?{
        
        didSet{
            let model = self.viewModels[defOpenIdx!] as! FoldModel;
            model.state = true;
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }


}
