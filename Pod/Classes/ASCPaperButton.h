//
//  ASCPaperButton.h
//  Pods
//
//  Created by Alex Chase on 3/16/16.
//
//

#import <BFPaperButton/BFPaperButton.h>



@interface ASCPaperButton : BFPaperButton

-(instancetype)initWithText:(NSString *)text inView:(UIView *)view;
-(instancetype)initWithText:(NSString *)text color:(UIColor *)color;
-(instancetype)initWhiteBgFlatWithText:(NSString *)text color:(UIColor *)color;

@property(nonatomic,strong) UIColor *textColor;
@property(nonatomic,strong)UIColor *highlightTextColor;

@property (nonatomic,strong)UIImageView *buttonImage;

@end
