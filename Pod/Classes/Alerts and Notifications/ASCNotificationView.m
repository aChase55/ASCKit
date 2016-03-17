//
//  ASCNotificationView.m
//  Pods
//
//  Created by Alex Chase on 1/20/16.
//
//

//SIZING
#define NOTIFICATION_FRAME_SMALL            CGRectMake(0.0, 0.0, SCREEN_WIDTH, STATUS_BAR_HEIGHT)
#define NOTIFICATION_FRAME_LARGE            CGRectMake(0.0, 0.0, SCREEN_WIDTH, STATUS_NAV_HEIGHT)

#import "ASCNotificationView.h"

@interface ASCNotificationView()
@property(nonatomic,assign)BOOL isShowingNotification;
@property (nonatomic,assign)BOOL shouldAnimateImage;
@end


@implementation ASCNotificationView


#pragma mark - Initializers
+ (instancetype)sharedInstance{
    static id _sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[[self class] alloc] init];
    });
    return _sharedInstance;
}

-(instancetype)init{
    
    self =[super initWithFrame:NOTIFICATION_FRAME_LARGE];
    if (self) {
        
        self.layer.zPosition = MAXFLOAT;
        self.multipleTouchEnabled = NO;
        self.exclusiveTouch = YES;
        self.translucent = NO;
        _notificationDuration = 3.0f;
        _animationTime = 0.3f;
        
        if (![_notificationImageView superview]) {
            [self addSubview:self.notificationImageView];
        }
        
        if (![_notificationLabel superview]) {
            [self addSubview:self.notificationLabel];
        }
        
        [self setupGestureRecognizer];
    }
    return self;
}

/// -------------------------------------------------------------------------------------------
#pragma mark - ui setup
/// -------------------------------------------------------------------------------------------



 #define NOTIFICATION_IMAGE_SIZE             30.0f
 #define NOTIFICATION_IMAGE_ORIGIN_X         14.0f
 #define NOTIFICATION_IMAGE_ORIGIN_Y         20.0f

 
-(UIImageView *)notificationImageView{
    if (!_notificationImageView) {
        
        _notificationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(NOTIFICATION_IMAGE_ORIGIN_X,
                                                                               (self.frame.size.height-NOTIFICATION_IMAGE_SIZE)/2,
                                                                               NOTIFICATION_IMAGE_SIZE,
                                                                               NOTIFICATION_IMAGE_SIZE)];
        
        
        NSString *sharedBundlePath = [[NSBundle bundleForClass:self.class] pathForResource:@"ASCKit" ofType:@"bundle"];
        NSBundle *podBundle = [NSBundle bundleWithPath:sharedBundlePath];
        NSURL *imgUrl = [podBundle URLForResource:@"loading_circle" withExtension:@"png"];
        NSData *imgData = [NSData dataWithContentsOfURL:imgUrl];
        
        UIImage *loadingImage = [UIImage imageWithData:imgData];
        [_notificationImageView setImage:loadingImage];
        [_notificationImageView setContentMode:UIViewContentModeScaleAspectFit];
        [_notificationImageView setClipsToBounds:YES];
    }
    return _notificationImageView;
}





-(UILabel *)notificationLabel{
    if (!_notificationLabel) {
        _notificationLabel = [[UILabel alloc] init];
        [_notificationLabel setTextColor:[UIColor whiteColor]];
        [_notificationLabel setText:@"Your message is notified"];
        [_notificationLabel setNumberOfLines:1];
    }
    return _notificationLabel;
}


/// -------------------------------------------------------------------------------------------
#pragma mark - gesture recognizers
/// -------------------------------------------------------------------------------------------

-(void)setupGestureRecognizer{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(notificationViewDidTap:)];
    [self addGestureRecognizer:tapGesture];
}

- (void)notificationViewDidTap:(UIGestureRecognizer *)gesture{
    [self animateNotificationOutOnComplete:_onTouch];
}


/// -------------------------------------------------------------------------------------------
#pragma mark - style setup
/// -------------------------------------------------------------------------------------------

-(void)setNotificationStyle:(ASCNotificationStyle)notificationStyle{
    _notificationStyle = notificationStyle;
    switch (_notificationStyle) {
        case ASCNotificationStyleLarge:
            [self setupLargeNotification];
            break;
            
        case ASCNotificationStyleSmall:
            [self setupSmallNotification];
            break;
        default:
            break;
    }
    [_notificationLabel setFrame:self.bounds];
}

-(void)setupLargeNotification{
    
    [_notificationLabel removeFromSuperview];
    
    _notificationLabel = nil;
    [self setFrame:NOTIFICATION_FRAME_LARGE];
    _notificationImageView.hidden = NO;
    [self addSubview:self.notificationLabel];
    
    [_notificationLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_notificationImageView).with.offset(5);
        make.left.equalTo(_notificationImageView.right).with.offset(LARGE_SPACING);
        make.right.equalTo(self);
    }];
    
}
-(void)setupSmallNotification{
    
    [_notificationLabel removeFromSuperview];
    _notificationLabel = nil;
    
    [self setFrame:NOTIFICATION_FRAME_SMALL];
    
    _notificationImageView.hidden = YES;
    [self addSubview:self.notificationLabel];
  //  [_notificationLabel setFont:NOTIFICATION_FONT_SMALL];
    [_notificationLabel setFrame:self.bounds];
    _notificationLabel.textAlignment = NSTextAlignmentCenter;
}


/// -------------------------------------------------------------------------------------------
#pragma mark - type setup
/// -------------------------------------------------------------------------------------------

-(void)setNotificationType:(ASCNotificationType)notificationType{
    _notificationType = notificationType;
    switch (_notificationType) {
            
        case ASCNotificationTypeDefault:
            [self setNotificationTypeDefault];
            break;
        case ASCNotificationTypeSuccess:
            [self setNotificationTypeSuccess];
            break;
            
        case ASCNotificationTypeWarning:
            [self setNotificationTypeWarning];
            break;
            
        case ASCNotificationTypeError:
            [self setNotificationTypeError];
            break;
        default:
            break;
    }
}
-(void)setNotificationTypeDefault{
    [self setBarTintColor:[[ASCStyleManager sharedStyle]defaultColor]];
    if (!_notificationImageView.hidden) {
     //   [_notificationImageView setImage:NOTIFICATION_IMAGE_LOADING];
    }
}
-(void)setNotificationTypeSuccess{
    [self setBarTintColor:[[ASCStyleManager sharedStyle]successColor]];

    if (!_notificationImageView.hidden) {
      //  [_notificationImageView setImage:NOTIFICATION_IMAGE_SUCCESS];
    }
}
-(void)setNotificationTypeWarning{
    [self setBarTintColor:[[ASCStyleManager sharedStyle]warningColor]];
    if (!_notificationImageView.hidden) {
      //  [_notificationImageView setImage:NOTIFICATION_IMAGE_WARNING];
    }
}
-(void)setNotificationTypeError{
    [self setBarTintColor:[[ASCStyleManager sharedStyle]errorColor]];
    if (!_notificationImageView.hidden) {
      //  [_notificationImageView setImage:NOTIFICATION_IMAGE_ERROR];
    }
}







/// -------------------------------------------------------------------------------------------
#pragma mark - animation methods
/// -------------------------------------------------------------------------------------------

-(void)displayNotification{
    [self prepareFrameForAnimation];
    [self animateNotificationIn];
    [self rotateNotifactionImage];
}

-(void)prepareFrameForAnimation{
    [self setFrame:CGRectOffset(self.frame, 0, -self.frame.size.height)];
    [UIApplication sharedApplication].delegate.window.windowLevel = UIWindowLevelStatusBar;
    [[UIApplication sharedApplication].delegate.window addSubview:self];
}

-(void)animateNotificationIn{
    _isShowingNotification = YES;
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:_animationTime delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        [weakSelf setFrame:CGRectOffset(self.frame, 0, self.frame.size.height)];
    }
                     completion:nil];
}

- (void)animateNotificationViewOut{
    [self animateNotificationOutOnComplete:nil];
}

- (void)animateNotificationOutOnComplete:(void (^)())onComplete
{
    _isShowingNotification = NO;
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:_animationTime delay:0.0f options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         [weakSelf setFrame:CGRectOffset(self.frame, 0, -self.frame.size.height)];
                     }
                     completion:^(BOOL finished) {
                         [weakSelf clearNotification];
                         if (onComplete) {
                             onComplete();
                         }
                     }];
}


-(void)rotateNotifactionImage{
    if (self.shouldAnimateImage) {
        [self runSpinAnimationOnView:self.notificationImageView duration:_notificationDuration rotations:1 repeat:30];
    }
}


- (void) runSpinAnimationOnView:(UIView*)view duration:(CGFloat)duration rotations:(CGFloat)rotations repeat:(float)repeat;
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 * rotations * duration ];
    rotationAnimation.duration = duration;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = repeat;
    [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}


-(void)stopSpinAnimation{
    if (self.shouldAnimateImage) {
        [self.notificationImageView.layer removeAllAnimations];
    }
    self.shouldAnimateImage = NO;
}



/// -------------------------------------------------------------------------------------------
#pragma mark - timer setup
/// -------------------------------------------------------------------------------------------

-(NSTimer *)notificationTimer{
    if (!_notificationTimer) {
        _notificationTimer = [NSTimer scheduledTimerWithTimeInterval:_notificationDuration
                                                              target:self
                                                            selector:@selector(animateNotificationViewOut)
                                                            userInfo:nil
                                                             repeats:NO];
    }
    return _notificationTimer;
}
-(void)clearTimeer{
    if (_notificationTimer) {
        [_notificationTimer invalidate];
        _notificationTimer = nil;
    }
}



/// -------------------------------------------------------------------------------------------
#pragma mark - notification display
/// -------------------------------------------------------------------------------------------

- (void)showNotificationWithType:(ASCNotificationType)type style:(ASCNotificationStyle)style message:(NSString *)message isAutoHide:(BOOL)isAutoHide onTouch:(void (^)())onTouch{
    
    /// Clear Timer
    [self clearTimeer];
    
    /// Touch Block
    if (onTouch) {
        _onTouch = onTouch;
    }
    else{
        isAutoHide = YES;
    }
    
    //Setup Large//Small
    [self setNotificationStyle:style];
    
    //Setup Color//Image
    self.notificationType = type;
    
    //set text
    _notificationLabel.text = message;
    
    if (self.notificationType ==ASCNotificationTypeDefault && self.notificationStyle ==ASCNotificationStyleLarge) {
        self.shouldAnimateImage = YES;
    }
    
    //setup frame and animate
    [self displayNotification];
    
    if (isAutoHide) {
        [self notificationTimer];
    }
}

-(void)clearNotification{
    [self stopSpinAnimation];
    [self clearTimeer];
    [self removeFromSuperview];
    [UIApplication sharedApplication].delegate.window.windowLevel = UIWindowLevelNormal;
    if (self.onTouch) {
        self.onTouch();
    }
}


/// -------------------------------------------------------------------------------------------
#pragma mark - public methods
/// -------------------------------------------------------------------------------------------


//Small Notifications, autohide, no completion
+(void)shortErrorWithMessage:(NSString *)message{
    [ASCNotificationView displayNotificationWithType:ASCNotificationTypeError style:ASCNotificationStyleSmall message:message isAutoHide:YES onTouch:nil];
}
+(void)shortSuccessWithMessage:(NSString *)message{
    [ASCNotificationView displayNotificationWithType:ASCNotificationTypeSuccess style:ASCNotificationStyleSmall message:message isAutoHide:YES onTouch:nil];
}
+(void)shortWarningWithMessage:(NSString *)message{
    [ASCNotificationView displayNotificationWithType:ASCNotificationTypeWarning style:ASCNotificationStyleSmall message:message isAutoHide:YES onTouch:nil];
}
+(void)shortDefaultWithMessage:(NSString *)message{
    [ASCNotificationView displayNotificationWithType:ASCNotificationTypeDefault style:ASCNotificationStyleSmall message:message isAutoHide:YES onTouch:nil];
}

//Large Notifications, no autohide, optional completion
+(void)longtErrorWithMessage:(NSString *)message onTouch:(void (^)())onTouch{
    [ASCNotificationView displayNotificationWithType:ASCNotificationTypeError style:ASCNotificationStyleLarge message:message isAutoHide:NO onTouch:onTouch];
}
+(void)longSuccessWithMessage:(NSString *)message onTouch:(void (^)())onTouch{
    [ASCNotificationView displayNotificationWithType:ASCNotificationTypeSuccess style:ASCNotificationStyleLarge message:message isAutoHide:NO onTouch:onTouch];
}
+(void)longWarningWithMessage:(NSString *)message onTouch:(void (^)())onTouch{
    [ASCNotificationView displayNotificationWithType:ASCNotificationTypeWarning style:ASCNotificationStyleLarge message:message isAutoHide:NO onTouch:onTouch];
}
+(void)longDefaultWithMessage:(NSString *)message onTouch:(void (^)())onTouch{
    [ASCNotificationView displayNotificationWithType:ASCNotificationTypeDefault style:ASCNotificationStyleLarge message:message isAutoHide:NO onTouch:onTouch];
}


//Helper-ish
+ (void)displayNotificationWithType:(ASCNotificationType)type style:(ASCNotificationStyle)style message:(NSString *)message{
    [ASCNotificationView displayNotificationWithType:type style:style message:message isAutoHide:YES onTouch:nil];
}

+ (void)displayNotificationWithType:(ASCNotificationType)type style:(ASCNotificationStyle)style message:(NSString *)message isAutoHide:(BOOL)isAutoHide{
    [ASCNotificationView displayNotificationWithType:type style:style message:message isAutoHide:isAutoHide onTouch:nil];
}

//Common
+ (void)displayNotificationWithType:(ASCNotificationType)type style:(ASCNotificationStyle)style message:(NSString *)message isAutoHide:(BOOL)isAutoHide onTouch:(void (^)())onTouch{
    if ([[ASCNotificationView sharedInstance]isShowingNotification])
        [ASCNotificationView hideNotificationViewOnComplete:^{
            [[ASCNotificationView sharedInstance]showNotificationWithType:type style:style message:message isAutoHide:isAutoHide onTouch:onTouch];
        }];
    else
        [[ASCNotificationView sharedInstance]showNotificationWithType:type style:style message:message isAutoHide:isAutoHide onTouch:onTouch];
}

//Hiding
+ (void)hideNotificationView{
    [ASCNotificationView hideNotificationViewOnComplete:nil];
}
+ (void)hideNotificationViewOnComplete:(void (^)())onComplete{
    [[ASCNotificationView sharedInstance] animateNotificationOutOnComplete:onComplete];
}

//Properties
-(void)setNotificationDuration:(CGFloat)notificationDuration{
    _notificationDuration = notificationDuration;
}
-(void)setAnimationTime:(CGFloat)animationTime{
    _animationTime = animationTime;
}


@end
