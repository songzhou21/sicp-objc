//
//  SZConnector.h
//  sicp-objc
//
//  Created by songzhou on 2019/7/31.
//  Copyright © 2019 Song Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SZConnector : NSObject

- (BOOL)hasValue;
- (double)value;
- (void)setValue:(double)value informant:(id)informant;

- (void)forgetValueWithRetractor:(id)retractor;
- (void)connectWithNewConstraint:(id)constraint;

@end

NS_ASSUME_NONNULL_END
