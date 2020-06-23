//
//  DataModel.h
//  project2
//
//  Created by Solist on 2020/5/23.
//  Copyright © 2020 solist. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DataModel : NSObject

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *desc;
@property (copy, nonatomic) NSString *detail;
@property (copy, nonatomic) NSURL *url;
@property (copy, nonatomic) NSURL *bigUrl;
@property (strong, nonatomic) NSNumber *collectionCount;
@property (assign, nonatomic) NSNumber *tag;
@property (assign, nonatomic) BOOL isCollected;

- (instancetype)initWithTitle:(NSString *)title desc:(NSString *)desc detail:(NSString *)detail url:(NSURL *)url bigUrl:(NSURL *)bigUrl collectionCount:(NSNumber*)collectionCount tag:(NSNumber *)tag;




@end

NS_ASSUME_NONNULL_END
