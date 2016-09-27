//
//  ZXConversationToobar.swift
//  QQChat
//
//  Created by zhangxu on 16/8/6.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class ZXConversationToobar: UIView {

    var voiceButton : UIButton!;// 语音
    var textField : UITextField!;// 输入框
    var emojiButton : UIButton!;// 表情
    var addButton : UIButton!;// 添加
    
    
    // MARK: - 初始化
    override init(frame: CGRect) {
        
        super.init(frame: frame);
        
        // 语音
        voiceButton = UIButton(type : .Custom);
        voiceButton.setImage(UIImage(named: "chat_bottom_voice_nor"), forState: UIControlState.Normal);
        voiceButton.setImage(UIImage(named: "chat_bottom_voice_press"), forState: UIControlState.Highlighted);
        addSubview(voiceButton);
        
        // 输入框
        textField = UITextField();
        textField.background = UIImage(named: "chat_bottom_textfield");
        textField.returnKeyType = UIReturnKeyType.Send;
        textField.enablesReturnKeyAutomatically = true;
        textField.borderStyle = UITextBorderStyle.None;
        textField.clearButtonMode = UITextFieldViewMode.WhileEditing;
        addSubview(textField);
        
        // 表情
        emojiButton = UIButton(type : .Custom);
        emojiButton.setImage(UIImage(named: "chat_bottom_smile_nor"), forState: UIControlState.Normal);
        emojiButton.setImage(UIImage(named: "chat_bottom_smile_press"), forState: UIControlState.Highlighted);
        addSubview(emojiButton);
        
        // 添加button
        addButton = UIButton(type : .Custom);
        addButton.setImage(UIImage(named: "chat_bottom_up_nor"), forState: UIControlState.Normal);
        addButton.setImage(UIImage(named: "chat_bottom_up_press"), forState: UIControlState.Highlighted);
        addSubview(addButton);
        
    }
    
    
    // MARK: - 设置子控件的frame
    override func layoutSubviews() {
        
        super.layoutSubviews();
        
        // 语音
        let voiceButtonX = RealValue(0);
        let voiceButtonY = RealValue(0);
        let voiceButtonW = RealValue(50);
        let voiceButtonH = RealValue(50);
        voiceButton.frame = CGRectMake(voiceButtonX, voiceButtonY, voiceButtonW, voiceButtonH);
        
        // 输入框
        let textFieldX = CGRectGetMaxX(voiceButton.frame);
        let textFieldY = RealValue(10);
        let textFieldW = RealValue(240);
        let textFieldH = RealValue(30);
        textField.frame = CGRectMake(textFieldX, textFieldY, textFieldW, textFieldH);
        
        // emoji
        let emojiButtonX = CGRectGetMaxX(textField.frame);
        let emojiButtonY = RealValue(0);
        let emojiButtonW = RealValue(40);
        let emojiButtonH = RealValue(50);
        emojiButton.frame = CGRectMake(emojiButtonX, emojiButtonY, emojiButtonW, emojiButtonH);
        
        // 添加
        let addButtonX = CGRectGetMaxX(emojiButton.frame);
        let addButtonY = RealValue(0);
        let addButtonW = RealValue(40);
        let addButtonH = RealValue(50);
        addButton.frame = CGRectMake(addButtonX, addButtonY, addButtonW, addButtonH);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
