//
//  ResultViewController.m
//  餐厅菜单
//
//  Created by rimie27 on 14-1-11.
//  Copyright (c) 2014年 Wang Nan. All rights reserved.
//

#import "ResultViewController.h"

@interface ResultViewController ()
{
    UITableView *resultTableView;
    NSMutableArray *resultimageArray;
    NSMutableArray *resultnameArray;
    NSMutableArray *resultpriceArray;
    UIButton *editBtn;
    int allPrice;
}
@end

@implementation ResultViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //添加标题背景
        UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 20, 320, 40)];
        imageview.image=[UIImage imageNamed:@"menucloud1"];
       [self.view addSubview:imageview];
    //游戏按钮
    UIButton *game=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    game.frame=CGRectMake(120, 30, 80, 30);
    game.layer.cornerRadius=10;
    [game setTitle:@"Game " forState:UIControlStateNormal];
    game.titleLabel.font=[UIFont systemFontOfSize:20];
    [self.view addSubview:game];

    //返回按钮
    UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame=CGRectMake(0, 30, 80, 30);
    button.layer.cornerRadius=10;
    [button addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"返回 " forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont systemFontOfSize:20];
    [self.view addSubview:button];
    //编辑按钮
    editBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    editBtn.frame=CGRectMake(240, 30, 80, 30);
    editBtn.layer.cornerRadius=10;
    [editBtn addTarget:self action:@selector(edit) forControlEvents:UIControlEventTouchUpInside];
    [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    editBtn.titleLabel.font=[UIFont systemFontOfSize:20];
    [self.view addSubview:editBtn];
    
    //初始化tableView
    resultTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 65, 320, 480-64)];
    resultTableView.delegate=self;
    resultTableView.dataSource=self;
    [self.view addSubview:resultTableView];

}
#pragma mark - UITableViewDataSource
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //多一行来计算总价格
    return resultimageArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
        cell.textLabel.text=[resultnameArray objectAtIndex:indexPath.row];
        cell.detailTextLabel.text=[resultpriceArray objectAtIndex:indexPath.row];
        //计算总价格
        //allPrice=allPrice+[[resultpriceArray objectAtIndex:indexPath.row]integerValue];
        cell.imageView.image=[UIImage imageNamed:[resultimageArray objectAtIndex:indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate
//编辑
-(void)edit
{
    if ([resultTableView isEditing])
    {
        [editBtn setTitle:@"edit" forState:UIControlStateNormal];
        [resultTableView setEditing:NO animated:YES];
    }
    else
    {
        [editBtn setTitle:@"Done" forState:UIControlStateNormal];
        [resultTableView setEditing:YES animated:YES];
    }
}

//判定编辑状态
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (resultimageArray.count==indexPath.row)
    {
        return NO;
    }
    return YES;
}
//删除不需要的数据
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [resultimageArray removeObjectAtIndex:indexPath.row];
    [resultnameArray removeObjectAtIndex:indexPath.row];
    [resultpriceArray removeObjectAtIndex:indexPath.row];
    [resultTableView reloadData];
    [self.delegate receiveUesrDeleteData:@"name"];
}

//显示结果
-(void)displayResult
{
    //分配空间
    resultimageArray =[[NSMutableArray alloc]init];
    resultnameArray=[[NSMutableArray alloc]init];
    resultpriceArray=[[NSMutableArray alloc]init];
    
#pragma 取出Menu里的数据
    NSString *path=[NSString stringWithFormat:@"%@/Documents",NSHomeDirectory()];
    //获取menuImage数据
    NSString *menuImage=[path stringByAppendingPathComponent:@"menuimage.plist"];
    NSMutableArray *readMenuImage=[NSMutableArray arrayWithContentsOfFile:menuImage];
    //获取menuName数据
    NSString *menuName=[path stringByAppendingPathComponent:@"menuname.plist"];
    NSMutableArray *readMenuName=[NSMutableArray arrayWithContentsOfFile:menuName];
    //获取menuPrice数据
    NSString *menuPrice=[path stringByAppendingPathComponent:@"menuprice.plist"];
    NSMutableArray *readMenuPrice=[NSMutableArray arrayWithContentsOfFile:menuPrice];
    
#pragma 取出Drinks里的数据
     //获取drinksImage数据
    NSString *drinksImage=[path stringByAppendingPathComponent:@"drinksImage.plist"];
    NSMutableArray *readDrinksImage=[NSMutableArray arrayWithContentsOfFile:drinksImage];
    //获取drinksName数据
    NSString *drinksName=[path stringByAppendingPathComponent:@"drinksName.plist"];
    NSMutableArray *readDrinksName=[NSMutableArray arrayWithContentsOfFile:drinksName];
    //获取drinksPrice数据
    NSString *drinksPrice=[path stringByAppendingPathComponent:@"drinksPrice.plist"];
    NSMutableArray *readDrinksPrice=[NSMutableArray arrayWithContentsOfFile:drinksPrice];
    
#pragma 取出Dessert里的数据
    //获取dessertImage数据
    NSString *dessertImage=[path stringByAppendingPathComponent:@"dessertImage.plist"];
    NSMutableArray *readDessertImage=[NSMutableArray arrayWithContentsOfFile:dessertImage];
    //获取drinksName数据
    NSString *dessertName=[path stringByAppendingPathComponent:@"dessertName.plist"];
    NSMutableArray *readDessertName=[NSMutableArray arrayWithContentsOfFile:dessertName];
    //获取drinksPrice数据
    NSString *dessertPrice=[path stringByAppendingPathComponent:@"dessertPrice.plist"];
    NSMutableArray *readDessertPrice=[NSMutableArray arrayWithContentsOfFile:dessertPrice];
    
    //收集各个数组到同类型数组中
    _resultImageArray=[[NSMutableArray alloc]initWithArray:@[readMenuImage,readDrinksImage,readDessertImage]];
    _resultNameArray=[[NSMutableArray alloc]initWithArray:@[readMenuName,readDrinksName,readDessertName]];
    _resultPriceArray=[[NSMutableArray alloc]initWithArray:@[readMenuPrice,readDrinksPrice,readDessertPrice]];
    //把各个数组里的数据存到同类的一个数组里面
    //图片数组
    for (int i=0; i<_resultImageArray.count; i++)
    {
        for (int j=0; j<[[_resultImageArray objectAtIndex:i] count]; j++)
        {
            [resultimageArray addObject:[[_resultImageArray objectAtIndex:i]objectAtIndex:j]];
        }
    }
    //名字数组
    for (int i=0; i<_resultNameArray.count; i++)
    {
        for (int j=0; j<[[_resultNameArray objectAtIndex:i] count]; j++)
        {
            [resultnameArray addObject:[[_resultNameArray objectAtIndex:i]objectAtIndex:j]];
        }
    }
    //价格数组
    for (int i=0; i<_resultPriceArray.count; i++)
    {
        for (int j=0; j<[[_resultPriceArray objectAtIndex:i] count]; j++)
        {
            [resultpriceArray addObject:[[_resultPriceArray objectAtIndex:i]objectAtIndex:j]];
        }
    }
}

//返回
-(void)fanhui
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
