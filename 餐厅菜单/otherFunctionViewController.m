//
//  otherFunctionViewController.m
//  翻翻看游戏
//
//  Created by rimie27 on 13-12-27.
//  Copyright (c) 2013年 Wang Nan. All rights reserved.
//

#import "otherFunctionViewController.h"
#import "OverTurnViewController.h"
@interface otherFunctionViewController ()

@end

@implementation otherFunctionViewController

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
    
	// Do any additional setup after loading the view.
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor=[UIColor orangeColor];
    button.layer.cornerRadius=10;
    button.frame=CGRectMake(100, 300, 100, 40);
    [button setTitle:@"单击进入" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(enter) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button release];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(30, 40, 260, 200)];
    label.text=@"欢迎来到自己都不想玩的翻翻看，锻炼自我控制力，控制怒火必备！！！点击下面开始按钮进入游戏。";
    
    label.numberOfLines=0;
    
        [self.view addSubview:label];
        [label release];
    
    
    
}
-(void)enter
{
    OverTurnViewController *over=[[OverTurnViewController alloc]init];
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"亲，请慢慢点击，快了要出事。" delegate:self cancelButtonTitle:@"OK,哥知道啦。" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
    [self presentViewController:over animated:YES completion:nil];
    [over release];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
