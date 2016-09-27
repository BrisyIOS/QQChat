//
//  ZXConversationCellFrameModel.swift
//  QQChat
//
//  Created by zhangxu on 16/8/23.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class ZXConversationCellFrameModel: NSObject {
    
    
    var timeLabelF : CGRect? = CGRectZero;
    var iconF : CGRect? = CGRectZero;
    var contentButtonF : CGRect? = CGRectZero;
    var cellHeight : CGFloat? = 0;
    var conversationModel : ZXConversationModel? {
        
        didSet {
            
            guard let conversationModel = conversationModel else {
                
                return;
            }
           
            // 设置发送时间
            let timeLabelX = RealValue(0);
            let timeLabelY = RealValue(0);
            let timeLabelW = kScreenWidth;
            let timeLabelH = RealValue(40);
            timeLabelF = CGRectMake(timeLabelX, timeLabelY, timeLabelW, timeLabelH);
            if conversationModel.isShowTime == false {
                
                timeLabelF = CGRectZero;
            }
        
           
            // 设置头像
            let iconW = RealValue(40);
            let iconH = iconW;
            let iconX = conversationModel.type == 0 ? RealValue(10) : kScreenWidth - iconW - RealValue(10);
            let iconY = conversationModel.isShowTime == true ? CGRectGetMaxY(timeLabelF!) : 0;
            iconF = CGRectMake(iconX, iconY, iconW, iconH);
            
            // 设置内容
            if conversationModel.text != nil {
                
                let padding = RealValue(10);
                let contentButtonW = RealValue(200);
                let contentButtonY = conversationModel.isShowTime == true ? CGRectGetMaxY(timeLabelF!) : 0;
                let maxSize = CGSizeMake(contentButtonW, CGFloat(MAXFLOAT));
                let textSize = sizeWithFont(UIFont.systemFontOfSize(RealValue(15)), maxSize: maxSize, text: conversationModel.text!);
                let realSize = CGSizeMake(textSize.width + RealValue(30), textSize.height + RealValue(30));
                let contentButtonX = conversationModel.type == 0 ? CGRectGetMaxX(iconF!) + padding : kScreenWidth - padding - RealValue(40) - padding - realSize.width;
                contentButtonF = CGRectMake(contentButtonX, contentButtonY, realSize.width, realSize.height);
            
            }
            
            // 设置cellHeight
            cellHeight = maxValue(CGRectGetMaxY(timeLabelF!), value2: CGRectGetMaxY(iconF!), value3: CGRectGetMaxY(contentButtonF!)) + RealValue(10);
        }
    };
    
    func maxValue(value1 : CGFloat , value2 : CGFloat , value3 : CGFloat) -> CGFloat {
        
        var max : CGFloat = 0;
        max = value1 > max ? value1 : max;
        max = value2 > max ? value2 : max;
        max = value3 > max ? value3 : max;
        
        return max;
    }
    
    // 根据文字，字体获取size
    func sizeWithFont(font : UIFont , maxSize : CGSize , text : String) -> CGSize {
        
        var attrs = [String : AnyObject]();
        attrs[NSFontAttributeName] = font;
        let bounds = (text as NSString).boundingRectWithSize(maxSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attrs, context: nil);
        return bounds.size;
    }

}
