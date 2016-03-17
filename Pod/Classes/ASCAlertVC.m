//
//  ASCAlertVC.m
//  Pods
//
//  Created by Alex Chase on 3/16/16.
//
//

#define K_ALERT_W 284
#define K_ALERT_H 168

#import "ASCAlertVC.h"
#import "ASCLabel.h"
#import "ASCPaperButton.h"

@interface ASCAlertVC(){
    CGRect      _alertDefaultFrame;
    CGRect      _alertAnimationFrame;
}

//Blocks for completion handling
@property (nonatomic, copy) void (^alertConfirmBlock)();
@property (nonatomic, copy) void (^alertCancelBlock)();
@property (nonatomic, copy) BOOL (^alertValidationBlock)(NSString *inputText);

@property (nonatomic,strong)ASCAlertView *alertView;
@property (nonatomic,assign)BOOL hasCancel;

@end



@implementation ASCAlertVC

#pragma mark - Class Initializers
+(instancetype)errorAlertWithDetails:(NSString *)detailText{
    return [ASCAlertVC alertWithText:@"Error" detailText:detailText style:ASCAlertStyleError];
}

+(instancetype)alertWithText:(NSString *)alertText detailText:(NSString *)detailText style:(ASCAlertStyle)style{
    return [ASCAlertVC alertWithText:alertText detailText:detailText style:style confirmBlock:nil];
}

+(instancetype)alertWithText:(NSString *)alertText
                  detailText:(NSString *)detailText
                       style:(ASCAlertStyle)style
                 showsCancel:(BOOL)showsCancel{
    return [ASCAlertVC alertWithText:alertText detailText:detailText style:style confirmBlock:nil cancelBlock:nil];
}

+(instancetype)alertWithText:(NSString *)alertText
                  detailText:(NSString *)detailText
                       style:(ASCAlertStyle)style
                confirmBlock:(void (^)())confirmBlock{
    return [ASCAlertVC alertWithText:alertText detailText:detailText style:style confirmBlock:confirmBlock cancelBlock:nil];
}

+(instancetype)alertWithText:(NSString *)alertText
                  detailText:(NSString *)detailText
                       style:(ASCAlertStyle)style
                confirmBlock:(void (^)())confirmBlock
                 cancelBlock:(void(^)())cancelBlock{
    return [[ASCAlertVC alloc]initWithAlertWithText:alertText detailText:detailText style:style confirmBlock:confirmBlock cancelBlock:cancelBlock];
}

+(instancetype)alertWithText:(NSString *)alertText
                  detailText:(NSString *)detailText
                       style:(ASCAlertStyle)style
                 showsCancel:(BOOL)showsCancel
                confirmBlock:(void (^)())confirmBlock{
    return [[ASCAlertVC alloc]initWithAlertWithText:alertText detailText:detailText style:style showsCancel:showsCancel confirmBlock:confirmBlock];
}

+(instancetype)alertWithalertWithText:(NSString *)alertText
                           detailText:(NSString *)detailText
                                style:(ASCAlertStyle)style
                            inputType:(ASCInputType)inputType
                           validBlock:(BOOL (^)(NSString *inputText))validationBlock
                         confirmBlock:(void (^)())confirmBlock
                          cancelBlock:(void (^)())cancelBlock{
    return [[ASCAlertVC alloc]initWithAlertWithText:alertText
                                       detailText:detailText
                                            style:style
                                        inputType:inputType
                                       validBlock:validationBlock
                                     confirmBlock:confirmBlock
                                      cancelBlock:cancelBlock];
}


#pragma mark - instance initializers

-(instancetype)initWithAlertWithText:(NSString *)alertText
                          detailText:(NSString *)detailText
                               style:(ASCAlertStyle)style
                           inputType:(ASCInputType)inputType
                          validBlock:(BOOL (^)(NSString *inputText))validationBlock
                        confirmBlock:(void (^)())confirmBlock
                         cancelBlock:(void(^)())cancelBlock{
    
    self = [super init];
    if (self) {
        self.hidesStatusBar = YES;
        self.alertConfirmBlock      = confirmBlock;
        self.alertValidationBlock   = validationBlock;
        if (cancelBlock) {
            _hasCancel = YES;
            self.alertCancelBlock   = cancelBlock;
        }
        self.animateInStyle  = ASCAlertAnimationStyleDropBounceDown;
        self.animateOutStyle = ASCAlertAnimationStyleRiseOut;
        self.alertView = [ASCInputTextAlertView alertWithText:alertText description:detailText style:style inputType:inputType cancel:_hasCancel];
        [self.view addSubview:self.alertView];
    }
    return self;
}



-(instancetype)initWithAlertWithText:(NSString *)alertText
                          detailText:(NSString *)detailText
                               style:(ASCAlertStyle)style
                         showsCancel:(BOOL)showsCancel
                        confirmBlock:(void (^)())confirmBlock{
    if (showsCancel) {
        self = [self initWithAlertWithText:alertText detailText:detailText style:style confirmBlock:confirmBlock cancelBlock:^{}];
    }else{
        self = [self initWithAlertWithText:alertText detailText:detailText style:style confirmBlock:confirmBlock cancelBlock:nil];
    }
    return self;
}

//Only has cancel button if cancelBlock !=nil
-(instancetype)initWithAlertWithText:(NSString *)alertText
                          detailText:(NSString *)detailText
                               style:(ASCAlertStyle)style
                        confirmBlock:(void (^)())confirmBlock
                         cancelBlock:(void(^)())cancelBlock{
    self = [super init];
    if (self) {
        
        self.hidesStatusBar = YES;
        self.alertConfirmBlock = confirmBlock;
        if (cancelBlock) {
            _hasCancel = YES;
            self.alertCancelBlock  = cancelBlock;
        }
        self.animateInStyle  = ASCAlertAnimationStyleDropBounceDown;
        self.animateOutStyle = ASCAlertAnimationStyleRiseOut;
        self.alertView = [ASCAlertView alertWithText:alertText description:detailText style:style cancel:_hasCancel];
        [self.view addSubview:self.alertView];
    }
    return self;
}


#pragma mark - Properties
-(void)setConfrimText:(NSString *)confrimText{
    [self.alertView.confirmButton setTitle:[confrimText uppercaseString] forState:UIControlStateNormal];
}
-(void)setCancelText:(NSString *)cancelText{
    [self.alertView.cancelButton setTitle:[cancelText uppercaseString] forState:UIControlStateNormal];
}
-(void)setAnimateInStyle:(ASCAlertAnimationStyle)animateInStyle{
    _animateInStyle = animateInStyle;
}
-(void)setAnimateOutStyle:(ASCAlertAnimationStyle)animateOutStyle{
    _animateOutStyle = animateOutStyle;
}



#pragma mark -vc delegates
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAnimationFramesForAlertStyle];
    [self setTargetSelectors];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self animateAlertViewIn];
    if (self.alertValidationBlock && self.alertView.textField) {
        [self.alertView.textField becomeFirstResponder];
    }
}


#pragma mark -Alert Animation Setup

-(void)setAnimationFramesForAlertStyle{
    
    //Prepare Alert Frame for animation
   
    _alertDefaultFrame = self.alertView.frame;
    switch (self.animateInStyle) {
            
        case ASCAlertAnimationStyleDropBounceDown:
            
            _alertAnimationFrame = CGRectMake(CGRectGetMinX(_alertView.frame),
                                            -CGRectGetHeight(_alertView.frame)-6, //so you dont see the shadow when it starts
                                              CGRectGetWidth(_alertView.frame),
                                              CGRectGetHeight(_alertView.frame));
            [self.alertView setFrame:_alertAnimationFrame];
            break;
            
        case ASCAlertAnimationStyleBounceUp:
            
            _alertAnimationFrame = CGRectMake(CGRectGetMinX(_alertView.frame),
                                              SCREEN_HEIGHT+CGRectGetHeight(_alertView.frame),
                                              CGRectGetWidth(_alertView.frame),
                                              CGRectGetHeight(self.alertView.frame));
            [self.alertView setFrame:_alertAnimationFrame];
            break;
            
        default:
            break;
    }
}

//Show Alert
-(void)animateAlertViewIn{
    
    switch (self.animateInStyle) {
       
        case ASCAlertAnimationStyleFadeIn:
            [self animateAlertInFade];
            break;
            
        case ASCAlertAnimationStyleDropBounceDown:
            [self animateAlertInBounceDown];
            break;
            
        case ASCAlertAnimationStyleBounceUp:
            [self animateAlertInBounceUp];
            break;
            
        default:
            break;
    }
}

-(void)dismissAlertWithCompletion:(void (^)())completionBlock{
    
    __weak typeof(self)weakSelf = self;
    
    
    //New completion block that dismisses the alert VC and calls the user defined completion block
    void (^alertCompletionBlock)()=^void(){
        
        [weakSelf dismissViewControllerAnimated:YES completion:completionBlock];
    };
    
    switch (self.animateOutStyle) {
            
        case ASCAlertAnimationStyleRiseOut:
            [self animateAlertViewOutRiseCompletion:alertCompletionBlock];
            break;
            
        case ASCAlertAnimationStyleFadeOut:
            [self animateAlertViewOutFadeCompletion:alertCompletionBlock];
            break;
            
        default:
            break;
    }
}

#pragma mark - Alert Animation Methods
//In
-(void)animateAlertInFade{
    [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        [self.alertView setAlpha:1.0f];
        
    } completion:nil];
}

-(void)animateAlertInBounceDown{
    [UIView animateWithDuration:1.0f delay:0.15f usingSpringWithDamping:0.5 initialSpringVelocity:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [self.alertView setFrame:_alertDefaultFrame];

    } completion:nil];
}

-(void)animateAlertInBounceUp{
    [UIView animateWithDuration:0.3f delay:0.0f usingSpringWithDamping:0.6 initialSpringVelocity:0.7 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [self.alertView setFrame:_alertDefaultFrame];
    } completion:nil];
}


//Out
-(void)animateAlertViewOutRiseCompletion:(void (^)())completionBlock{
    [UIView animateWithDuration:0.1f delay:0.3f options:UIViewAnimationOptionCurveEaseIn animations:^{
        [self.alertView setFrame:_alertAnimationFrame];
        [self.alertView setAlpha:0.0f];

    }completion:^(BOOL finished) {
        if (finished&&completionBlock)
            completionBlock();
    }];
}
-(void)animateAlertViewOutFadeCompletion:(void (^)())completionBlock{
    [UIView animateWithDuration:0.2f delay:0.3f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.alertView setAlpha:0.0f];
    } completion:^(BOOL finished) {
        if (finished&&completionBlock)
            completionBlock();
    }];
}


#pragma mark - Target Setup
-(void)setTargetSelectors{
    [self.alertView.confirmButton    addTarget:self action:@selector(alertConfrimPressed) forControlEvents:UIControlEventTouchUpInside];
    if (self.alertView.cancelButton){
        [self.alertView.cancelButton addTarget:self action:@selector(alertCancelPressed)  forControlEvents:UIControlEventTouchUpInside];
    }
}
-(void)alertConfrimPressed{
    
    [self dismissAlertWithCompletion:self.alertConfirmBlock];
    /*
    if (self.alertValidationBlock) {
        NSString *text = [(VODInputTextAlertView *)self.alertView textField].text;
        if(self.alertValidationBlock(text)){
            [self dismissAlertWithCompletion:self.alertConfirmBlock];
        }
    }
    else{
    }*/
}
-(void)alertCancelPressed{
    [self dismissAlertWithCompletion:self.alertCancelBlock];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    UITouch *touch =[touches anyObject];
    if(![[touch view] isKindOfClass:[ASCAlertView class]]){
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
@end


#pragma mark - ASCAlertView
@interface ASCAlertView(){
    CGFloat _alertWidth;
    CGFloat _alertHeight;
}
@end
@implementation ASCAlertView


#pragma mark - alert view initialzers

+(instancetype)alertWithText:(NSString *)text description:(NSString *)description style:(ASCAlertStyle)style cancel:(BOOL)cancel{
    return [[ASCAlertView alloc]initWithAlertText:text description:description alertStyle:style hasCancel:cancel];
}

-(instancetype)initWithAlertText:(NSString *)alertText description:(NSString *)description alertStyle:(ASCAlertStyle )style hasCancel:(BOOL)hasCancel{
    self = [super initWithHeading:[alertText uppercaseString]];
    if (self) {
        _alertStyle = style;
        _alertText  = alertText;
        _hasCancel = hasCancel;
        _descriptionText = description;
        //self.alpha = 0.0f;
        self.clipsToBounds = NO;
        [self setupViews];
    }
    return self;
}


#pragma mark -alert view layout

-(void)setupViews{
    
    [self setupStyle];
    [self setupPageFrame];
    [self setupTextViews];
    [self setupButtons];
}

-(void)setupPageFrame{
    
    _alertWidth = K_ALERT_W;
    _alertHeight = K_ALERT_H;
    CGFloat alertY = (SCREEN_HEIGHT/2)-_alertHeight;
    CGFloat alertX = (SCREEN_WIDTH-_alertWidth)/2;
    [self setFrame:CGRectMake(alertX, alertY,_alertWidth, _alertHeight)];
}

-(void)setupTextViews{
    
    [self setupHeadingLabel];
    [self setupDescriptionLabel];
}

-(void)setupHeadingLabel{
    
    [self.headingLabel setFrame:CGRectMake(0, 0, self.frame.size.width, DEFAULT_HEIGHT)];
    self.headingLabel.backgroundColor = _alertColor;
    self.headingLabel.layer.cornerRadius = 2.0f;
    self.headingLabel.textColor = [UIColor whiteColor];
    self.headingLabel.clipsToBounds = YES;
    self.headingLabel.textAlignment = NSTextAlignmentCenter;
    self.headingLabel.font = [UIFont fontWithName:BODY_FONT_NORMAL size:16];
    self.dividorLine.backgroundColor = _alertColor;
    
    //removes rounded corners from header
    [self.dividorLine setFrame:CGRectMake(0, CGRectGetMaxY(self.headingLabel.frame)-2, _alertWidth, 4)];
}

-(void)setupDescriptionLabel{
    
    _descriptionLabel =  [[UILabel alloc]init];
    [_descriptionLabel setText:_descriptionText];
    [_descriptionLabel setTextColor:[UIColor paperColorGray900]];
    _descriptionLabel.textAlignment = NSTextAlignmentCenter;
    [_descriptionLabel setNumberOfLines:0];
    [self updateAlertSizeToFitText];
    
}

-(void)updateAlertSizeToFitText{
    
    CGSize textViewSize = [_descriptionLabel sizeThatFits:CGSizeMake(CGRectGetWidth(self.frame)-2*DIVINE_SPACING, FLT_MAX)];
    [_descriptionLabel setFrame:CGRectMake(DIVINE_SPACING, 64, CGRectGetWidth(self.frame)-2*DIVINE_SPACING, textViewSize.height)];
    [self addSubview:_descriptionLabel];
    
    [self setFrame:CGRectMake(CGRectGetMinX(self.frame), FRAME_ORIGIN_Y(self)+DEFAULT_SPACING, CGRectGetWidth(self.frame), CGRectGetMaxY(_descriptionLabel.frame)+GIANT_SPACING+DEFAULT_HEIGHT)];
}

-(void)setupButtons{
    
    CGFloat buttonWidth =  _hasCancel?  _alertWidth/2:_alertWidth;
    CGFloat buttonOrigin = _hasCancel?  buttonWidth:0;
    CGFloat buttonHeight = DEFAULT_HEIGHT;
    CGRect buttonFrame = CGRectMake(buttonOrigin, CGRectGetHeight(self.frame)-buttonHeight, buttonWidth, buttonHeight);
    CGFloat buttonCornerRadius = 2.0f;
    
    self.confirmButton = [[ASCPaperButton alloc]initWhiteBgFlatWithText:@"Confirm" color:_alertColor];
    [self.confirmButton setFrame:buttonFrame];
    _confirmButton.layer.cornerRadius = buttonCornerRadius;
    [self addSubview:self.confirmButton];
    
    if (_hasCancel) {
        CGRect cancelFrame = CGRectMake(0, CGRectGetHeight(self.frame)-buttonHeight, buttonWidth, buttonHeight);
        _cancelButton = [[ASCPaperButton alloc]initWhiteBgFlatWithText:@"Cancel" color:[UIColor paperColorGray]];
        _cancelButton.layer.cornerRadius = buttonCornerRadius;
        [_cancelButton setFrame:cancelFrame];
        [self addSubview:_cancelButton];
    }
}


#pragma mark -alert colors and background

-(void)setupStyle{
    [self setColorForStyle:_alertStyle];
}
-(void)setColorForStyle:(ASCAlertStyle)style{
    switch (style) {
        case ASCAlertStyleDefault:
            self.alertColor = [UIColor paperColorPurple];
            break;
        case ASCAlertStyleSuccess:
            self.alertColor = [UIColor paperColorGreen];
            break;
        case ASCAlertStyleWarning:
            self.alertColor = [UIColor paperColorYellow];
            break;
        case ASCAlertStyleError:
            self.alertColor = [UIColor paperColorRed];
            break;
        case ASCAlertStyleCustom:
            self.alertColor = self.customColor;
            break;
        default:
            break;
    }
}
@end


//TODO
@interface ASCInputTextAlertView()
@end
@implementation ASCInputTextAlertView
+(instancetype)alertWithText:(NSString *)text
                 description:(NSString *)description
                       style:(ASCAlertStyle)style
                   inputType:(ASCInputType)inputType
                      cancel:(BOOL)cancel{
    return nil;
}
@end






