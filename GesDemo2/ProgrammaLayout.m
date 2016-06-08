
//
//  ProgrammaLayout.m
//  GesDemo2
//
//  Created by 赵冰冰 on 16/5/13.
//  Copyright © 2016年 XYJ. All rights reserved.
//

#import "ProgrammaLayout.h"

@implementation ProgrammaLayout

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return self;
}

-(void)prepareLayout
{
    [super prepareLayout];
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
    self.itemSize = CGSizeMake(self.collectionView.frame.size.width / 7, self.collectionView.frame.size.height);
}
@end
