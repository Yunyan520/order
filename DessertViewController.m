//
//  DessertViewController.m
//  餐厅菜单
//
//  Created by rimie27 on 14-1-11.
//  Copyright (c) 2014年 Wang Nan. All rights reserved.
//

#import "DessertViewController.h"
#import "ResultViewController.h"
@interface DessertViewController ()
{
    UITableView *cTableView;
    ResultViewController *result;
    CALayer *transitionLayer;
}
@end

@implementation DessertViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem.title=@"点心";
        self.tabBarItem.image=[UIImage imageNamed:@"item4"];
        transitionLayer=[[CALayer alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.edgesForExtendedLayout=UIRectEdgeNone;
    
    //初始化一些数组数据
    [self initalizeDessertSundryData];
    //初始化TableView;
    cTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, 320, 480-64)];
    cTableView.delegate=self;
    cTableView.dataSource=self;
    [self.view addSubview:cTableView];
    
    //添加标题背景
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 20, 320, 40)];
    imageview.image=[UIImage imageNamed:@"menucloud1"];
    [self.view addSubview:imageview];
    //购物车
    UIImageView *shopCarImage=[[UIImageView alloc]initWithFrame:CGRectMake(260, 20, 36, 36)];
    shopCarImage.image=[UIImage imageNamed:@"shopCar"];
    [self.view addSubview:shopCarImage];
    //完成按钮
    UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame=CGRectMake(190, 30, 80, 30);
    button.layer.cornerRadius=10;
    [button addTarget:self action:@selector(Finish) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"完成" forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont systemFontOfSize:20];
    [self.view addSubview:button];
}

//导航栏完成按钮
-(void)Finish
{
   result=[[ResultViewController alloc]init];
    [self presentViewController:result animated:YES completion:nil];
}

#pragma mark -  UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dessertName.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    
    cell.imageView.image=[UIImage imageNamed:[_dessertImage objectAtIndex:indexPath.row]];
    cell.textLabel.text=[_dessertName objectAtIndex:indexPath.row];
    cell.detailTextLabel.text=[_dessertPrice objectAtIndex:indexPath.row];
    UIImageView *identifierImage=[[UIImageView alloc]initWithFrame:CGRectMake(280, 6, 36, 36)];
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
    UIImageView *image=(UIImageView *)[cTableView viewWithTag:100+indexPath.row];
    
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
        positionAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(275, 30)];
        
        CABasicAnimation *boundsAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
        boundsAnimation.fromValue = [NSValue valueWithCGRect:transitionLayer.bounds];
        boundsAnimation.toValue = [NSValue valueWithCGRect:CGRectZero];
        
        CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        opacityAnimation.fromValue = [NSNumber numberWithFloat:1.0];
        opacityAnimation.toValue = [NSNumber numberWithFloat:0.2];
        
        CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotateAnimation.fromValue = [NSNumber numberWithFloat:0 * M_PI];
        rotateAnimation.toValue = [NSNumber numberWithFloat:4 * M_PI];
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.beginTime = CACurrentMediaTime() + 0.25;
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
-(void)initalizeDessertSundryData
{
    _dessertImage=[[NSMutableArray alloc]initWithObjects:@"desset",@"desset1",@"desset2",@"desset3",@"desset4", nil];
    _dessertName=[[NSMutableArray alloc]initWithObjects:@"樱桃",@"冰激凌",@"紫冰激凌",@"香蕉",@"西瓜", nil];
    //_drinkPrice=[[NSMutableArray alloc]initWithObjects:@[@"20",@"10",@"30",@"24",@"22",], nil];
    _dessertPrice=[NSMutableArray arrayWithObjects:@"20",@"10",@"30",@"24",@"22", nil];
}
-(void)viewWillDisappear:(BOOL)animated
{
    NSMutableArray *saveDessertimage=[[NSMutableArray alloc]init];
    NSMutableArray *saveDessertName=[[NSMutableArray alloc]init];
    NSMutableArray *saveDessertPrice=[[NSMutableArray alloc]init];
    
    for (int i=0; i<_dessertName.count; i++)
    {
        UIImageView *image=(UIImageView *)[cTableView viewWithTag:100+i];
        if (image.hidden==NO)
        {
            [saveDessertimage addObject:[_dessertImage objectAtIndex:i]];
            [saveDessertName addObject:[_dessertName objectAtIndex:i]];
            [saveDessertPrice addObject:[_dessertPrice objectAtIndex:i]];
        }
    }
    NSString *path=[NSString stringWithFormat:@"%@/Documents",NSHomeDirectory()];
    NSString *dessertimage=[path stringByAppendingPathComponent:@"dessertImage.plist"];
    NSString *dessertName=[path stringByAppendingPathComponent:@"dessertName.plist"];
    NSString *dessertPrice=[path stringByAppendingPathComponent:@"dessertPrice.plist"];
    [saveDessertimage writeToFile:dessertimage atomically:YES];
    [saveDessertName writeToFile:dessertName atomically:YES];
    [saveDessertPrice writeToFile:dessertPrice atomically:YES];
    //显示结果
    [result displayResult];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
