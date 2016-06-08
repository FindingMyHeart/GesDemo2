//
//  Cell_Program.h
//  GesDemo2
//
//  Created by 赵冰冰 on 16/5/13.
//  Copyright © 2016年 XYJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GridView;
@interface Cell_Program : UICollectionViewCell

@property (nonatomic, assign) GridView * gridView;
@property (nonatomic, assign) NSIndexPath * indexPath;

@end
