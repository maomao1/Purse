//
//  JCAlertStyle.m
//  JCAlertController
//
//  Created by HJaycee on 2017/4/5.
//  Copyright © 2017年 HJaycee. All rights reserved.
//

#import "JCAlertStyle.h"

#define JCColor(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define JCDefaultTextColor JCColor(0,0,0)

@interface JCAlertStyleCache : NSObject

@property (nonatomic, strong) JCAlertStyle *styleNormal;
@property (nonatomic, strong) JCAlertStyle *styleTitleOnly;
@property (nonatomic, strong) JCAlertStyle *styleContentOnly;

@end

@implementation JCAlertStyleCache
@end

@implementation JCAlertStyleAlertView @end
@implementation JCAlertStyleBackground @end
@implementation JCAlertStyleTitle @end
@implementation JCAlertStyleContent @end
@implementation JCAlertStyleButton @end
@implementation JCAlertStyleButtonNormal @end
@implementation JCAlertStyleButtonCancel @end
@implementation JCAlertStyleButtonWarning @end
@implementation JCAlertStyleSeparator @end

@implementation JCAlertStyle

+ (instancetype)shareStyle {
    static JCAlertStyle *style = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        style = [JCAlertStyle new];
        // default
        [style useDefaultStyle];
    });
    return style;
}

+ (JCAlertStyle *)styleWithType:(JCAlertType)type {
    static JCAlertStyleCache *cache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = [JCAlertStyleCache new];
        cache.styleNormal = [[JCAlertStyle alloc] initWithType:JCAlertTypeNormal];
        cache.styleTitleOnly = [[JCAlertStyle alloc] initWithType:JCAlertTypeTitleOnly];
        cache.styleContentOnly = [[JCAlertStyle alloc] initWithType:JCAlertTypeContentOnly];
    });
    
    if (type == JCAlertTypeNormal) {
        return cache.styleNormal;
    } else if (type == JCAlertTypeTitleOnly) {
        return cache.styleTitleOnly;
    } else {
        return cache.styleContentOnly;
    }
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

- (instancetype)initWithType:(JCAlertType)type {
    if (self = [super init]) {
        [self useDefaultStyle];
        
        if (type == JCAlertTypeTitleOnly) {
            [self useTitleOnlyStyle];
        } else if (type == JCAlertTypeContentOnly) {
            [self useContentOnlyStyle];
        }
    }
    return self;
}

#pragma clang diagnostic pop

- (void)useDefaultStyle {
    JCAlertStyleBackground *background = [JCAlertStyleBackground new];
    background.blur = NO;
    background.canDismiss = NO;
    background.alpha = 0.5;
    
    JCAlertStyleAlertView *alertView = [JCAlertStyleAlertView new];
    alertView.width = [UIScreen mainScreen].bounds.size.width == 320 ? 260 : 280;
    alertView.maxHeight = [UIScreen mainScreen].bounds.size.height - 120;
    alertView.backgroundColor = [UIColor whiteColor];
    alertView.cornerRadius = 8;
    
    JCAlertStyleTitle *title = [JCAlertStyleTitle new];
    title.insets = UIEdgeInsetsMake(20, 19, 20, 19);
    title.onlyTitleInsets = UIEdgeInsetsMake(30, 20, 30, 20);
    title.font = [UIFont boldSystemFontOfSize:16];
    title.textColor = UIColorFromRGBValue(0x333333);
    title.backgroundColor = [UIColor whiteColor];
    
    JCAlertStyleContent *content = [JCAlertStyleContent new];
    CGFloat space = 19;
    if (kScreenWidth == 320) {
        space = 15;
    }
    content.insets = UIEdgeInsetsMake(0, space, 20, space);
    content.onlyMessageInsets = UIEdgeInsetsMake(28, 20, 28, 20);
    content.font = [UIFont systemFontOfSize:14];
    content.textColor = UIColorFromRGBValue(0x666666);
    content.backgroundColor = [UIColor whiteColor];
    
    JCAlertStyleButtonNormal *buttonNormal = [JCAlertStyleButtonNormal new];
    buttonNormal.height = 46;
    buttonNormal.font = [UIFont systemFontOfSize:17];
    buttonNormal.textColor = JCDefaultTextColor;
    buttonNormal.backgroundColor = [UIColor whiteColor];
    buttonNormal.highlightTextColor = JCDefaultTextColor;
    buttonNormal.highlightBackgroundColor = JCColor(224, 224, 224);
    
    JCAlertStyleButtonCancel *buttonCancel = [JCAlertStyleButtonCancel new];
    buttonCancel.height = 46;
    buttonCancel.font = [UIFont systemFontOfSize:16];
    buttonCancel.textColor = UIColorFromRGBValue(0x333333);
    buttonCancel.backgroundColor = [UIColor whiteColor];
    buttonCancel.highlightTextColor = UIColorFromRGBValue(0x333333);
    buttonCancel.highlightBackgroundColor = JCColor(224, 224, 224);
    
    JCAlertStyleButtonWarning *buttonWarning = [JCAlertStyleButtonWarning new];
    buttonWarning.height = 46;
    buttonWarning.font = [UIFont boldSystemFontOfSize:16];
    buttonWarning.textColor = kButtonNormalBackgroundColor;
    buttonWarning.backgroundColor = [UIColor whiteColor];
    buttonWarning.highlightTextColor = kButtonNormalBackgroundColor;
    buttonWarning.highlightBackgroundColor = JCColor(224, 224, 224);
    
    JCAlertStyleSeparator *separator = [JCAlertStyleSeparator new];
    separator.width = 0.5;
    separator.color = [UIColor colorWithWhite:.0 alpha:.2f];
    
    self.background = background;
    self.alertView = alertView;
    self.title = title;
    self.content = content;
    self.buttonNormal = buttonNormal;
    self.buttonCancel = buttonCancel;
    self.buttonWarning = buttonWarning;
    self.separator = separator;
}

- (void)useTitleOnlyStyle {
    self.title.insets = UIEdgeInsetsMake(35, 20, 35, 20);
}

- (void)useContentOnlyStyle {
    self.content.insets = UIEdgeInsetsMake(28, 20, 28, 20);
}

@end
