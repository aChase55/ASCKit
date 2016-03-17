//
//  ASCStyleManager.h
//  Pods
//
//  Created by Alex Chase on 3/17/16.
//
//

#import <Foundation/Foundation.h>

@interface ASCStyleManager : NSObject
+ (instancetype)sharedStyle;

@property (nonatomic,strong)UIColor *defaultColor;
@property (nonatomic,strong)UIColor *successColor;
@property (nonatomic,strong)UIColor *warningColor;
@property (nonatomic,strong)UIColor *errorColor;

@property (nonatomic,strong)UIColor *defaultTextColor;
@property (nonatomic,strong)UIColor *lightTextColor;
@property (nonatomic,strong)UIColor *darkTextColor;

@end
