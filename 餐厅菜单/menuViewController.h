//
//  menuViewController.h
//  餐厅菜单
//
//  Created by rimie27 on 14-1-11.
//  Copyright (c) 2014年 Wang Nan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResultViewController.h"
@interface menuViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
//存储初始数据
@property (nonatomic,strong) NSMutableDictionary *menuDic;
@property(nonatomic,strong)NSArray *nameAllKey;
@property(nonatomic,strong)NSMutableDictionary *priceDic;
//实现搜索功能
@property(nonatomic,strong)UISearchBar *searchBar;
@property(nonatomic,strong)UISearchDisplayController *searchDC;
//接收选择删除结果的数据
-(void)receiveUesrDeleteData:(NSString *)name;
@end
