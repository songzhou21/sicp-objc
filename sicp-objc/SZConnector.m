//
//  SZConnector.m
//  sicp-objc
//
//  Created by songzhou on 2019/7/31.
//  Copyright © 2019 Song Zhou. All rights reserved.
//

#import "SZConnector.h"
#import "SZList.h"

@interface SZConnector ()

@property (nonatomic) NSNumber *value;
@property (nonatomic) id informant;
@property (nonatomic) SZPair *constraints;

@end


@implementation SZConnector

- (void)setValue:(NSNumber *)value informant:(id)informant {
    if (![self hasValue]) {
        self.value = value;
        self.informant = informant;
    } else if (self.value != value){
       [NSException exceptionWithName:NSGenericException
                               reason:[NSString stringWithFormat:@"Contradiction: %@", [SZList new:@[self.value, value]]]
                             userInfo:nil];
    }
}

- (void)forgetValueWithRetractor:(id)retractor {
    
}

- (void)connectWithNewConstraint:(id)constraint {
    
}

- (BOOL)hasValue {
    return self.informant != nil;
}

@end
