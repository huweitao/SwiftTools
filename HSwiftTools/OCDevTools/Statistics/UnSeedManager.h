//
//  UnSeedManager.h
//  GCash
//
//  Created by huweitao on 2018/12/13.
//  Copyright © 2018年 GXI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^PageMonitorHandler)(NSString *,BOOL);
typedef void(^ClickHandler)(NSString *);
typedef void(^TableViewSelectHandler)(NSString *,NSIndexPath *,UITableView *);
typedef void(^CollectionViewSelectHandler)(NSString *,NSIndexPath *,UICollectionView *);

@interface UnSeedManager : NSObject

+ (instancetype)sharedManager;

// excute
- (void)startPageMonitorBy:(NSString *)pageKey;
- (void)endPageMonitorBy:(NSString *)pageKey;
- (void)clickTraceBy:(NSString *)clickKey;
- (void)tableViewSelectByID:(NSString *)selectKey tableview:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;
- (void)collectionViewSelectByID:(NSString *)selectKey tableview:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;

// register
- (void)registerPageMonitor:(PageMonitorHandler)handler;
- (void)registerClickTrace:(ClickHandler)handler;
- (void)registerTableViewSelect:(TableViewSelectHandler)handler;
- (void)registerCollectionViewSelect:(CollectionViewSelectHandler)handler;

@end

NS_ASSUME_NONNULL_END
