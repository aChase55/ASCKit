//
//  ASCAlertVC.h
//  Pods
//
//  Created by Alex Chase on 3/16/16.
//
//

#import "ASCModalViewController.h"
#import "ASCPageView.h"

/**********************************************
 *ASCAlertStyle sets the color of the heading
 *and button on the alert
 **********************************************/
typedef NS_ENUM(NSInteger, ASCAlertStyle){
    ASCAlertStyleDefault,
    ASCAlertStyleSuccess,
    ASCAlertStyleWarning,
    ASCAlertStyleError,
    ASCAlertStyleCustom
};

typedef NS_ENUM(NSInteger, ASCAlertAnimationStyle){
    ASCAlertAnimationStyleFadeIn,
    ASCAlertAnimationStyleDropBounceDown,
    ASCAlertAnimationStyleBounceUp,
    ASCAlertAnimationStyleFadeOut,
    ASCAlertAnimationStyleRiseOut,
};


typedef NS_ENUM(NSInteger, ASCInputType){
    ASCInputTypePhoneNumber,
    ASCInputTypeName,
    ASCInputTypeEmail,
    ASCInputTypeAddress,
    ASCInputTypePassword
};



@interface ASCAlertVC : ASCModalViewController

/*************************************************
 *Class convience initializers
 *If no confirm block is set = Default Confrim
 *Cancel Button only shows if cancel block is set
 *************************************************/

+(instancetype)errorAlertWithDetails:(NSString *)detailText;

+(instancetype)alertWithText:(NSString *)alertText
                  detailText:(NSString *)detailText
                       style:(ASCAlertStyle)style;

+(instancetype)alertWithText:(NSString *)alertText
                  detailText:(NSString *)detailText
                       style:(ASCAlertStyle)style
                confirmBlock:(void (^)())confirmBlock;

+(instancetype)alertWithText:(NSString *)alertText
                  detailText:(NSString *)detailText
                       style:(ASCAlertStyle)style
                confirmBlock:(void (^)())confirmBlock
                 cancelBlock:(void(^)())cancelBlock;

+(instancetype)alertWithText:(NSString *)alertText
                  detailText:(NSString *)detailText
                       style:(ASCAlertStyle)style
                 showsCancel:(BOOL)showsCancel
                confirmBlock:(void (^)())confirmBlock;


+(instancetype)alertWithalertWithText:(NSString *)alertText
                           detailText:(NSString *)detailText
                                style:(ASCAlertStyle)style
                            inputType:(ASCInputType)inputType
                           validBlock:(BOOL (^)(NSString *inputText))validationBlock
                         confirmBlock:(void (^)())confirmBlock
                          cancelBlock:(void (^)())cancelBlock;





-(void)setConfrimText:(NSString *)confrimText;
-(void)setCancelText :(NSString *)cancel;
-(void)setCustomColor:(UIColor *)customColor;

@property (nonatomic,assign)ASCAlertAnimationStyle animateInStyle;
@property (nonatomic,assign)ASCAlertAnimationStyle animateOutStyle;
@property (nonatomic,strong)NSString *inputText;

@end


@interface ASCAlertView : ASCPageView

+(instancetype)alertWithText:(NSString *)text
                 description:(NSString *)description
                       style:(ASCAlertStyle)style
                      cancel:(BOOL)cancel;
-(void)setupStyle;
@property(nonatomic,strong)UIColor *customColor;
@property(nonatomic,strong)UIColor *alertColor;

@property (nonatomic,strong)NSString *alertText;
@property (nonatomic,strong)NSString *descriptionText;

@property (nonatomic,strong)UIButton *confirmButton;
@property (nonatomic,strong)UIButton *cancelButton;

@property (nonatomic,strong)UILabel *alertLabel;
@property (nonatomic,strong)UILabel *descriptionLabel;

@property (nonatomic,assign)BOOL hasCancel;

@property (nonatomic,assign)ASCAlertStyle alertStyle;

@property (nonatomic,strong)UITextField *textField;

@end


@interface ASCInputTextAlertView : ASCAlertView

+(instancetype)alertWithText:(NSString *)text
                 description:(NSString *)description
                       style:(ASCAlertStyle)style
                   inputType:(ASCInputType)inputType
                      cancel:(BOOL)cancel;

@property (nonatomic,assign)ASCInputType inputType;

@end
