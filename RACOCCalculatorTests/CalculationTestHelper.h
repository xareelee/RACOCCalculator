//
//  CalculationTestHelper.h
//  RACOCCalculator
//
//  Created by Xaree on 6/1/16.
//  Copyright © 2016 Xaree Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "Calculation.h"

/// Use it as key for `sharedExamplesFor`
///
/// @code
/// sharedExamplesFor(CalculationTestHelper, ^(NSDictionary *data) {
///   data[@"state"];           // A CalculatorState instance
///   data[@"sequence"];        // typing sequence
///   data[@"expectedStates"];  // expect CalculatorState instances for the sequence
/// });
/// @endcode
///
/// data keys:
///
/// * state: a CalculatorState; could be nil (use default).
/// * sequence: the calculator input sequence
/// * expectedStates: an array containing the order of expected results sequence.
extern NSString *CalculationTestHelper;



