//
//  ASCMacros.h
//  Pods
//
//  Created by Alex Chase on 1/20/16.
//
//

#ifndef ASCMacros_h
#define ASCMacros_h

// delegate
#define UIAppDelegate (AppDelegate *)[[UIApplication sharedApplication] delegate]
#define APPDELEGATE   (AppDelegate *)[[UIApplication sharedApplication] delegate]

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#define DEFAULT_SPACING 12
#define SMALL_SPACING (DEFAULT_SPACING/2)
#define TINY_SPACING (SMALL_SPACING/2)
#define MICRO_SPACING (TINY_SPACING/2)
#define MEDIUM_SPACING (DEFAULT_SPACING*0.66)
#define LARGE_SPACING (DEFAULT_SPACING*1.33)//16
#define BIG_SPACING (DEFAULT_SPACING *1.5)
#define HUGE_SPACING (DEFAULT_SPACING*2)
#define GIANT_SPACING (DEFAULT_SPACING*2.5)
#define ENOURMOUS_SPACING (DEFAULT_SPACING*2.75)
#define DIVINE_SPACING (DEFAULT_SPACING*3)
#define MASSIVE_SPACING (DEFAULT_SPACING*4)
#define HEADING_SPACING 44

#define DEFAULT_SPACING_NUM [NSNumber numberWithInt:DEFAULT_SPACING]


#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define STATUS_BAR_HEIGHT 20
#define DEFAULT_HEIGHT 44
#define STATUS_NAV_HEIGHT 64


#define BUTTON_WIDTH_PAD @320

#define BUTTON_WIDTH_SMALL @156

#define BUTTON_HEIGHT @52
#define BUTTON_HEIGHT_SMALL @32
#define BUTTON_HEIGHT_MEDIUM @50
#define BUTTON_HEIGHT_LARGE @60
#define BUTTON_HEIGHT_HUGE @72

#define SETTINGS_CELL_HEIGHT 60
#define SMALL_CELL_HEIGHT 80
#define DEFALUT_CELL_HEIGHT 132
#define MEDIUM_CELL_HEIGHT 102


#define LARGE_CELL_HEIGHT (SCREEN_WIDTH*.87)

#define HEADING_FONT_EXTRALITE @"Quan-Extralight"
#define HEADING_FONT_HAIRLINE @"Quan-Hairline"
#define HEADING_FONT_LIGHT  @"Quan-Light"
#define HEADING_FONT_NORMAL @"Quan-Book"
#define HEADING_FONT_STRONG @"Quan"
#define HEADING_FONT_BOLD   @"Quan"

#define BODY_FONT_HAIRLINE @"GothamRounded-Light"
#define BODY_FONT_LIGHT @"GothamRounded-Light"
#define BODY_FONT_ITAL @"GothamRounded-LightItalic"
#define BODY_FONT_NORMAL @"GothamRounded-Book"
#define BODY_FONT_STRONG @"GothamRounded-Medium"
#define BODY_FONT_BOLD @"GothamRounded-Bold"


#define safeSet(d,k,v) if (v) d[k] = v;

#define safeGet(k,d) d[k]?d[k]:@""


#define LOG_FRAME(frame) NSLog(@"%f,%f,%f,%f",frame.origin.x,frame.origin.y,frame.size.width,frame.size.height)

#define LOG_NUMBER(num) NSLog(@"%f",(float)num)

#define FRAME_BOTTOM_VALUE(frame) CGRectGetMinY(frame)+CGRectGetHeight(frame)



#define STANDARD_VIEW_FRAME CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)

#define FRAME_ORIGIN_X(view) view.frame.origin.x
#define FRAME_ORIGIN_Y(view) view.frame.origin.y

#define FRAME_SIZE_W(view) view.frame.size.width
#define FRAME_SIZE_H(view) view.frame.size.height

#define SET_FRAME_ORIGIN(view,origin) [view setFrame:CGRectMake(origin.x, origin.y, FRAME_SIZE_W(view), FRAME_SIZE_H(view))]

#define SET_FRAME_SIZE(view,size) [view setFrame:CGRectMake(FRAME_ORIGIN_X(view), FRAME_ORIGIN_Y(view), size.width, size.height)]


#define BUNDLE_NAME [[[NSBundle mainBundle]infoDictionary] valueForKey:@"CFBundleName"]

#define BUNDLE_BASE_URL [urls basUrlForBundle]




#define METERS_PER_MILE 1609.344



#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]

#endif /* ASCMacros_h */
