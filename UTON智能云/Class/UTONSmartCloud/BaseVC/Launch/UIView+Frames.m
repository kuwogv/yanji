//
//  UILabel+Frame.m
//  CCBClientV2
//
//  Created by jinhong on 14-12-9.
//  Copyright (c) 2014年 llbt. All rights reserved.
//

#import "UIView+Frames.h"

@implementation UIView (Frames)
- (void)setX:(CGFloat)x {
    self.frame = CGRectMake(x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y {
    self.frame = CGRectMake(self.frame.origin.x, y, self.frame.size.width, self.frame.size.height);
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.frame.size.height);
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (CGFloat)bottomY {
    return self.y + self.height;
}

- (CGFloat)rightX {
    return self.x + self.width;
}
@end
