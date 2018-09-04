//
//  UITextField+Limitation.m
//  trader-ios
//
//  Created by YYang on 11/6/18.
//  Copyright © 2018 Trader. All rights reserved.
//

#import "UITextField+Limitation.h"
#import <objc/runtime.h>

static char kMaxLength;

@interface UItextFieldMaxLengthObserver : NSObject

@end

@implementation UItextFieldMaxLengthObserver

- (void)textChange:(UITextField *)textField {
    NSString *destText = textField.text;
    NSUInteger maxLength = textField.maxLength;
    UITextRange *selectedRange = [textField markedTextRange];
    if (!selectedRange || !selectedRange.start) {
        if (destText.length > maxLength) {
            textField.text = [destText substringToIndex:maxLength];
        }
    }
}

@end

static UItextFieldMaxLengthObserver *observer;

@implementation UITextField (Limitation)
@dynamic maxLength;

+ (void)load {
    observer = [[UItextFieldMaxLengthObserver alloc] init];
}

- (void)setMaxLength:(NSUInteger)maxLength {
    objc_setAssociatedObject(self, &kMaxLength, @(maxLength), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (maxLength) {
        [self addTarget:observer
                 action:@selector(textChange:)
       forControlEvents:UIControlEventEditingChanged];
    }
}

-(NSUInteger)maxLength {
    NSNumber *number = objc_getAssociatedObject(self, &kMaxLength);
    return [number integerValue];
}

@end
