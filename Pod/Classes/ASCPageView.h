//
//  ASCPageView.h
//  Pods
//
//  Created by Alex Chase on 3/16/16.
//
//

#import <UIKit/UIKit.h>

@interface ASCPageView : UIView

-(instancetype)initWithHeading:(NSString *)heading;
-(instancetype)initWithHeading:(NSString *)heading label:(UILabel *)textView;

@property (nonatomic,strong)UILabel *headingLabel;
@property (nonatomic,strong)NSString *headingText;

@property (nonatomic,strong)UIView *dividorLine;
-(void)shouldShowDividorLine:(BOOL)show;

@end
