//
//  SwiftHeader.swift
//  QQChat
//
//  Created by zhangxu on 16/8/4.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import Foundation
import UIKit


// 屏幕宽度
let kScreenWidth = UIScreen.mainScreen().bounds.size.width;
// 屏幕高度
let kScreenHeight = UIScreen.mainScreen().bounds.size.height;

// RGB
func RGB(r : CGFloat , g : CGFloat , b : CGFloat) -> UIColor {
    
    let color = UIColor.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1);
    return color;
}


func RealValue(value : CGFloat) -> CGFloat {
    
    let realValue = value / 375 * kScreenWidth;
    
    return realValue;
}