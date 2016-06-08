//
//  ViewController.m
//  GesDemo2
//
//  Created by 赵冰冰 on 16/5/12.
//  Copyright © 2016年 XYJ. All rights reserved.
//
#define kMainScreenWidth [UIScreen mainScreen].bounds.size.width
#define kMainScreenHeight [UIScreen mainScreen].bounds.size.height
#import "ViewController.h"
#import "GridView.h"
#import "ProgrammaLayout.h"
#import "Cell_Program.h"
#import "ProgramItem.h"
static NSString * strID = @"ID";
@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, GridViewDelegate>

@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) NSMutableArray *datas;

@end

@implementation ViewController

-(NSMutableArray *)datas
{
    if (_datas == nil) {
        _datas = [[NSMutableArray alloc]init];
    }
    return _datas;
}

- (IBAction)refresh:(id)sender {
    
    for (int i = 0; i < 7; i++) {
        ProgramItem * item = self.datas[i];
        item.height1 = arc4random_uniform(270);
        item.height3 = arc4random_uniform(270);
    }
    [self.collectionView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
     [UIApplication sharedApplication].applicationIconBadgeNumber = 5;
    
    self.navigationController.navigationBar.translucent = NO;
    ProgrammaLayout * layout = [[ProgrammaLayout alloc]init];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight - 64) collectionViewLayout:layout];
    [self.collectionView registerClass:[Cell_Program class] forCellWithReuseIdentifier:strID];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    
    for (int i = 0; i < 7; i++) {
        ProgramItem * item = [[ProgramItem alloc]init];
        item.height1 = arc4random_uniform(270);
        item.height3 = arc4random_uniform(270);
        [self.datas addObject:item];
    }
    [self.collectionView reloadData];
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 7;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Cell_Program * cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:strID forIndexPath:indexPath];
    cell.gridView.delegate = self;
    ProgramItem * item = self.datas[indexPath.row];
    [cell.gridView refreshHeightWithH1:item.height1 h2:0 h3:item.height3];
    cell.indexPath = indexPath;
    return cell;
}

-(void)gridViewDelegate:(GridView *)gridView h1:(CGFloat)h1 indexPath:(NSIndexPath *)indexPath h3:(CGFloat)h3
{
     NSLog(@"h1 = %f , idx = %@, h3 = %f", h1, indexPath, h3);
}
-(void)gridView:(GridView *)gridView didSeletedRowAtIndexPath:(NSIndexPath *)indexPath andRow:(NSInteger)row
{
    NSLog(@"row = %ld idx = %@", row, indexPath);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
