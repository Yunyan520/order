//
//  OverTurnViewController.m
//  翻翻看游戏
//
//  Created by rimie27 on 13-12-27.
//  Copyright (c) 2013年 Wang Nan. All rights reserved.
//

#import "OverTurnViewController.h"

@interface OverTurnViewController ()
{
    UIImageView *imageView;
    UIImageView *imageView1;
    UIImageView *saveimageView;
    UIImageView *savewenhaoimage;
    UIImageView *firstSaveImage;
    UIImageView *firstSaveWenHaoImage;
    NSInteger count;//判定所翻的图片是单数还是双数
    NSInteger countEachGroupImage;//计算成功一组加一次
    NSMutableArray *imageNumber;
}
@end
@implementation OverTurnViewController
-(void)dealloc
{
    [imageView release];
    [imageView1 release];
    [saveimageView release];
    [savewenhaoimage release];
    [firstSaveImage release];
    [firstSaveWenHaoImage release];
    [imageNumber release];
    [super dealloc];
}
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
//初始化单数的时候要保存起来的图片
    saveimageView=[[UIImageView alloc]init];
    firstSaveImage=[[UIImageView alloc]init];
//初始化单数的时候要保存起来的问号背景图
    savewenhaoimage=[[UIImageView alloc]init];
    firstSaveWenHaoImage=[[UIImageView alloc]init];
    //初始化每组图片成功翻转
    countEachGroupImage=0;
   count=1;
    //图片
    NSInteger imgCount=0;
    //判定图片是不是5个一组
    NSInteger judgeimage=0;
    //打印问号
        NSInteger bgCount=0;
    //返回按钮
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor=[UIColor orangeColor];
    button.layer.cornerRadius=10;
    button.frame=CGRectMake(20 , 30, 100, 40);
    [button setTitle:@"返回 " forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button release];
    
    for (int i=0; i<5; i++)
    {
        for (int j=0; j<4; j++)
        {
            bgCount++;
            UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(j*80, 70+i*80, 80, 80)];
            image.image=[UIImage imageNamed:@"default111"];
            image.tag=100+bgCount;
            [self.view addSubview:image];
            [image release];
            image.userInteractionEnabled=YES;
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
            [image addGestureRecognizer:tap];
            [tap release];
            //图片
            imgCount++;
            UIImageView *image1=[[UIImageView alloc]initWithFrame:CGRectMake(j*80, 70+i*80, 80, 80)];
            image1.image=[UIImage imageNamed:[NSString stringWithFormat:@"%d",judgeimage]];
            image1.tag=200+imgCount;
            image1.alpha=0;
            [self.view addSubview:image1];
            [image1 release];
            judgeimage++;
            if (judgeimage==5)
            {
                judgeimage=0;
            }
        }
    }
    //给图片设置编号一遍好匹配
    imageNumber=[[[NSMutableArray alloc]initWithObjects:
    @"0",@"1",@"2",@"3",@"4",
    @"0",@"1",@"2",@"3",@"4",
    @"0",@"1",@"2",@"3",@"4",
    @"0",@"1",@"2",@"3",@"4",nil]retain];
}
    -(void)tap:(UITapGestureRecognizer *)tapvalue
    {
  
        UIImageView *turnImage=(UIImageView *)[self.view viewWithTag:tapvalue.view.tag+100];
        //从问号变为动物图
            [UIView beginAnimations:@"旋转" context:nil];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
            [UIView setAnimationDuration:1];
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:tapvalue.view cache:YES];
            [UIView commitAnimations];
            tapvalue.view.alpha=0;
            turnImage.alpha=1;
            [UIView beginAnimations:@"旋转" context:nil];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [UIView setAnimationDuration:1];
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:turnImage cache:YES];
            [UIView commitAnimations];
        if (count==1)
        {
            saveimageView=turnImage;//将单数的图片保存起来
            savewenhaoimage=(UIImageView *)tapvalue.view;
            count=2;
            
            //NSLog(@"save%d,turn%d",saveimageView.tag,turnImage.tag);
        }
        else
        {//如果图片不一样就翻转回来
            firstSaveImage=turnImage;
            firstSaveWenHaoImage=(UIImageView *)tapvalue.view;
            [self performSelector:@selector(goTurn) withObject:self afterDelay:2];
        }
    }
-(void)goTurn
{
    if ([imageNumber objectAtIndex: saveimageView.tag-201]!=[imageNumber objectAtIndex: firstSaveImage.tag-201])
    {
        [UIView beginAnimations:@"翻回图片" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [UIView setAnimationDuration:1];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:saveimageView cache:YES];

        [UIView commitAnimations];
        [UIView beginAnimations:@"翻回图片" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [UIView setAnimationDuration:1];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:firstSaveImage cache:YES];
        [UIView commitAnimations];
        saveimageView.alpha=0;
        firstSaveImage.alpha=0;
        savewenhaoimage.alpha=1;
        firstSaveWenHaoImage.alpha=1;
        [UIView beginAnimations:@"返回问号" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [UIView setAnimationDuration:1];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:savewenhaoimage cache:YES];
        [UIView commitAnimations];
        
        [UIView beginAnimations:@"返回问号" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [UIView setAnimationDuration:1];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:firstSaveWenHaoImage cache:YES];
        [UIView commitAnimations];
    }
    else
    {
        countEachGroupImage++;
    }
    firstSaveImage=nil;
    firstSaveWenHaoImage=nil;
    saveimageView=nil;
    savewenhaoimage=nil;
    count=1;
    if (countEachGroupImage==10)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"消息提示" message:@"恭喜通关" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
}

//返回按钮
-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
