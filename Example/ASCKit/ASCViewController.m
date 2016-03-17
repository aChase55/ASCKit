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
    
    _cellTitles = @ [@"Small Notification",@"Large Notification",@"Default Alert",@"Success Alert",@"Warning Alert",@"Error Alert",@"Custom Alert"];
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
  //  [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];

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
            [self showDefaultAlert];
            break;
        case 3:
            [self showSuccessAlert];
            break;
        case 4:
            [self showWarningAlert];
            break;
        case 5:
            [self showErrorAlert];
            break;
        case 6:
            [self showCustomAlert];
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


#pragma mark - alerts
-(void)showDefaultAlert{
    
    ASCAlertVC *alert =[ASCAlertVC alertWithText:@"Alert" detailText:@"This is a default alert. It will automatically size itself according to device size and text to be displayed! A cancel button is added by setting shows cancel to YES or initializing with a non-nil cancel block." style:ASCAlertStyleDefault showsCancel:YES confirmBlock:nil];
    [alert setConfrimText:@"Close"];
    [self presentAlert:alert];
}

-(void)showSuccessAlert{
    
    ASCAlertVC *alert =[ASCAlertVC alertWithText:@"Success!" detailText:@"This is a success alert.  It will automatically size itself according to device size and text to be displayed!" style:ASCAlertStyleSuccess];
    [alert setConfrimText:@"Awesome!"];
    [self presentAlert:alert];

}

-(void)showWarningAlert{
    
    ASCAlertVC *alert =[ASCAlertVC alertWithText:@"Warning!" detailText:@"This is a warning alert.  It will automatically size itself according to device size and text to be displayed!" style:ASCAlertStyleWarning];
    [alert setConfrimText:@"Close"];
    [self presentAlert:alert];
}

-(void)showErrorAlert{
    
    ASCAlertVC *alert = [ASCAlertVC errorAlertWithDetails:@"This is a warning alert.  It will automatically size itself according to device size and text to be displayed!"];
    [alert setConfrimText:@"Close"];
    [self presentAlert:alert];
}

-(void)showCustomAlert{
    
    ASCAlertVC *alert =[ASCAlertVC alertWithText:@"🌈Custom🌈" detailText:@"This is a custom alert. You must set the custom color before displaying the alert for this to work!" style:ASCAlertStyleCustom];
    [alert setConfrimText:@"Got It!"];
    [alert setCustomColor:UIColorFromRGB(0xEE93FA)];
    [self presentAlert:alert];
    
    
}

 //Alert display helper
-(void)presentAlert:(ASCAlertVC *)alert{
    UINavigationController *nav = [UINavigationController navigationControllerToPresentVC:alert];
    [self presentViewController:nav animated:YES completion:nil];
}






@end
