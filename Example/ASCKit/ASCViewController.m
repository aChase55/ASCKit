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
    
    _cellTitles = @ [@"Small Notification",@"Large Notification",@"Default Alert",@"Cancel Alert"];
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
        case 2:
            [self showAlert];
            break;
        case 3:
            [self showCancelAlert];
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

-(void)showAlert{
    
    ASCAlertVC *alert =[ASCAlertVC alertWithText:@"Alert" detailText:@"This is a default alert.  It will automatically size itself according to device size and text to be displayed!" style:ASCAlertStyleDefault];
    [alert setConfrimText:@"Close"];
    
    UINavigationController *nav = [UINavigationController navigationControllerToPresentVC:alert];
    [self presentViewController:nav animated:YES completion:nil];
}

-(void)showCancelAlert{
    
    ASCAlertVC *alert =[ASCAlertVC alertWithText:@"Warning!" detailText:@"This is a warning alert.  It will automatically size itself according to device size and text to be displayed! A cancel button is added by setting shows cancel to YES or initializing with a non-nil cancel block" style:ASCAlertStyleWarning showsCancel:YES confirmBlock:nil];
    [alert setConfrimText:@"Close"];
   
    UINavigationController *nav = [UINavigationController navigationControllerToPresentVC:alert];
    [self presentViewController:nav animated:YES completion:nil];
}


@end
