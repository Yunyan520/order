//
//  menuViewController.m
//  餐厅菜单
//
//  Created by rimie27 on 14-1-11.
//  Copyright (c) 2014年 Wang Nan. All rights reserved.
//

#import "menuViewController.h"
@interface menuViewController ()
{
    UITableView *aTableView;
    NSMutableArray *identifierImageArray;
    //层
    CALayer *transitionLayer;
}
@end

@implementation menuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem.title=@"菜单";
        self.tabBarItem.image=[UIImage imageNamed:@"item1"];
        transitionLayer=[[CALayer alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ResultViewController *result=[[ResultViewController alloc]init];
    result.delegate=self;
    self.edgesForExtendedLayout=UIRectEdgeNone;
    //初始化一些数据数组什么的东西
    identifierImageArray=[[NSMutableArray alloc]init];
    [self initalizeSundryData];
    //标题栏背景以及按钮以及购物车
    UIImageView *titleImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 25, 320, 40)];
    titleImage.image=[UIImage imageNamed:@"menucloud1"];
    [self.view addSubview:titleImage];
    //购物车
    UIImageView *shopCarImage=[[UIImageView alloc]initWithFrame:CGRectMake(260, 20, 36, 36)];
    shopCarImage.image=[UIImage imageNamed:@"shopCar"];
    [self.view addSubview:shopCarImage];
    //tableView初始化
    aTableView=[[UITableView alloc]initWithFrame:CGRectMake(0,110, 320, 480-155)];
    aTableView.delegate=self;
    aTableView.dataSource=self;
    [self.view addSubview:aTableView];
    //初始化搜索功能
    _searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 60, 320, 30)];
    [self.view addSubview:_searchBar];
    _searchDC=[[UISearchDisplayController alloc]initWithSearchBar:_searchBar contentsController:self];
    _searchDC.searchResultsDataSource=self;
    _searchDC.searchResultsDelegate=self;
}
//搜索功能
-(NSPredicate *)search
{
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"SELF BEGINSWITH[cd] %@", self.searchBar.text];
    return predicate;
}
#pragma mark -  UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==aTableView)
    {
        return _nameAllKey.count;
    }
    else
    {
        NSArray *searchName=[_nameAllKey filteredArrayUsingPredicate:[self search]];
        return searchName.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    if (tableView==aTableView)
    {
        cell.imageView.image=[UIImage imageNamed:[_nameAllKey objectAtIndex:indexPath.row]];
        cell.textLabel.text=[_menuDic objectForKey:[_nameAllKey objectAtIndex:indexPath.row]];
        cell.detailTextLabel.text=[_priceDic objectForKey:[_nameAllKey objectAtIndex:indexPath.row]];
        UIImageView *identifierImage=[[UIImageView alloc]initWithFrame:CGRectMake(260, 6, 36, 36)];
        identifierImage.image=[UIImage imageNamed:@"identifier"];
        identifierImage.tag=100+indexPath.row;
        identifierImage.hidden=YES;
        [identifierImageArray addObject:identifierImage];
        [cell addSubview:identifierImage];
        return cell;
    }
    else
    {
        NSArray *searchNameArray=[_nameAllKey filteredArrayUsingPredicate:[self search]];
        cell.textLabel.text=[searchNameArray objectAtIndex:indexPath.row];
        cell.detailTextLabel.text=[_priceDic objectForKey:[searchNameArray objectAtIndex:indexPath.row]];
        cell.imageView.image=[UIImage imageNamed:[_menuDic objectForKey:[searchNameArray objectAtIndex:indexPath.row]]];
        return cell;
    }
}

#pragma mark - UITableViewDelegate
//单击cell触发
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIImageView *image=(UIImageView *)[aTableView viewWithTag:100+indexPath.row];

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
        rotateAnimation.toValue = [NSNumber numberWithFloat:5 * M_PI];
        
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//各种数据初始化
-(void)initalizeSundryData
{
       //存储图片和名字
    _menuDic=[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"hamburger", @"hamburger",@"bread",@"bread",@"super hamburger",@"super hamburger",@"chicken",@"chicken",@"cheese",@"cheese",@"Pizza",@"Pizza",@"island sushi",@"island sushi",@"soup",@"soup",nil];
    //存储名字和价格
    _priceDic=[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"50", @"hamburger",@"30",@"bread",@"23",@"super hamburger",@"60",@"chicken",@"10",@"cheese",@"40",@"Pizza",@"20",@"island sushi",@"5",@"soup", nil];
    _nameAllKey=[[NSMutableArray alloc]init];
    _nameAllKey=[_priceDic allKeys];
}

//当切换页面的时候开始存储数据
-(void)viewWillDisappear:(BOOL)animated
{
    NSMutableArray *menuImageArray=[[NSMutableArray alloc]init];
    NSMutableArray *menuNameArray=[[NSMutableArray alloc]init];
    NSMutableArray *menuPriceArray=[[NSMutableArray alloc]init];
    
    for (int i=0; i<_nameAllKey.count; i++)
    {
        UIImageView *image=(UIImageView *)[aTableView viewWithTag:100+i];
        if (image.hidden==NO)
        {
            [menuImageArray addObject:[_nameAllKey objectAtIndex:i]];
            [menuNameArray addObject:[_nameAllKey objectAtIndex:i]];
            [menuPriceArray addObject:[_priceDic objectForKey:[_nameAllKey objectAtIndex:i]]];
        }
    }
    
    //持久化存储数据
    NSString *path=[NSString stringWithFormat:@"%@/Documents",NSHomeDirectory()];
    NSString *menuimage =[path stringByAppendingPathComponent:@"menuimage.plist"];
    NSString *menuName=[path stringByAppendingPathComponent:@"menuname.plist"];
    NSString *menuPrice=[path stringByAppendingPathComponent:@"menuprice.plist"];
    [menuImageArray writeToFile:menuimage atomically:YES];
    [menuNameArray writeToFile:menuName atomically:YES];
    [menuPriceArray writeToFile:menuPrice atomically:YES];
    //将食物名字存起来以便回来的时候好用
}
//取消用户不要的数据
-(void)receiveUesrDeleteData:(NSString *)name
{
    NSMutableArray*nameArray=[[NSUserDefaults standardUserDefaults]objectForKey:@"name"];
    NSMutableArray *identifierArray=[[NSUserDefaults
                                      standardUserDefaults]objectForKey:@"identifierImage"];
    for (int i=0; i<nameArray.count; i++)
    {
        if (name==[nameArray objectAtIndex:i])
        {
            UIImageView *image=(UIImageView *)[identifierArray objectAtIndex:i];
            NSLog(@"%@",image);
        }
    }
}
@end
