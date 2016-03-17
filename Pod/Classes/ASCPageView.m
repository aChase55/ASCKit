//
//  ASCPageView.m
//  Pods
//
//  Created by Alex Chase on 3/16/16.
//
//
#import <QuartzCore/QuartzCore.h>

#define MARGIN_SIZE HUGE_SPACING
#define TEXT_MARGIN HUGE_SPACING
#define DEFAULT_FRAME CGRectMake(MARGIN_SIZE, DEFAULT_SPACING, SCREEN_WIDTH-(2*MARGIN_SIZE), 100)


#import "ASCPageView.h"
#import "ASCLabel.h"

@interface ASCPageView()
@property (nonatomic,strong)UIImageView *bg;
@end

@implementation ASCPageView

-(instancetype)init{
    self =[super initWithFrame:DEFAULT_FRAME];
    if (self) {
        [self commonInit];
        
    }
    return self;
}

-(instancetype)initWithHeading:(NSString *)heading{
    self =[super initWithFrame:DEFAULT_FRAME];
    if (self) {
        [self commonInit];
        self.headingText = heading;
        [self setupHeading];
        [self addSubview:self.dividorLine];
    }
    return self;
}

-(instancetype)initWithHeading:(NSString *)heading label:(UILabel *)textView{
    self =[super initWithFrame:DEFAULT_FRAME];
    if (self) {
        [self commonInit];
        
        self.headingText = heading;
        [self setupHeading];
        
        [self addSubview:self.dividorLine];
        
        CGSize textViewSize =
        [textView sizeThatFits:CGSizeMake(CGRectGetWidth(self.frame)-2*TEXT_MARGIN, FLT_MAX)];
        [textView setFrame:CGRectMake(TEXT_MARGIN, CGRectGetMaxY(self.dividorLine.frame)+DEFAULT_SPACING, CGRectGetWidth(self.frame), textViewSize.height)];
        [textView sizeToFit];
        
        [self addSubview:textView];
        [self setFrame:CGRectMake(FRAME_ORIGIN_X(self), FRAME_ORIGIN_Y(self)+DEFAULT_SPACING, FRAME_SIZE_W(self), CGRectGetMaxY(textView.frame)+HUGE_SPACING)];
    }
    return self;
}



-(void)commonInit{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 2.0f;
    self.layer.shadowOffset = CGSizeMake(0.5f, 4.0f);
    self.layer.shadowRadius = 2.5f;
    self.layer.shadowOpacity = 0.35f;
    
}

-(void)setupHeading{
    _headingLabel = [[UILabel alloc]init];
    [_headingLabel setText:_headingText];
    _headingLabel.textColor =[[ASCStyleManager sharedStyle]defaultTextColor];
    _headingLabel.backgroundColor = [UIColor redColor];
    [_headingLabel setFrame:CGRectMake(HUGE_SPACING, DEFAULT_SPACING, self.frame.size.width, CGRectGetHeight(_headingLabel.frame))];
    [self addSubview:_headingLabel];
}

-(UIView *)dividorLine{
    if (!_dividorLine) {
        self.dividorLine = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_headingLabel.frame)+DEFAULT_SPACING, CGRectGetWidth(self.frame), 1)];
        self.dividorLine.backgroundColor=[[ASCStyleManager sharedStyle]lightTextColor];
    }
    return _dividorLine;
}

-(CGRect)frameForDividorLine{
    return CGRectMake(DEFAULT_SPACING, self.dividorLine.frame.origin.y, CGRectGetWidth(self.frame)-HUGE_SPACING, self.dividorLine.frame.size.height);
}

/*
-(void)layoutSubviews{
    [super layoutSubviews];
    if (_dividorLine) {
        //[self.dividorLine setFrame:[self frameForDividorLine]];
    }
}*/

-(void)shouldShowDividorLine:(BOOL)show{
    self.dividorLine.hidden =show;
    self.headingLabel.hidden =show;
    [self layoutSubviews];
}

@end
