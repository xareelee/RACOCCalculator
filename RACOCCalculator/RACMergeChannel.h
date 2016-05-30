//
//  RACMergeChannel.h
//  RACOCCalculator
//
//  Created by Xaree on 5/30/16.
//  Copyright © 2016 Xaree Lee. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
@class RACSignal;

@interface RACMergeChannel : RACChannel

- (void)mergeSignal:(RACSignal *)signal;
@end
