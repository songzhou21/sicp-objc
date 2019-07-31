//
//  SZList.m
//  sicp-objc
//
//  Created by songzhou on 2019/7/31.
//  Copyright © 2019 Song Zhou. All rights reserved.
//

#import "SZList.h"

@interface NSArray (SZExt)

- (nullable instancetype)sz_cdr;

@end

@interface SZPair ()


@property (nullable, nonatomic) id first;
@property (nullable, nonatomic) id last;

@end

@implementation SZPair

+ (instancetype)cons:(id)first last:(id)last {
    SZPair *o = [SZPair new];
    o.first = first;
    o.last = last;
    
    return o;
}

- (id)car {
    return self.first;
}

- (id)cdr {
    return self.last;
}

- (NSInteger)length {
    return [self lengthWithItems:self];
}

// (cons 1 (cons 2 nil)) == 2
- (NSInteger)lengthWithItems:(SZPair *)items {
    if (items == nil) {
        return 0;
    } else {
        return 1 + [self lengthWithItems:[items cdr]];
    }
}

- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"<%@: %p> %@", [self class], self, self];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"(%@, %@)", self.first ?: @"nil", self.last ?: @"nil"];
}

@end

@implementation SZList

+ (SZPair *)new:(NSArray *)array {
    NSParameterAssert(array.count);
    

    return [self makePairWithArray:array];
}

+ (SZPair *)makePairWithArray:(NSArray *)array {
    if (array.count == 0) {
        return nil;
    }
    
    return [SZPair cons:array.firstObject last:[self makePairWithArray:[array sz_cdr]]];
}

+ (SZPair *)append:(SZPair *)list1 list2:(SZPair *)list2 {
    if (!list1) {
        return list2;
    } else {
        return [SZPair cons:[list1 car] last:[self append:[list1 cdr] list2:list2]];
    }
}

@end


@implementation NSArray (SZExt)

- (instancetype)sz_cdr {
    return self.count > 1 ? [self subarrayWithRange:NSMakeRange(1, self.count-1)] : nil;
}

@end
