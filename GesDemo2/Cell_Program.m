//
//  Cell_Program.m
//  GesDemo2
//
//  Created by 赵冰冰 on 16/5/13.
//  Copyright © 2016年 XYJ. All rights reserved.
//

#import "Cell_Program.h"
#import "GridView.h"
@implementation Cell_Program

-(void)setIndexPath:(NSIndexPath *)indexPath
{
    if (_indexPath != indexPath) {
        _indexPath = indexPath;
        if (self.gridView) {
            self.gridView.indexPath = indexPath;
        }
    }
}
-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        GridView * gridView = [GridView instanceView];
        gridView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        gridView.currentHeight = frame.size.height;
        [self.contentView addSubview:gridView];
        self.gridView = gridView;
    }
    return self;
}
@end
