//
//  ZXConversationCell.swift
//  QQChat
//
//  Created by zhangxu on 16/8/4.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit


extension UIImage {
    
    class func resizeImage(imageName : String) -> UIImage {
        
        let image = UIImage(named: imageName);
        let imageW = (image?.size.width)! * 0.5;
        let imageH = (image?.size.height)! * 0.5;
        
        return (image?.resizableImageWithCapInsets(UIEdgeInsetsMake(imageH, imageW, imageH, imageW), resizingMode: UIImageResizingMode.Tile))!;
    }
}

class ZXConversationCell: UITableViewCell {
    
    private var timeLabel : UILabel!;// 发送时间
    private var icon : UIImageView!;// 头像
    private var contentButton : UIButton!;// 内容
    var conversationModel : ZXConversationModel? {
        
        didSet {
            
            // 获取可选类型中的数据
            guard let conversationModel = conversationModel else {
                
                return;
            }
            
            // 给发送时间赋值
            if conversationModel.time != nil {
                
                timeLabel.text = conversationModel.time;
            }
            
            // 给头像赋值
            if conversationModel.icon != nil {
                
                icon.image = UIImage(named: conversationModel.icon!);
            }
            
            // 给内容赋值
            if conversationModel.text != nil {
                
                contentButton.setTitle(conversationModel.text, forState: UIControlState.Normal);
            }
            
        }
    }
    
    
    // MARK: - 初始化
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        
        self.backgroundColor = UIColor.clearColor();
        
        // 发送时间
        timeLabel = UILabel();
        timeLabel.textColor = UIColor.grayColor();
        timeLabel.font = UIFont.systemFontOfSize(15);
        timeLabel.textAlignment = NSTextAlignment.Center;
        contentView.addSubview(timeLabel);
        
        
        // 头像
        icon = UIImageView();
        contentView.addSubview(icon);
        
        
        // 内容
        contentButton = UIButton(type : .Custom);
        contentButton.titleLabel?.font = UIFont.systemFontOfSize(RealValue(15));
        contentButton.titleLabel?.numberOfLines = 0;
        contentButton.contentEdgeInsets = UIEdgeInsetsMake(RealValue(15), RealValue(15), RealValue(15), RealValue(15));
        contentButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal);
        contentView.addSubview(contentButton);
        
        
    }
    
    
    // MARK: - 设置子控件的frame
    override func layoutSubviews() {
        
        super.layoutSubviews();
        
        if conversationModel!.type == 0 {
            
            conversationModel!.icon = "me.png";
        contentButton.setBackgroundImage(UIImage.resizeImage("chat_recive_nor@2x.png"), forState: UIControlState.Normal);
            
        } else if conversationModel!.type == 1 {
            
            conversationModel!.icon = "other.png";
        contentButton.setBackgroundImage(UIImage.resizeImage("chat_send_nor@2x.png"), forState: UIControlState.Normal);
        }
        
        // 设置时间的frame
        if conversationModel?.time != nil {
            
            let timeLabelX = RealValue(0);
            let timeLabelY = RealValue(0);
            let timeLabelW = bounds.size.width;
            let timeLabelH = RealValue(40);
            timeLabel.frame = CGRectMake(timeLabelX, timeLabelY, timeLabelW, timeLabelH);
            conversationModel?.cellHeight = timeLabelH;
        }
        
        // 设置头像的frame
        if conversationModel?.icon != nil {
            
            let iconW = RealValue(40);
            let iconH = iconW;
            let iconX = conversationModel?.type == 0 ? RealValue(10) : bounds.size.width - iconW - RealValue(10);
            let iconY = CGRectGetMaxY(timeLabel.frame);
            icon.frame = CGRectMake(iconX, iconY, iconW, iconH);
            conversationModel?.cellHeight = (conversationModel?.cellHeight)! + iconH;
            
        }
        
        // 设置内容的frame
        if conversationModel?.text != nil {
            
            let padding = RealValue(10);
            let contentButtonW = RealValue(200);
            let contentButtonY = CGRectGetMaxY(timeLabel.frame);
            let maxSize = CGSizeMake(contentButtonW, CGFloat(MAXFLOAT));
            let contentButtonTitle = contentButton.titleForState(UIControlState.Normal);
            let textSize = sizeWithFont((contentButton.titleLabel?.font)!, maxSize: maxSize, text: contentButtonTitle!);
            let realSize = CGSizeMake(textSize.width + RealValue(30), textSize.height + RealValue(30));
            let contentButtonX = conversationModel?.type == 0 ? CGRectGetMaxX(icon.frame) + padding : bounds.size.width - padding - RealValue(40) - padding - realSize.width;
            contentButton.frame = CGRectMake(contentButtonX, contentButtonY, realSize.width, realSize.height);
            conversationModel?.cellHeight = (conversationModel?.cellHeight)! + realSize.height;
        }
        
        
    }
    
    // 根据文字，字体获取size
    func sizeWithFont(font : UIFont , maxSize : CGSize , text : String) -> CGSize {
        
        var attrs = [String : AnyObject]();
        attrs[NSFontAttributeName] = font;
        let bounds = (text as NSString).boundingRectWithSize(maxSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attrs, context: nil);
        return bounds.size;
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
