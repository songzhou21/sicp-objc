//
//  SZConnector.m
//  sicp-objc
//
//  Created by songzhou on 2019/7/31.
//  Copyright © 2019 Song Zhou. All rights reserved.
//

#import "SZConnector.h"
#import "SZList.h"
#import "SZConstraint.h"

@interface SZConnector ()

@property (nonatomic) NSNumber *value;
@property (nullable, nonatomic) id informant;
@property (nonatomic) SZPair *constraints;

@property (nonatomic, copy) void(^informAboutValue)(SZConstraint *);
@property (nonatomic, copy) void(^informAboutNoValue)(SZConstraint *);

@end


@implementation SZConnector

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _informAboutValue = ^void(SZConstraint *constraint) {
        [constraint processNewValue];
    };
    _informAboutNoValue = ^void(SZConstraint *constraint) {
        [constraint processForgetValue];
    };
    
    return self;
}


- (void)setValue:(NSNumber *)value informant:(id)informant {
    if (![self hasValue]) {
        self.value = value;
        self.informant = informant;
        [self forEachExcept:informant
                      block:self.informAboutValue
                       list:self.constraints];
        
    } else if (![self.value isEqual:value]){
        [NSException raise:NSGenericException format:@"Contradiction: %@", SZList(@[self.value, value])];
    }
}


- (void)forgetValueWithRetractor:(id)retractor {
    if (self.informant == retractor) {
        self.informant = nil;
        [self forEachExcept:retractor
                      block:self.informAboutNoValue
                       list:self.constraints];
    }
}

- (void)connectWithNewConstraint:(id)constraint {
    if (![self.constraints memq:constraint]) {
        self.constraints = SZCons(constraint, self.constraints);
    }
    
    if ([self hasValue]) {
        self.informAboutValue(constraint);
    }
}

- (BOOL)hasValue {
    return self.informant != nil;
}

#pragma mark - Private
- (void)forEachExcept:(id)exception block:(void(^)(id))block list:(SZPair *)list {
    [list forEach:^(id  _Nonnull item) {
        if ([item isEqual:exception]) {
            return;
        }
        
        block(item);
    }];
}

@end
