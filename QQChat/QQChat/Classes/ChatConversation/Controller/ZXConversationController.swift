//
//  ZXConversationController.swift
//  QQChat
//
//  Created by zhangxu on 16/8/4.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class ZXConversationController: UIViewController , UITableViewDataSource,  UITableViewDelegate {
    
    // cell标识常量
    private let cellIdentifier = "cellIdentifier";
    
    private var tableView : UITableView!;
    private lazy var conversationArray : [ZXConversationModel] = [ZXConversationModel]();

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.redColor();
        
        // 添加tableView
        tableView = UITableView.init(frame: CGRectZero, style: UITableViewStyle.Plain);
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.backgroundColor = RGB(235, g: 235, b: 235);
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None;
        self.view.addSubview(tableView);
        
        
        // 注册cell
        tableView.registerClass(ZXConversationCell.self, forCellReuseIdentifier: cellIdentifier);
        
        // 解析数据
        parseData();

    }
    
    // MARK: - 解析plist文件
    func parseData() -> Void {

        
        //线程间通信
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
            // 在子线程做一些事情
            let url = NSBundle.mainBundle().URLForResource("messages.plist", withExtension: nil);
            let plistArray = NSArray.init(contentsOfURL: url!);
            
            for plistDic in plistArray! {
                
                let model = ZXConversationModel();
                model.setValuesForKeysWithDictionary(plistDic as! [String : AnyObject]);
                self.conversationArray.append(model);
                
            }
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                //在主线程更新UI...
                self.tableView.reloadData();
            })
        }
        
    }
    
    // MARK: - 返回cell高度
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let model = conversationArray[indexPath.row];
        
        guard let height = model.cellHeight else {
            
            return 0;
        }
        
        return height;
        
    }
    
    // MARK: - 返回行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return conversationArray.count;
    }
    
    // MARK: - 返回cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as!ZXConversationCell;
        cell.selectionStyle = UITableViewCellSelectionStyle.None;
        cell.conversationModel = conversationArray[indexPath.row];
        
        return cell;
    }
    
    
    // MARK: - 设置子控件的frame
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews();
        
        tableView.frame = self.view.bounds;
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
