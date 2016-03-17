//
//  ASCNotificationView.h
//  Pods
//
//  Created by Alex Chase on 1/20/16.
//
//

#import <UIKit/UIKit.h>

/*********************************************
 ASCNotificationType determines the color of
 the notification
 *********************************************/
typedef NS_ENUM(NSInteger, ASCNotificationType){
    ASCNotificationTypeDefault,
    ASCNotificationTypeSuccess,
    ASCNotificationTypeWarning,
    ASCNotificationTypeError
};

/*********************************************
 ASCNotificationStyle determines the size of
 the notification
 Currently:
 
 ASCNotificationStyleSmall -
 set from macro NOTIFICATION_HEIGHT_SMALL 20.0f
 ASCNotificationStyleLarge-
 set from macro NOTIFICATION_HEIGHT_LARGE 64.0f
 
 //TODO: Change Notification Sizing from
 hard-coded macros to properties
 *********************************************/

typedef NS_ENUM(NSInteger, ASCNotificationStyle) {
    ASCNotificationStyleSmall,
    ASCNotificationStyleLarge
};



@interface ASCNotificationView : UIToolbar

//Completion Handler
@property (nonatomic, copy) void (^onTouch)();
@property (nonatomic,strong)UITapGestureRecognizer *tapGesture;

@property (nonatomic,assign)ASCNotificationType notificationType;
@property (nonatomic,assign)ASCNotificationStyle notificationStyle;

@property (nonatomic,strong)NSTimer *notificationTimer;

@property (nonatomic,strong)UIImageView *notificationImageView;
@property (nonatomic,strong)UILabel *notificationLabel;

@property (nonatomic,assign)CGFloat animationTime;
@property (nonatomic,assign)CGFloat notificationDuration;



//Subclass and override for customization
-(UIColor *)defaultColor;
-(UIColor *)successColor;
-(UIColor *)warningColor;
-(UIColor *)errorColor;

/*********************************************
 ASCNotification class display methods
 *********************************************/

//Small Notifications, autohide, no completion
+(void)shortErrorWithMessage:  (NSString *)message;
+(void)shortSuccessWithMessage:(NSString *)message;
+(void)shortWarningWithMessage:(NSString *)message;
+(void)shortDefaultWithMessage:(NSString *)message;

//Large Notifications, no autohide, optional completion
+(void)longtErrorWithMessage: (NSString *)message onTouch:(void (^)())onTouch;
+(void)longSuccessWithMessage:(NSString *)message onTouch:(void (^)())onTouch;
+(void)longWarningWithMessage:(NSString *)message onTouch:(void (^)())onTouch;
+(void)longDefaultWithMessage:(NSString *)message onTouch:(void (^)())onTouch;

//More Verbose
+ (void)displayNotificationWithType:(ASCNotificationType)type style:(ASCNotificationStyle)style message:(NSString *)message;
+ (void)displayNotificationWithType:(ASCNotificationType)type style:(ASCNotificationStyle)style message:(NSString *)message isAutoHide:(BOOL)isAutoHide;
+ (void)displayNotificationWithType:(ASCNotificationType)type style:(ASCNotificationStyle)style message:(NSString *)message isAutoHide:(BOOL)isAutoHide onTouch:(void (^)())onTouch;

//Hiding
+ (void)hideNotificationView;
+ (void)hideNotificationViewOnComplete:(void (^)())onComplete;



@end
