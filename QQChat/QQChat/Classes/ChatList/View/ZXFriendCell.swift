//
//  ZXFriendCell.swift
//  QQChat
//
//  Created by zhangxu on 16/8/4.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class ZXFriendCell: UITableViewCell {
    
    private var icon : UIImageView!;// 头像
    private var introLabel : UILabel!;// 个性签名
    private var nameLabel : UILabel!// 昵称
    
    var friendModel : ZXFriendModel? {
        
        didSet {
            
           
            // 获取可选类型中的数据
            guard let friendModel = friendModel else {
                
                return;
            }
           
            print(friendModel.intro);
            
            // 给头像赋值
            icon.image = UIImage(named: "other");
            // 给个性签名赋值
            introLabel.text = friendModel.intro!;
            // 给昵称赋值
            nameLabel.text = friendModel.name!;
     
        }
    };
    
    
    // MARK: - 初始化
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        
        // 头像
        icon = UIImageView();
        contentView.addSubview(icon);
        
        // 个性签名
        introLabel = UILabel();
        introLabel.textColor = UIColor.blackColor();
        introLabel.textAlignment = NSTextAlignment.Left;
        introLabel.font = UIFont.systemFontOfSize(RealValue(20));
        contentView.addSubview(introLabel);
        
        
        // 昵称
        nameLabel = UILabel();
        nameLabel.textColor = UIColor.blackColor();
        nameLabel.font = UIFont.systemFontOfSize(RealValue(15));
        nameLabel.textAlignment = NSTextAlignment.Left;
        contentView.addSubview(nameLabel);
        
        
        
    }
    
    
    // MARK: - 设置子控件的frame
    override func layoutSubviews() {
        
        super.layoutSubviews();
        
        let padding = RealValue(5);
        
        // 设置头像的frame
        let iconX = padding * 2;
        let iconY = padding * 2;
        let iconW = RealValue(30);
        let iconH = iconW;
        icon.frame = CGRectMake(iconX, iconY, iconW, iconH);
        
        // 设置个性签名
        let introLabelX = CGRectGetMaxX(icon.frame) + padding * 2;
        let introLabelY = padding;
        let introLabelW = bounds.size.width - iconW * 2;
        let introLabelH = RealValue(25);
        introLabel.frame = CGRectMake(introLabelX, introLabelY, introLabelW, introLabelH);
        
        // 昵称
        let nameLabelX = introLabelX;
        let nameLabelY = CGRectGetMaxY(introLabel.frame);
        let nameLabelW = introLabelW;
        let nameLabelH = RealValue(15);
        nameLabel.frame = CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
        
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
