//
//  main.m
//  sicp-objc
//
//  Created by songzhou on 2019/7/31.
//  Copyright © 2019 Song Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SZList.h"

void list_test(void);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        list_test();
    }
    return 0;
}

void list_test(void) {
    SZPair *a = [SZPair cons:@"a" last:@"b"];
    
    SZPair *ab = [SZPair cons:@"a" last:[SZPair cons:@"a" last:@"b"]];
    
    SZPair *list = [SZList new:@[@1, @2, @3]];
    SZPair *listB = [SZList new:@[@4, @5, @6]];
    
    NSLog(@"%@", a);
    NSLog(@"%@", ab);
    NSLog(@"car %@ - %@", ab, [ab car]);
    NSLog(@"cdr %@ - %@", ab, [ab cdr]);
    NSLog(@"cdr cdr %@ - %@", ab, [[ab cdr] cdr]);
    NSLog(@"list %@, length:%ld", list, [list length]);
    NSLog(@"list append %@", [SZList append:list list2:listB]);
    NSLog(@"list ref %@", [list objectAtIndex:1]);
    NSLog(@"list last pair %@", [list lastPair]);
    NSLog(@"list reverse %@", [list reverse]);
    
    [[list map:^id _Nullable(NSNumber * _Nonnull item) {
        return @(item.integerValue * 2);
    }] forEach:^(id  _Nonnull item) {
        NSLog(@"%@", item);
    }];

    NSLog(@"filter %@", [list filter:^BOOL(NSNumber *  _Nonnull item) {
        return item.integerValue % 2 == 0;
    }]);

}
