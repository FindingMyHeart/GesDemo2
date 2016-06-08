//
//  NSLayoutConstraint+Add.m
//  GesDemo2
//
//  Created by 赵冰冰 on 16/5/12.
//  Copyright © 2016年 XYJ. All rights reserved.
//

#import "NSLayoutConstraint+Add.h"
#import <objc/runtime.h>
@implementation NSLayoutConstraint (Add)

-(void)setCurView:(UIView *)curView
{
    objc_setAssociatedObject(self, @selector(curView), curView, OBJC_ASSOCIATION_ASSIGN);
}
-(UIView *)curView
{
    return objc_getAssociatedObject(self, @selector(curView));
}
@end
