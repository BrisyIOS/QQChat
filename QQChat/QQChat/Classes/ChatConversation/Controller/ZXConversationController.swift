//
//  ZXConversationController.swift
//  QQChat
//
//  Created by zhangxu on 16/8/4.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class ZXConversationController: UIViewController , UITableViewDataSource,  UITableViewDelegate , UITextFieldDelegate {
    
    // cell标识常量
    private let cellIdentifier = "cellIdentifier";
    
    private var tableView : UITableView!;
    private var conversationToobar : ZXConversationToobar!;
    private lazy var conversationArray : [ZXConversationCellFrameModel] = [ZXConversationCellFrameModel]();
    
    deinit {
        
        // 移除通知
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.redColor();
        
        // 添加tableView
        tableView = UITableView.init(frame: CGRectZero, style: UITableViewStyle.Plain);
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.backgroundColor = RGB(235, g: 235, b: 235);
        tableView.allowsSelection = false;
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None;
        self.view.addSubview(tableView);
        // 添加轻拍手势
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapAction));
        tableView.addGestureRecognizer(tap);
        
        // 添加toolbar
        conversationToobar = ZXConversationToobar();
        conversationToobar.textField.delegate = self;
        conversationToobar.backgroundColor = RGB(235, g: 235, b: 235);
        self.view.addSubview(conversationToobar);
        
        
        // 注册cell
        tableView.registerClass(ZXConversationCell.self, forCellReuseIdentifier: cellIdentifier);
        
        // 解析数据
        parseData();
        
        // 添加通知监听键盘的弹出和隐藏
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil);

    }
    
    // MARK: - 键盘弹出
    func keyboardWillShow(notification : NSNotification) -> Void {
        
        // 键盘弹出需要的时间
        let duration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey]?.doubleValue;
        // 动画
        UIView.animateWithDuration(duration!) {
            
            // 取出键盘高度
            let keyboardF = notification.userInfo![UIKeyboardFrameEndUserInfoKey]?.CGRectValue();
            let keyboardH = keyboardF?.size.height;
            self.view.transform = CGAffineTransformMakeTranslation(0, -keyboardH!);
            
        }
    }
    
    // MARK: - 键盘隐藏
    func keyboardWillHide(notification : NSNotification) -> Void {
        
        // 键盘弹出需要的时间
        let duration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey]?.doubleValue;
        
        // 动画
        UIView.animateWithDuration(duration!) {
            
            self.view.transform = CGAffineTransformIdentity;
        }
    }
    
    // MARK: - 轻拍手势
    func tapAction() -> Void {
        // 取消第一响应者
        conversationToobar.textField.resignFirstResponder();
    }
    
    // MARK: - 解析plist文件
    func parseData() -> Void {
        
        let url = NSBundle.mainBundle().URLForResource("messages.plist", withExtension: nil);
        let plistArray = NSArray.init(contentsOfURL: url!);
        
        for plistDic in plistArray! {
            
            let model = ZXConversationModel();
            model.setValuesForKeysWithDictionary(plistDic as! [String : AnyObject]);
            let lastModel = self.conversationArray.last;
            let cellFrameModel = ZXConversationCellFrameModel();
            if model.time == lastModel?.conversationModel?.time {
                
                model.isShowTime = false;
            } else {
                
                model.isShowTime = true;
            }
            
            cellFrameModel.conversationModel = model;
            self.conversationArray.append(cellFrameModel);
            
        }
    }

    
    // MARK: - return键
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        // 取出最后一条数据
        let lastTime = conversationArray.last?.conversationModel?.time;
        
        // 设置发送时间
        let sendDate = NSDate();
        let dateFormatter = NSDateFormatter();
        dateFormatter.dateFormat = "HH:mm";
        let locationTime = dateFormatter.stringFromDate(sendDate);
        
        let model = ZXConversationModel();
        model.time = locationTime;
        model.text = conversationToobar.textField.text;
        model.type = 1;
        let cellFrameModel = ZXConversationCellFrameModel();
        model.isShowTime = (lastTime == locationTime) ? false : true;
        cellFrameModel.conversationModel = model;
        conversationArray.append(cellFrameModel);
      
        // 刷新UI
        tableView.reloadData();
        
        // 让数据回滚到最后一行
        let indexPath = NSIndexPath.init(forRow: conversationArray.count - 1, inSection: 0);
        tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true);
   
        return true;
    }
    
    
    // MARK: - 返回cell高度
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let model = conversationArray[indexPath.row];
        return model.cellHeight!;
        
    }
    
    // MARK: - 返回行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return conversationArray.count;
    }
    
    // MARK: - 返回cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as!ZXConversationCell;
        cell.selectionStyle = UITableViewCellSelectionStyle.None;
        let cellFrameModel = conversationArray[indexPath.row];
        cell.cellFrameModel = cellFrameModel;
        return cell;
    }
  
    
    // MARK: - 设置子控件的frame
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews();
        
        let tableViewX = RealValue(0);
        let tableViewY = RealValue(0);
        let tableViewW = self.view.bounds.width;
        let tableViewH = self.view.bounds.height - RealValue(50);
        tableView.frame = CGRectMake(tableViewX, tableViewY, tableViewW, tableViewH);
        
        
        // 设置toolbar的frame
        let conversationToobarX = RealValue(0);
        let conversationToobarY = CGRectGetMaxY(tableView.frame);
        let conversationToobarW = tableViewW;
        let conversationToobarH = RealValue(50);
        conversationToobar.frame = CGRectMake(conversationToobarX, conversationToobarY, conversationToobarW, conversationToobarH);
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
}
