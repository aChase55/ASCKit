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
    
    if (indexPath.row ==0) {
        [self showNotification];
    }
    
    
}



@end
