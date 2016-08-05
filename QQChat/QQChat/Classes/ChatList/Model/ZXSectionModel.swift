//
//  ZXSectionModel.swift
//  QQChat
//
//  Created by zhangxu on 16/8/3.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class ZXSectionModel: NSObject {
    
    var friends : NSArray?;
    var name : String?;
    var online : NSNumber?;
    var section : NSInteger?;
    lazy var friendsArray : [ZXFriendModel] = [ZXFriendModel]();
    var isOpenSection : Bool = false;
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
        
    }

}
