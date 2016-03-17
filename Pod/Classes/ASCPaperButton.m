//
//  ASCPaperButton.m
//  Pods
//
//  Created by Alex Chase on 3/16/16.
//
//

#import "ASCPaperButton.h"

@interface ASCPaperButton()
@property(nonatomic,assign)CGFloat defaultCornerRadius;
@end

@implementation ASCPaperButton

-(instancetype)initWithText:(NSString *)text inView:(UIView *)view{
    self = [super initWithRaised:YES];
    if (self) {
        [self setTitle:text forState:UIControlStateNormal];
        [self commonInit];
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0.0f, DEFAULT_SPACING, 0.0f, 0.0f)];
        [view addSubview:self];
    }
    return self;
}

-(instancetype)initWithText:(NSString *)text color:(UIColor *)color{
    self = [super initWithRaised:YES];
    if (self) {
        [self setTitle:text forState:UIControlStateNormal];
        [self commonInit];
        self.backgroundColor =color;
    }
    return self;
}

-(instancetype)initWhiteBgFlatWithText:(NSString *)text color:(UIColor *)color{
    self = [super initWithRaised:NO];
    if (self) {
        [self setTitle:text forState:UIControlStateNormal];
        self.clipsToBounds = YES;
        self.tapCircleColor = color;
        self.backgroundColor =[UIColor clearColor];
        [self setTitleColor:color forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    }
    return self;
}

-(void)commonInit{
    self.backgroundColor =[UIColor paperColorPurple];
    self.clipsToBounds = NO;
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setCornerRadius:self.defaultCornerRadius];
    CGRect shadowFrame = self.layer.bounds;
    CGPathRef shadowPath = [UIBezierPath bezierPathWithRect:shadowFrame].CGPath;
    self.layer.shadowPath = shadowPath;
}

-(CGFloat)defaultCornerRadius{
    if (!_defaultCornerRadius) {
        _defaultCornerRadius = 2.0f;
    }
    return _defaultCornerRadius;
}

@end
