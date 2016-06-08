//
//  GridView.h
//  GesDemo2
//
//  Created by 赵冰冰 on 16/5/12.
//  Copyright © 2016年 XYJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GridView;

@protocol GridViewDelegate <NSObject>

-(void)gridViewDelegate:(GridView *)gridView h1:(CGFloat)h1 indexPath:(NSIndexPath *)indexPath h3:(CGFloat)h3;
-(void)gridView:(GridView *)gridView didSeletedRowAtIndexPath:(NSIndexPath *)indexPath andRow:(NSInteger)row;
@end

@interface GridView : UIView

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *redHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *blueHeight;
@property (nonatomic, assign) NSLayoutConstraint * current;
@property (nonatomic, strong) NSLayoutConstraint * extremeCon;//极端情况下的用来补救

@property (weak, nonatomic) IBOutlet UIView *redView;
@property (weak, nonatomic) IBOutlet UIView *greenView;
@property (weak, nonatomic) IBOutlet UIView *blueView;

@property (nonatomic, strong) UILabel * label1;
@property (nonatomic, strong) UILabel * label2;
@property (nonatomic, strong) UILabel * label3;
@property (nonatomic, assign) id <GridViewDelegate> delegate;
@property (nonatomic, assign) CGFloat currentHeight;
@property (nonatomic, strong) NSIndexPath * indexPath;
+(id)instanceView;

-(void)refreshHeightWithH1:(CGFloat)h1 h2:(CGFloat)h2 h3:(CGFloat)h3;

@end
