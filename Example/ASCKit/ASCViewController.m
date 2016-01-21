//
//  ASCViewController.m
//  ASCKit
//
//  Created by Alex Chase on 01/20/2016.
//  Copyright (c) 2016 Alex Chase. All rights reserved.
//

#import "ASCViewController.h"
#import "ASCKit.h"

@interface ASCViewController ()

@end

@implementation ASCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor redColor];
    
    ASCLabel *label =[[ASCLabel alloc]initWithText:@"Hello \nthis is a new line of text" atOrigin:CGPointMake(0, 100)];
    [self.view addSubview:label];
    
    
    UIButton *button = [[UIButton alloc]initWithFrame:self.view.frame];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(showNotification) forControlEvents:UIControlEventTouchUpInside];
    
    
	// Do any additional setup after loading the view, typically from a nib.
}


-(void)showNotification{
    [ASCNotificationView longDefaultWithMessage:@"Notification long" onTouch:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
