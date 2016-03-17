//
//  ASCLabel.m
//  Pods
//
//  Created by Alex Chase on 1/20/16.
//
//

#import "ASCLabel.h"

@implementation ASCLabel

-(instancetype)initWithText:(NSString *)text{
    self = [self initWithText:text atOrigin:CGPointZero];
    if (self) {}
    return self;
}

-(instancetype)initWithText:(NSString *)text inView:(UIView *)view{
    self = [self initWithText:text atOrigin:CGPointZero];
    if (self) {
        [view addSubview:self];
    }
    return self;
}

-(instancetype)initWithText:(NSString *)text atOrigin:(CGPoint)origin{
    
    if (text) {
        
        ASCLabel *label = [[super class] new];
        label.displaysAsynchronously = YES;
        label.ignoreCommonProperties = YES;
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            // Create attributed string.
            NSMutableAttributedString *attributedText =[self applyDefaultAttributesToString:text];
            
            YYTextContainer *container = [YYTextContainer new];
            container.size = CGSizeMake(300, CGFLOAT_MAX);
            container.maximumNumberOfRows = 0;
        
            // Generate a text layout.
            YYTextLayout *layout = [YYTextLayout layoutWithContainer:container text:attributedText];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                label.frame = CGRectMake(origin.x, origin.y, layout.textBoundingSize.width, layout.textBoundingSize.height);
                label.textLayout = layout;
                label.backgroundColor = [UIColor blueColor];
            });
        });
        self = label;
        return self;
    }
    return nil;
}

-(NSMutableAttributedString *)applyDefaultAttributesToString:(NSString *)text{
    if (text) {
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:[text mutableCopy]];
        attributedText.yy_font = [UIFont systemFontOfSize:16];
        attributedText.yy_color = [[ASCStyleManager sharedStyle]darkTextColor];
        attributedText.yy_kern = [self defaultKern];
        attributedText.yy_lineSpacing = [self defaultLineSpace];
        
        return attributedText;
    }
    return nil;
}
-(NSNumber *)defaultKern{
    return @(0.0);
}
-(CGFloat)defaultLineSpace{
    return 1.7;
}

@end
