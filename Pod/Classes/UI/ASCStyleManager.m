//
//  ASCStyleManager.m
//  Pods
//
//  Created by Alex Chase on 3/17/16.
//
//

#import "ASCStyleManager.h"

@implementation ASCStyleManager

+ (instancetype)sharedStyle{
    static id _sharedStyle;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedStyle = [[[self class] alloc] init];
    });
    return _sharedStyle;
}

-(UIColor *)defaultColor{
    if (!_defaultColor) {
        _defaultColor = [UIColor paperColorPurple];
    }
    return _defaultColor;
}

-(UIColor *)successColor{
    if (!_successColor) {
        _successColor = [UIColor paperColorGreen];
    }
    return _successColor;
}

-(UIColor *)errorColor{
    if (!_errorColor) {
        _errorColor = [UIColor paperColorRed];
    }
    return _errorColor;
}

-(UIColor *)warningColor{
    if (!_warningColor) {
        _warningColor = [UIColor paperColorYellow];
    }
    return _warningColor;
}

-(UIColor *)defaultTextColor{
    if (!_defaultTextColor) {
        _defaultTextColor =  [UIColor paperColorGray700];
    }
    return _defaultTextColor;
}

-(UIColor *)lightTextColor{
    if (!_lightTextColor) {
        _lightTextColor =  [UIColor paperColorGray];
    }
    return _lightTextColor;
}

-(UIColor *)darkTextColor{
    if (!_darkTextColor) {
        _darkTextColor =  [UIColor paperColorGray900];
    }
    return _darkTextColor;
}



@end
