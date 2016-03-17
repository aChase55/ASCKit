//
//  ASCHelpers.m
//  Pods
//
//  Created by Alex Chase on 3/17/16.
//
//

#import "ASCHelpers.h"
#import <CoreText/CoreText.h>

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

+(UIFont *)bundleFontName:(NSString *)fontName fontExtension:(NSString *)fontExtension atSize:(CGFloat)fontSize{
    
    UIFont *font = [UIFont fontWithName:fontName size:fontSize];
    if (!font) {
        [[self class]dynamicallyLoadFontNamed:fontName withExtension:fontExtension];
        font = [UIFont fontWithName:fontName size:fontSize];
        if (!font){
            font = [UIFont systemFontOfSize:fontSize];
        }
    }
    return font;
}

+(void)dynamicallyLoadFontNamed:(NSString *)fontName withExtension:(NSString *)extension{
    
    NSString *sharedBundlePath = [[NSBundle bundleForClass:self.class] pathForResource:@"ASCKit" ofType:@"bundle"];
    NSBundle *podBundle = [NSBundle bundleWithPath:sharedBundlePath];
    NSURL *url = [podBundle URLForResource:fontName withExtension:extension];
    NSData *fontData = [NSData dataWithContentsOfURL:url];
    if (fontData) {
        CFErrorRef error;
        CGDataProviderRef provider = CGDataProviderCreateWithCFData((CFDataRef)fontData);
        CGFontRef font = CGFontCreateWithDataProvider(provider);
        if (! CTFontManagerRegisterGraphicsFont(font, &error)) {
            CFStringRef errorDescription = CFErrorCopyDescription(error);
            NSLog(@"Failed to load font: %@", errorDescription);
            CFRelease(errorDescription);
        }
        CFRelease(font);
        CFRelease(provider);
    }
}



@end
