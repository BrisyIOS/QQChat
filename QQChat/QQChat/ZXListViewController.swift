//
//  ZXListViewController.swift
//  QQChat
//
//  Created by zhangxu on 16/8/3.
//  Copyright © 2016年 zhangxu. All rights reserved.


import UIKit

class ZXListViewController: UIViewController , UITableViewDataSource, UITableViewDelegate , ZXSectionHeaderViewDelegate {
    
    // cell标识常量
    let cellIdentifier = "cellIdentifier";
    let sectionHeaderIdentifier = "sectionHeaderIdentifier";
    private var tableView : UITableView!;
    private lazy var sectionArray : [ZXSectionModel] = [ZXSectionModel]();// 懒加载

    // MARK: - 视图加载完毕的时候调用此方法
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "我的好友列表";
        
        view.backgroundColor = UIColor.redColor();
        
        // 添加tableView 
        tableView = UITableView.init(frame: CGRectZero, style: UITableViewStyle.Grouped);
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.rowHeight = RealValue(50);
        self.view.addSubview(tableView);

        
        // 注册header
        tableView.registerClass(ZXSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: sectionHeaderIdentifier);
        
        // 注册cell
        tableView.registerClass(ZXFriendCell.self, forCellReuseIdentifier: cellIdentifier);
        
        // 解析plist文件
        parseData();
        
    }
    
    // MARK: - 解析friends.plist文件
    func parseData() -> Void {
        
        let url = NSBundle.mainBundle().URLForResource("friends.plist", withExtension: nil);
        let sectionArray = NSArray.init(contentsOfURL:url!);
        for dic in sectionArray! {
            
            let dic = dic as![String : AnyObject];
            let model = ZXSectionModel();
            model.setValuesForKeysWithDictionary(dic);
            var friendsArray : [ZXFriendModel] = [ZXFriendModel]();
            for friendDic in model.friends! {
                
                let friendDic = friendDic as![String : AnyObject];
                let friendModel = ZXFriendModel();
                friendModel.setValuesForKeysWithDictionary(friendDic);
                friendsArray.append(friendModel);
            }
            model.friendsArray = friendsArray;
            self.sectionArray.append(model);
        }
        
    }
    
    // MARK: - 返回组数
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return sectionArray.count;
    }
    
    // MARK: - 返回行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let sectionModel = sectionArray[section];
        let friendsArray = sectionModel.friends;
        return sectionModel.isOpenSection ? (friendsArray?.count)! : 0;
    }
    
    // MARK: - 返回cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ZXFriendCell;
        let sectionModel = sectionArray[indexPath.section];
        let friendsArray = sectionModel.friendsArray;
        let friendModel = friendsArray[indexPath.row];
        cell.friendModel = friendModel;
        
        return cell;
    }
    
    // MARK: - 返回sectionHeader高度
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 50;
    }
    
    // MARK: - 返回表尾高度
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0.01;
    }
    
 
    // MARK: - 自定义header
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionModel = sectionArray[section];
        sectionModel.section = section;
        let header = tableView.dequeueReusableHeaderFooterViewWithIdentifier(sectionHeaderIdentifier) as!ZXSectionHeaderView;
        header.delegate = self;
        header.sectionModel = sectionModel;
        
        if sectionModel.isOpenSection == true {
            
            header.icon.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2));
        } else {
            header.icon.transform = CGAffineTransformIdentity;
        }
        
        return header;
        
    }
    
    // MARK: - 实现点击header协议
    func clickHeadView(section: NSInteger) {
        
        // 刷新表格
        self.tableView.reloadSections(NSIndexSet.init(index: section), withRowAnimation: UITableViewRowAnimation.Fade);
    }
    
    // MARK: - 选中cell跳转到详情对话页面
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true);
        
        let conversationVc = ZXConversationController();
        navigationController?.pushViewController(conversationVc, animated: true);
        
    }
    
    
    // MARK: - 设置子控件的frame
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews();
        
        // 设置tableView 的frame
        tableView.frame = self.view.bounds;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
