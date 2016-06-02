//
//  DevRunningBlock.h
//  RACOCCalculator
//
//  Created by Xaree on 5/30/16.
//  Copyright © 2016 Xaree Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef DEBUG

#define debug_only(...) _debug_only(__VA_ARGS__)
#define debug_and_test_only(...) _debug_and_test_only(__VA_ARGS__)

void _debug_only(void(^block)(void));
void _debug_and_test_only(void(^block)(void));

#define __DevRunningBlockEnableTest__(BOOL_VALUE) \
  __attribute__((constructor)) \
  static void __SetupDevRunningBlockEnableTest__(void) { \
    [DevRunningBlock setIsTest:BOOL_VALUE]; \
  }

@interface DevRunningBlock : NSObject
+ (void)setIsTest:(BOOL)isTest;
@end

#else // if not DEBUG
#define debug_only(...) do{}while(0)
#define debug_and_test(...) do{}while(0)

#endif // endif DEBUG



