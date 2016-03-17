//
//  ASCHelpers.h
//  Pods
//
//  Created by Alex Chase on 3/17/16.
//
//

#import <Foundation/Foundation.h>

@interface ASCHelpers : NSObject
+(UIImage *)bundleImageNamed:(NSString *)imgName fileType:(NSString *)fileType;
+(UIFont *)bundleFontName:(NSString *)fontName fontExtension:(NSString *)fontExtension atSize:(CGFloat)fontSize;
@end
