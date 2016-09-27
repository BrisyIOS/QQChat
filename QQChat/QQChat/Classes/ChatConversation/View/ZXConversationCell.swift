//
//  ZXConversationCell.swift
//  QQChat
//
//  Created by zhangxu on 16/8/4.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit


extension UIImage {
    
    class func stretchableImage(imageName : String) -> UIImage {
        
        let image = UIImage(named: imageName);
        let imageW = (image?.size.width)! * 0.5;
        let imageH = (image?.size.height)! * 0.7;
        return (image?.stretchableImageWithLeftCapWidth(NSInteger(imageW), topCapHeight: NSInteger(imageH)))!;
    }
}

class ZXConversationCell: UITableViewCell {
    
    private var timeLabel : UILabel!;// 发送时间
    private var icon : UIImageView!;// 头像
    private var contentButton : UIButton!;// 内容
    var cellFrameModel : ZXConversationCellFrameModel? {
        
        didSet {
            
            guard let cellFrameModel = cellFrameModel else {
                
                return;
            }
       
            // 设置时间
            timeLabel.frame = cellFrameModel.timeLabelF!;
            timeLabel.text = cellFrameModel.conversationModel?.time;
            
            // 设置头像
            icon.frame = cellFrameModel.iconF!;
            icon.image = cellFrameModel.conversationModel?.type == 0 ? UIImage(named : "me.png") : UIImage(named: "other.png");
            
            // 设置内容
            contentButton.frame = cellFrameModel.contentButtonF!;
            contentButton.setTitle(cellFrameModel.conversationModel?.text, forState: UIControlState.Normal);
            contentButton.setBackgroundImage(UIImage.stretchableImage(cellFrameModel.conversationModel?.type == 0 ? "chat_recive_nor@2x.png" : "chat_send_nor@2x.png"), forState: UIControlState.Normal);
          
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
        contentButton.titleLabel?.adjustsFontSizeToFitWidth;
        contentButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal);
        contentView.addSubview(contentButton);

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
