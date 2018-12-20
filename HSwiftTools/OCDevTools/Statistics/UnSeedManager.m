//
//  UnSeedManager.m
//  GCash
//
//  Created by huweitao on 2018/12/13.
//  Copyright © 2018年 GXI. All rights reserved.
//

#import "UnSeedManager.h"

@interface UnSeedManager()

@property (nonatomic, copy) PageMonitorHandler pageMonitorHandler;
@property (nonatomic, copy) ClickHandler clickHandler;
@property (nonatomic, copy) TableViewSelectHandler tableViewSelectHandler;
@property (nonatomic, copy) CollectionViewSelectHandler collectionViewSelectHandler;

@end

@implementation UnSeedManager

+ (instancetype)sharedManager {
    static id _sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

#pragma mark - Public

#pragma mark - Excute
- (void)startPageMonitorBy:(NSString *)pageKey
{
    if (pageKey.length > 0 && self.pageMonitorHandler) {
        self.pageMonitorHandler(pageKey,YES);
    }
}

- (void)endPageMonitorBy:(NSString *)pageKey
{
    if (pageKey.length > 0 && self.pageMonitorHandler) {
        self.pageMonitorHandler(pageKey,NO);
    }
}


- (void)clickTraceBy:(NSString *)clickKey
{
    if (clickKey.length > 0 && self.clickHandler) {
        self.clickHandler(clickKey);
    }
}


- (void)tableViewSelectByID:(NSString *)selectKey tableview:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;
{
    if (selectKey.length > 0 && self.tableViewSelectHandler) {
        self.tableViewSelectHandler(selectKey,indexPath,tableView);
    }
}


- (void)collectionViewSelectByID:(NSString *)selectKey tableview:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath
{
    if (selectKey.length > 0 && self.collectionViewSelectHandler) {
        self.collectionViewSelectHandler(selectKey,indexPath,collectionView);
    }
}

#pragma mark - Register
- (void)registerPageMonitor:(PageMonitorHandler)handler
{
    self.pageMonitorHandler = handler;
}

- (void)registerClickTrace:(ClickHandler)handler
{
    self.clickHandler = handler;
}

- (void)registerTableViewSelect:(TableViewSelectHandler)handler
{
    self.tableViewSelectHandler = handler;
}


- (void)registerCollectionViewSelect:(CollectionViewSelectHandler)handler
{
    self.collectionViewSelectHandler = handler;
}

@end
