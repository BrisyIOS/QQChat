//
//  ZXSectionHeaderView.swift
//  QQChat
//
//  Created by zhangxu on 16/8/3.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

protocol ZXSectionHeaderViewDelegate : NSObjectProtocol {
    
    func clickHeadView(section : NSInteger);// 是否打开分组
}

class ZXSectionHeaderView: UITableViewHeaderFooterView {
    
    var icon : UIImageView!;
    private var nameLabel : UILabel!;
    weak var delegate : ZXSectionHeaderViewDelegate?;
    var sectionModel : ZXSectionModel? {
        
        didSet {
            
            // 获取可选类型中的数据
            guard let sectionModel = sectionModel else {
                
                return;
            }
            
            nameLabel.text = sectionModel.name;
        }
    };
    
    
    override init(reuseIdentifier: String?) {
        
        super.init(reuseIdentifier: reuseIdentifier);
        
        
        // icon 
        icon = UIImageView();
        icon.image = UIImage(named: "right.png");
        contentView.addSubview(icon);
        
        // name
        nameLabel = UILabel();
        nameLabel.text = "我的好友";
        nameLabel.userInteractionEnabled = true;
        nameLabel.textColor = UIColor.blackColor();
        nameLabel.textAlignment = NSTextAlignment.Left;
        nameLabel.font = UIFont.systemFontOfSize(RealValue(25));
        contentView.addSubview(nameLabel);
        
        // 给nameLabel添加手势
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapAction(_:)));
        nameLabel.addGestureRecognizer(tap);
        
        
        
    }
    
    // MARK: - 轻拍手势
    func tapAction(tap : UITapGestureRecognizer) -> Void {
        
        sectionModel?.isOpenSection = !(sectionModel?.isOpenSection)!;
        
        if self.delegate != nil {
            
            self.delegate?.clickHeadView((sectionModel?.section)!);
        }
    }
    
    // MARK: - 设置子控件的frame
    override func layoutSubviews() {
        
        super.layoutSubviews();
        
        let padding = RealValue(10);
        
        // 设置icon的frame
        let iconCenterX = padding * 2;
        let iconCenterY = bounds.size.height / 2;
        let iconW = padding * 2;
        let iconH = iconW;
        icon.center = CGPointMake(iconCenterX, iconCenterY);
        icon.bounds = CGRectMake(0, 0, iconW, iconH);
      
        
        
        // 设置name 的frame
        let nameLabelX = CGRectGetMaxX(icon.frame) + padding;
        let nameLabelY = padding;
        let nameLabelW = bounds.size.width - RealValue(50);
        let nameLabelH = padding * 3;
        nameLabel.frame = CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
