//
//  FoldSectionHeader.swift
//  FoldTableView
//
//  Created by Mjwon on 2017/7/13.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import UIKit

public enum FoldingSectionState : Int{
    
    case flod // 折叠
    
    case show // 打开
    
}

class FoldSectionHeader: UIView {

    typealias SectionHeaderClick = (FoldSectionHeader) -> Void;
    var headerClick:SectionHeaderClick?;
    
    var FoldingSepertorLineWidth = 0.3;
    var FoldingMargin = 8.0;
    var FoldingIconSize = 24.0;
    
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.layer.borderWidth = 0.4;
        self.layer.borderColor = UIColor.lightGray.cgColor;
        self.setupSubviewsWithArrowPosition();
        
    }
    
    
    func setupSubviewsWithArrowPosition() -> Void {
        
        let labelWidth:CGFloat = CGFloat((Double(self.frame.size.width) - FoldingMargin*2 - FoldingIconSize)/2);
        
        let labelHeight:CGFloat = self.frame.size.height;
        
        let arrowRt = XCGRect(x:CGFloat(Double(self.frame.size.width)-FoldingIconSize-10), y:CGFloat((Double(self.frame.size.height) - FoldingIconSize)/2), width:CGFloat(FoldingIconSize), height:CGFloat(FoldingIconSize));
        
        let titleRt = XCGRect(x:CGFloat(FoldingMargin), y:0, width:labelWidth, height:labelHeight);
        
        let descriptionRt = XCGRect(x:CGFloat(FoldingMargin) + labelWidth,  y:0, width:labelWidth, height:labelHeight);
        
        self.titleLabel.frame = titleRt;
        
        self.descriptionLabel.frame = descriptionRt;
        
        self.arrowImageView.frame = arrowRt;
        
        self.addSubview(self.titleLabel);
        self.addSubview(self.descriptionLabel);
        self.addSubview(self.arrowImageView);
    }
    
    public var sectionState:FoldingSectionState?{
        
        didSet{
            arrowImageViewAnimate();
        }
    }
    public var title:String?{
        
        didSet{
            self.titleLabel.text = title;
        }
    }
    public var image:UIImage?{
        
        didSet{
            
            self.arrowImageView.image = image;
        }
    }
    public var descrip:String?{
        
        didSet{
            self.descriptionLabel.text = descrip;
        }
        
    }
    public var titleColor:UIColor?{
        
        didSet{
            self.titleLabel.textColor = titleColor;
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if (self.headerClick != nil) {
            self.headerClick!(self);
        }
        
        if self.sectionState == .flod {
            self.sectionState = .show;
        }else{
            self.sectionState = .flod;
        }
        shouldExpand();
    }
    
    func arrowImageViewAnimate() -> Void {
        if sectionState == .show {
            self.arrowImageView.transform = CGAffineTransform(rotationAngle: 0);
        }else{
            self.arrowImageView.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/2));
        }
    }
    
    func shouldExpand() -> Void {
        UIView.animate(withDuration: 0.25) {
            self.arrowImageViewAnimate();
        }
    }
    
    lazy private var descriptionLabel:UILabel = {
        let des = UILabel.init(frame: .zero);
        des.textAlignment = .right;
        des.backgroundColor = UIColor.clear;
        
        return des;
    }();
    
    lazy private var titleLabel:UILabel = {
        let t = UILabel.init(frame: .zero);
        t.textAlignment = .left;
        t.backgroundColor = UIColor.clear;
        
        return t;
    }();
    
    lazy private var arrowImageView:UIImageView = {
        
        let arrow = UIImageView.init(frame: .zero);
        arrow.backgroundColor = UIColor.clear;
        arrow.isUserInteractionEnabled = true;
        arrow.contentMode = .scaleAspectFit;
        
        return arrow;
    }();
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func XCGRect(x:CGFloat,y:CGFloat,width:CGFloat,height:CGFloat) -> CGRect {
        
        return CGRect(x:x,y :y,width: width,height: height);
    }

}
