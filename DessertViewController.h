//
//  DessertViewController.h
//  餐厅菜单
//
//  Created by rimie27 on 14-1-11.
//  Copyright (c) 2014年 Wang Nan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DessertViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray *dessertImage;
@property(nonatomic,strong)NSMutableArray *dessertName;
@property(nonatomic,strong)NSMutableArray *dessertPrice;
@end
