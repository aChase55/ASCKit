//
//  ASCHelpers.m
//  Pods
//
//  Created by Alex Chase on 3/17/16.
//
//

#import "ASCHelpers.h"

@implementation ASCHelpers
+(UIImage *)bundleImageNamed:(NSString *)imgName fileType:(NSString *)fileType{
    NSString *sharedBundlePath = [[NSBundle bundleForClass:self.class] pathForResource:@"ASCKit" ofType:@"bundle"];
    NSBundle *podBundle = [NSBundle bundleWithPath:sharedBundlePath];
    NSURL *imgUrl = [podBundle URLForResource:@"loading_circle" withExtension:@"png"];
    if (imgUrl) {
        NSData *imgData = [NSData dataWithContentsOfURL:imgUrl];
        return [UIImage imageWithData:imgData];
    }
    return nil;
}
@end
