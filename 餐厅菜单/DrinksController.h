//
//  DrinksController.h
//  餐厅菜单
//
//  Created by rimie27 on 14-1-11.
//  Copyright (c) 2014年 Wang Nan. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface DrinksController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray *drinkImage;
@property(nonatomic,strong)NSMutableArray *drinkName;
@property(nonatomic,strong)NSMutableArray *drinkPrice;
@end
