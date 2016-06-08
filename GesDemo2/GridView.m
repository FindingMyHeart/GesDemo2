//
//  GridView.m
//  GesDemo2
//
//  Created by 赵冰冰 on 16/5/12.
//  Copyright © 2016年 XYJ. All rights reserved.
//
#define PRIORITY 998
#define EXTRAME_PRIORITY 999 //极端值的优先级
#import "GridView.h"
#import "NSLayoutConstraint+Add.h"
#import "UIView+WhenTappedBlocks.h"
@interface GridView ()
@end

@implementation GridView

-(UILabel *)label1
{
    if (_label1 == nil) {
        _label1 = [[UILabel alloc]init];
        _label1.backgroundColor = [UIColor clearColor];
        _label1.text = @"1";
        _label1.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_label1];
    }
    return _label1;
}

-(UILabel *)label2
{
    if (_label2 == nil) {
        _label2 = [[UILabel alloc]init];
        _label2.backgroundColor = [UIColor clearColor];
        _label2.text = @"2";
        _label2.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_label2];
    }
    return _label2;
}

-(UILabel *)label3
{
    if (_label3 == nil) {
        _label3 = [[UILabel alloc]init];
        _label3.backgroundColor = [UIColor clearColor];
        _label3.text = @"3";
        _label3.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_label3];
    }
    return _label3;
}

+(id)instanceView
{
    return  [[[NSBundle mainBundle] loadNibNamed:@"GridView" owner:nil options:nil] lastObject];
}

-(void)refreshHeightWithH1:(CGFloat)h1 h2:(CGFloat)h2 h3:(CGFloat)h3
{

    self.redHeight.constant = h1;
    self.blueHeight.constant = h3;
}

-(void)pan:(UIPanGestureRecognizer *)pan
{    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
           
    
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            
            CGPoint po = [pan translationInView:pan.view];
            
            if (self.current != nil ) {
                [self.current.curView removeConstraint:self.current];
            }
             self.current = [NSLayoutConstraint constraintWithItem:pan.view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1.0 constant:0];
         
            if (pan.view == self.redView) {
                CGFloat h = self.redHeight.constant + po.y;
//                self.redHeight.constant++;
                if (h < 1) {
                    h = 1;
                }
                if (h > self.currentHeight - 3) {
                    h = self.currentHeight - 3;
                }
                self.current.constant = h;
                [pan.view addConstraint:self.current];
                self.current.curView = self.redView;
               
            }
            if (pan.view == self.greenView) {
                
                BOOL isUp = po.y < 0? YES: NO;
                
                if (isUp) {
                    
                    CGFloat h = self.redHeight.constant + po.y;
                    if (h <= 0 ) {
                        h = 1;
                    }
                    self.current = nil;
                    self.current = [NSLayoutConstraint constraintWithItem:self.redView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1.0 constant:0];
                    
                    self.current.constant = h;
                    self.current.curView = self.redView;
                    self.current.priority = PRIORITY;
                    [self.redView addConstraint:self.current];
                }else{
                    
                     CGFloat h = self.blueHeight.constant - po.y;
                    if (h > self.blueHeight.constant - 2) {
                        h = self.blueHeight.constant - 2;
                    }
                    self.current = nil;
                     self.current = [NSLayoutConstraint constraintWithItem:self.blueView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1.0 constant:0];
                    self.current.constant = h;
                    self.current.curView = self.blueView;
                    self.current.priority = PRIORITY;
                    [self.blueView addConstraint:self.current];
                }
                
            }
            if (pan.view == self.blueView) {
                CGFloat h = self.blueHeight.constant - po.y;
                if (h < 1) {
                    h = 1;
                }
                if (h > self.currentHeight - 3) {
                    h = self.currentHeight - 3;
                }
                
                self.current.constant = h;
                [pan.view addConstraint:self.current];
                self.current.curView = self.blueView;
            }
            
            [self layoutIfNeeded];
//            if (self.greenView.frame.size.height == self.currentHeight - 2) {
//                
//                NSLog(@"极端值");
//                
//                if (self.extremeCon) {
//                    [self.extremeCon.curView removeConstraint:self.extremeCon];
//                    self.extremeCon = nil;
//                }
//                BOOL isUp;
//                if (po.y > 0) {
//                    isUp = NO;
//                }else{
//                    isUp = YES;
//                }
//                
//                if (isUp) {
//                    
//                    self.extremeCon = [NSLayoutConstraint constraintWithItem:self.blueView attribute: NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:0];
//                    self.extremeCon.curView = self.blueView;
//                    self.extremeCon.priority = EXTRAME_PRIORITY;
//                    self.extremeCon.constant = self.blueHeight.constant - po.y;
//                    [self.blueView addConstraint:self.extremeCon];
//                    [self layoutIfNeeded];
//                }
//            }
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            if (pan.view == self.redView) {
                self.redHeight.constant = self.current.constant;
            }
            if (pan.view == self.greenView) {
                
                //向上
                if (self.current.curView == self.redView) {
                    
                    self.redHeight.constant = self.current.constant;
                    
                }else{
                    
                      self.blueHeight.constant = self.current.constant;
                }
            }
            if (pan.view == self.blueView) {
                self.blueHeight.constant = self.current.constant;
            }
            
            if ([self.delegate respondsToSelector:@selector(gridViewDelegate:h1:indexPath:h3:)]) {
                [self.delegate gridViewDelegate:self h1:self.redView.frame.size.height indexPath:self.indexPath h3:self.blueView.frame.size.height];
            }
        }
            break;
        default:
            break;
    }
}

-(void)awakeFromNib
{
    NSArray * array = @[self.redView, self.greenView, self.blueView];
    [self label1];
    [self label2];
    [self label3];
    for (UIView * v in array) {
        v.userInteractionEnabled = YES;
        UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
        [v addGestureRecognizer:pan];
    }
    ;
    
//    __weak typeof(self) weakSelf = self;
//    [self.redView whenTapped:^{
//        
//        if ([weakSelf.delegate respondsToSelector:@selector(gridView:didSeletedRowAtIndexPath:andRow:)]) {
//            [weakSelf.delegate gridView:weakSelf didSeletedRowAtIndexPath:weakSelf.indexPath andRow:0];
//        }
//    }];
//    [self.greenView whenTapped:^{
//        
//        if ([weakSelf.delegate respondsToSelector:@selector(gridView:didSeletedRowAtIndexPath:andRow:)]) {
//            [weakSelf.delegate gridView:weakSelf didSeletedRowAtIndexPath:weakSelf.indexPath andRow:1];
//        }
//        
//    }];
//    [self.blueView whenTapped:^{
//        
//        if ([weakSelf.delegate respondsToSelector:@selector(gridView:didSeletedRowAtIndexPath:andRow:)]) {
//            [weakSelf.delegate gridView:weakSelf didSeletedRowAtIndexPath:weakSelf.indexPath andRow:2];
//        }
//        
//    }];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _label1.frame = _redView.frame;
    _label2.frame = _greenView.frame;
    _label3.frame = _blueView.frame;
}

@end
