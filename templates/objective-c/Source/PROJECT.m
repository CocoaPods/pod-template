//
//  ${POD_NAME}.swift
//  ${POD_NAME}
//
//  Created by ${USER_NAME} on ${DATE}.
//  Copyright © ${YEAR} ${USER_NAME}. All rights reserved.
//

#import "PROJECT.h"

@implementation PROJECT

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    [self setup];
    return self;
}

- (void)setup {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSBundle *bundle = [NSBundle bundleForClass:self.class];
    UIImage *image = [UIImage imageNamed:@"wk" inBundle:bundle compatibleWithTraitCollection:nil];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:imageView];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1 constant:0]];
    
    [self layoutIfNeeded];
}

@end