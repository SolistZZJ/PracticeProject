//
//  TabViewNetworker.m
//  project2
//
//  Created by Solist on 2020/5/23.
//  Copyright © 2020 solist. All rights reserved.
//

#import "TabViewNetworker.h"

@implementation TabViewNetworker

+ (RACSignal *)loadDataWithTagkey:(NSNumber *)key {
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        AVQuery *query = [AVQuery queryWithClassName:@"DataContent"];
        [query whereKey:@"tag" equalTo: key];
        [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
            if (!error) {
                NSMutableArray *array = [NSMutableArray array];
                int n = 0;
                for (AVObject *obj in objects) {
                    @autoreleasepool {
                        NSMutableString *desc = [NSMutableString string];
                        NSMutableString *detail = [NSMutableString string];
                        for (int i = 0; i <= n; ++i) {
                            if (i < 20) {
                                [desc appendFormat:@"这是第%d条数据的desc",n+1];
                            }
                            else {
                                break;
                            }
                        }
                        for (int i = 0; i <= 30; ++i) {
                            [detail appendFormat:@"这是第%d条数据的detail - 完全就是fake数据。",n+1];
                        }

                        AVFile *imageFile = obj[@"pic"];

                        DataModel *model = [[DataModel alloc] initWithTitle:[NSString stringWithFormat:@"这是第%d条数据的title",n+1] desc:desc detail:detail url:[NSURL URLWithString:imageFile.url] bigUrl:[NSURL URLWithString:imageFile.url] collectionCount:[NSNumber numberWithInt:(n+3)] tag:key];
                        [array addObject:model];
                    }
                    n++;
                }
                [subscriber sendNext:array];
                [subscriber sendCompleted];
            }
            else {
                [subscriber sendError:error];
            }
        }];
        
        return nil;
    }];
    return signal;
}

@end
