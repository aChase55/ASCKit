//
//  ASCTableVC.m
//  ASCKit
//
//  Created by Alex Chase on 3/21/16.
//  Copyright © 2016 Alex Chase. All rights reserved.
//

#import "ASCTableVC.h"
#import "ASCKit.h"
#define K_CELL_IDENTIFIER @"ASCCell"
@interface ASCTableVC ()
@property(nonatomic,strong)NSArray *cellTitles;
@end

@implementation ASCTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ASCKit";

    
    _cellTitles = @ [@"Small Notification",@"Large Notification",@"Default Alert",@"Success Alert",@"Warning Alert",@"Error Alert",@"Custom Alert",@"Slideable Modal"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:K_CELL_IDENTIFIER];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cellTitles.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:K_CELL_IDENTIFIER forIndexPath:indexPath];
    if (!cell) {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = [_cellTitles objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self displayActionForIndex:indexPath.row];
}




#pragma mark - diplay handler

-(void)displayActionForIndex:(NSInteger)index{
    switch (index) {
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
        case 7:
            [self showSlidingModal];
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
    [self presentViewController:alert];
}

-(void)showSuccessAlert{
    
    ASCAlertVC *alert =[ASCAlertVC alertWithText:@"Success!" detailText:@"This is a success alert.  It will automatically size itself according to device size and text to be displayed!" style:ASCAlertStyleSuccess];
    [alert setConfrimText:@"Awesome!"];
    [self presentViewController:alert];
    
}

-(void)showWarningAlert{
    
    ASCAlertVC *alert =[ASCAlertVC alertWithText:@"Warning!" detailText:@"This is a warning alert.  It will automatically size itself according to device size and text to be displayed!" style:ASCAlertStyleWarning];
    [alert setConfrimText:@"Close"];
    [self presentViewController:alert];
}

-(void)showErrorAlert{
    
    ASCAlertVC *alert = [ASCAlertVC errorAlertWithDetails:@"This is a warning alert.  It will automatically size itself according to device size and text to be displayed!"];
    [alert setConfrimText:@"Close"];
    [self presentViewController:alert];
}

-(void)showCustomAlert{
    
    ASCAlertVC *alert =[ASCAlertVC alertWithText:@"🌈Custom🌈" detailText:@"This is a custom alert. You must set the custom color before displaying the alert for this to work!" style:ASCAlertStyleCustom];
    [alert setConfrimText:@"Got It!"];
    [alert setCustomColor:UIColorFromRGB(0xEE93FA)];
    [self presentViewController:alert];
    
}



#pragma mark - sliding modal
-(void)showSlidingModal{
    ASCSlideModalVC *vc = [[ASCSlideModalVC alloc]initWithCompletionBlock:nil];
    [self presentViewController:vc];
}



#pragma mark - helper
-(void)presentViewController:(UIViewController *)vc{
    UINavigationController *nav = [UINavigationController navigationControllerToPresentVC:vc];
    [self presentViewController:nav animated:YES completion:nil];
}







/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
