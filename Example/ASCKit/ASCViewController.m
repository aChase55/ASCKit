//
//  ASCViewController.m
//  ASCKit
//
//  Created by Alex Chase on 01/20/2016.
//  Copyright (c) 2016 Alex Chase. All rights reserved.
//

#import "ASCViewController.h"
#import "ASCKit.h"

@interface ASCViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,retain)UITableView *table;

@property (nonatomic,strong)NSArray *cellTitles;

@end

@implementation ASCViewController





- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor redColor];
    
    self.table =[[UITableView alloc]initWithFrame:self.view.frame];
    [self.table setDataSource:self];
    [self.table setDelegate:self];
    [self.view addSubview:self.table];
    
    _cellTitles = @ [@"Small Notification",@"Large Notification",@"Blocking UI",@"Page Pop Up"];
  
}




#pragma mark - UITableView Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _cellTitles.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =[self.table dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = [_cellTitles objectAtIndex:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
            [self showSmallNotification];
            break;
        case 1:
            [self showLargeNotification];
            break;
        default:
            break;
    }
}

#pragma mark - notifications

-(void)showSmallNotification{
    [ASCNotificationView shortDefaultWithMessage:@"A Small Notification"];
}

-(void)showLargeNotification{
    [ASCNotificationView longDefaultWithMessage:@"A Large Notification" onTouch:nil];
}


@end
