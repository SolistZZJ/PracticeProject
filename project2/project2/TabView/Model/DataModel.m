//
//  DataModel.m
//  project2
//
//  Created by Solist on 2020/5/23.
//  Copyright © 2020 solist. All rights reserved.
//

#import "DataModel.h"

@implementation DataModel

- (instancetype)initWithTitle:(NSString *)title desc:(NSString *)desc detail:(NSString *)detail url:(NSURL *)url bigUrl:(NSURL *)bigUrl collectionCount:(NSNumber *)collectionCount tag:(NSNumber *)tag {
    self = [super init];
    if (self) {
        _title = title;
        _desc = desc;
        _detail = detail;
        _url = url;
        _bigUrl = bigUrl;
        _collectionCount = collectionCount;
        _tag = tag;
        _isCollected = NO;
    }
    return self;
}

@end
