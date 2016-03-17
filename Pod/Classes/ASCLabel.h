//
//  ASCLabel.h
//  Pods
//
//  Created by Alex Chase on 1/20/16.
//
//

#import <YYText/YYText.h>

@interface ASCLabel : YYLabel
-(instancetype)initWithText:(NSString *)text atOrigin:(CGPoint)origin;

@property(nonatomic,strong)NSNumber *defaultKern;


@end
