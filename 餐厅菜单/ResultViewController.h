//
//  ResultViewController.h
//  餐厅菜单
//
//  Created by rimie27 on 14-1-11.
//  Copyright (c) 2014年 Wang Nan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "menuViewController.h"
@class menuViewController;
@interface ResultViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
//接收传过来的数组
@property(nonatomic,strong)NSMutableArray *resultImageArray;
@property(nonatomic,strong)NSMutableArray *resultNameArray;
@property(nonatomic,strong)NSMutableArray *resultPriceArray;

@property(nonatomic,assign)menuViewController *delegate;

-(void)displayResult;
@end
