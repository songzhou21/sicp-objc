//
//  SZAdder.m
//  sicp-objc
//
//  Created by songzhou on 2019/7/31.
//  Copyright © 2019 Song Zhou. All rights reserved.
//

#import "SZConstraint.h"

@interface SZConstraint ()

@property (nonatomic, copy) NSString *name;
@property (nonatomic) SZConnector *connector;

@end

@implementation SZConstraint

+ (instancetype)probeWithName:(NSString *)name connector:(SZConnector *)connector {
    return [[[self class] alloc] initWithName:name connector:connector];
}

- (instancetype)initWithName:(NSString *)name connector:(SZConnector *)connector {
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    self.name = name;
    self.connector = connector;
    
    [self.connector connectWithNewConstraint:self];
    
    return self;
}

- (void)printProbeWithValue:(NSNumber *)value {
    NSLog(@"\nProbe: %@ = %@", self.name, value);
}

- (void)processNewValue {
    [self printProbeWithValue:[self.connector value]];
}

- (void)processForgetValue {
    [self printProbeWithValue:nil];
}

@end
@interface SZAdderConstraint ()

@property (nonatomic) SZConnector *a1;
@property (nonatomic) SZConnector *a2;
@property (nonatomic) SZConnector *sum;


@end

@implementation SZAdderConstraint

+ (instancetype)constraintWithA1:(SZConnector *)a1 a2:(SZConnector *)a2 sum:(SZConnector *)sum {
    return [[self alloc] initWithA1:a1 a2:a2 sum:sum];
}

- (instancetype)initWithA1:(SZConnector *)a1 a2:(SZConnector *)a2 sum:(SZConnector *)sum {
    self = [super init];
    
    if (!self) {
        return self;
    }
    
    self.a1 = a1;
    self.a2 = a2;
    self.sum = sum;
    
    [a1 connectWithNewConstraint:self];
    [a2 connectWithNewConstraint:self];
    [sum connectWithNewConstraint:self];
    
    return self;
}

- (void)processNewValue {
    SZConnector *a1 = self.a1;
    SZConnector *a2 = self.a2;
    SZConnector *sum = self.sum;
    
    if ([a1 hasValue] &&
        [a2 hasValue]) {
        [sum setValue:@([a1 value].doubleValue + [a2 value].doubleValue) informant:self];
    } else if ([a1 hasValue] &&
               [sum hasValue]) {
        [a2 setValue:@([sum value].doubleValue - [a1 value].doubleValue) informant:self];
    } else if ([a2 hasValue] &&
               [sum hasValue]) {
        [a1 setValue:@([sum value].doubleValue - [a2 value].doubleValue) informant:self];
    }
}

- (void)processForgetValue {
    [self.sum forgetValueWithRetractor:self];
    [self.a1 forgetValueWithRetractor:self];
    [self.a2 forgetValueWithRetractor:self];
    [self processNewValue];
}


@end

@interface SZMultiplierConstraint ()

@property (nonatomic) SZConnector *m1;
@property (nonatomic) SZConnector *m2;
@property (nonatomic) SZConnector *product;


@end

@implementation SZMultiplierConstraint

+ (instancetype)constraintWithM1:(SZConnector *)m1 a2:(SZConnector *)m2 product:(SZConnector *)product {
    return [[self alloc] initWithM1:m1 a2:m2 product:product];
}

- (instancetype)initWithM1:(SZConnector *)m1 a2:(SZConnector *)m2 product:(SZConnector *)product {
    self = [super init];
    
    if (!self) {
        return self;
    }
    
    self.m1 = m1;
    self.m2 = m2;
    self.product = product;
    
    [m1 connectWithNewConstraint:self];
    [m2 connectWithNewConstraint:self];
    [product connectWithNewConstraint:self];
    
    return self;
}

- (void)processNewValue {
    SZConnector *m1 = self.m1;
    SZConnector *m2 = self.m2;
    SZConnector *product = self.product;
    
    if (([m1 hasValue] &&
         [m1 value] == 0) ||
        ([m2 hasValue] &&
         [m2 value] == 0)) {
            [product setValue:@0 informant:self];
        } else if ([m1 hasValue] && [m2 hasValue]) {
            [product setValue:@([m1 value].doubleValue * [m2 value].doubleValue) informant:self];
        } else if ([product hasValue] &&
                   [m1 hasValue]) {
            [m2 setValue:@([product value].doubleValue / [m1 value].doubleValue) informant:self];
        } else if ([product hasValue] &&
                   [m2 hasValue]) {
            [m1 setValue:@([product value].doubleValue / [m2 value].doubleValue) informant:self];
        }
}

- (void)processForgetValue {
    [self.product forgetValueWithRetractor:self];
    [self.m1 forgetValueWithRetractor:self];
    [self.m2 forgetValueWithRetractor:self];
    
    [self processNewValue];
}

@end

@interface SZConstantConstraint ()

@property (nonatomic) NSNumber *value;
@property (nonatomic) SZConnector *connector;

@end

@implementation SZConstantConstraint

+ (instancetype)constraintWithValue:(NSNumber *)value connector:(SZConnector *)connector {
    return [[self alloc] initWithValue:value connector:connector];
}


- (instancetype)initWithValue:(NSNumber *)value connector:(SZConnector *)connector {
    self = [super init];
    
    if (!self) {
        return nil;
    }

    self.value = value;
    self.connector = connector;
    
    
    [self.connector connectWithNewConstraint:self];
    [self.connector setValue:value informant:self];
    
    return self;
}

@end
