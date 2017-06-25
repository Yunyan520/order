//
//  DrinksController.m
//  餐厅菜单
//
//  Created by rimie27 on 14-1-11.
//  Copyright (c) 2014年 Wang Nan. All rights reserved.
//

#import "DrinksController.h"

@interface DrinksController ()
{
    UITableView *bTableView;
    CALayer *transitionLayer;
}
@end

@implementation DrinksController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem.title=@"饮料";
        self.tabBarItem.image=[UIImage imageNamed:@"item2"];
        transitionLayer=[[CALayer alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self initalizeDrinksSundryData];
    bTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, 320, 480)];
    bTableView.delegate=self;
    bTableView.dataSource=self;
    [self.view addSubview:bTableView];
    //标题背景
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 25, 320, 40)];
    imageView.image=[UIImage imageNamed:@"menucloud1"];
    [self.view addSubview:imageView];
    //购物车
    UIImageView *shopCarImage=[[UIImageView alloc]initWithFrame:CGRectMake(260, 20, 36, 36)];
    shopCarImage.image=[UIImage imageNamed:@"shopCar"];
    [self.view addSubview:shopCarImage];
}
#pragma mark -  UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return _drinkName.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];

    cell.imageView.image=[UIImage imageNamed:[_drinkImage objectAtIndex:indexPath.row]];
    cell.textLabel.text=[_drinkName objectAtIndex:indexPath.row];
    cell.detailTextLabel.text=[_drinkPrice objectAtIndex:indexPath.row];
    UIImageView *identifierImage=[[UIImageView alloc]initWithFrame:CGRectMake(260, 6, 36, 36)];
        identifierImage.image=[UIImage imageNamed:@"identifier"];
        identifierImage.tag=100+indexPath.row;
        identifierImage.hidden=YES;
        [cell addSubview:identifierImage];
        return cell;
}
#pragma mark - UITableViewDelegate
//单击cell触发
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIImageView *image=(UIImageView *)[bTableView viewWithTag:100+indexPath.row];
    
    NSLog(@"index%d",100+indexPath.row);
    
    if (image.hidden==YES)
    {
        image.hidden=NO;
        //图片旋转
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        UITableViewCell *aCell = [tableView cellForRowAtIndexPath:indexPath];
        [CATransaction begin];
        [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
        transitionLayer.opacity = 1.0;
        transitionLayer.contents = (id)aCell.imageView.image.CGImage;
        transitionLayer.frame = [[UIApplication sharedApplication].keyWindow convertRect:aCell.imageView.bounds fromView:aCell.imageView];
        [[UIApplication sharedApplication].keyWindow.layer addSublayer:transitionLayer];
        [CATransaction commit];
        
        CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
        positionAnimation.fromValue = [NSValue valueWithCGPoint:transitionLayer.position];
        positionAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(300, 30)];
        
        CABasicAnimation *boundsAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
        boundsAnimation.fromValue = [NSValue valueWithCGRect:transitionLayer.bounds];
        boundsAnimation.toValue = [NSValue valueWithCGRect:CGRectZero];
        
        CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        opacityAnimation.fromValue = [NSNumber numberWithFloat:1.0];
        opacityAnimation.toValue = [NSNumber numberWithFloat:0.2];
        
        CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotateAnimation.fromValue = [NSNumber numberWithFloat:0 * M_PI];
        rotateAnimation.toValue = [NSNumber numberWithFloat:2 * M_PI];
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.beginTime = CACurrentMediaTime() + 0.05;
        group.duration = 1;
        group.animations = [NSArray arrayWithObjects:positionAnimation, boundsAnimation, opacityAnimation, rotateAnimation, nil];
        group.delegate = self;
        group.fillMode = kCAFillModeForwards;
        group.removedOnCompletion = NO;
        [transitionLayer addAnimation:group forKey:@"move"];
    }
    else
    {
        image.hidden=YES;
    }
}
-(void)initalizeDrinksSundryData
{
    _drinkImage=[[NSMutableArray alloc]initWithObjects:@"drink1",@"drink2",@"drink3",@"drink4",@"drink5", nil];
    _drinkName=[[NSMutableArray alloc]initWithObjects:@"可乐",@"要你命3000",@"咖啡",@"正宗可乐",@"橙汁", nil];
    //_drinkPrice=[[NSMutableArray alloc]initWithObjects:@[@"20",@"10",@"30",@"24",@"22",], nil];
    _drinkPrice=[NSMutableArray arrayWithObjects:@"20",@"10",@"30",@"24",@"22", nil];
    
}
//当切换页面时存储数据
-(void)viewWillDisappear:(BOOL)animated
{
    NSMutableArray *saveDrinksImage=[[NSMutableArray alloc]init];
    NSMutableArray *saveDrinksName=[[NSMutableArray alloc]init];
    NSMutableArray *saveDrinksPrice=[[NSMutableArray alloc]init];
    
    for (int i=0; i<_drinkName.count; i++)
    {
        UIImageView *image=(UIImageView *)[bTableView viewWithTag:100+i];
        if (image.hidden==NO)
        {
            [saveDrinksImage addObject:[_drinkImage objectAtIndex:i]];
            [saveDrinksName addObject:[_drinkName objectAtIndex:i]];
            [saveDrinksPrice addObject:[_drinkPrice objectAtIndex:i]];
        }
    }
    NSString *path=[NSString stringWithFormat:@"%@/Documents",NSHomeDirectory()];
    NSString *drinksimage=[path stringByAppendingPathComponent:@"drinksImage.plist"];
    NSString *drinksName=[path stringByAppendingPathComponent:@"drinksName.plist"];
    NSString *drinksPrice=[path stringByAppendingPathComponent:@"drinksPrice.plist"];
    [saveDrinksImage writeToFile:drinksimage atomically:YES];
    [saveDrinksName writeToFile:drinksName atomically:YES];
    [saveDrinksPrice writeToFile:drinksPrice atomically:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
