//
//  CalculationTestHelper.m
//  RACOCCalculator
//
//  Created by Xaree on 6/1/16.
//  Copyright © 2016 Xaree Lee. All rights reserved.
//

#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import "CalculationTestHelper.h"


NSString *CalculationTestHelper = @"CalculationTestHelper";


SharedExamplesBegin(CalculationTestHelper)
// Global shared examples are shared across all spec files.

sharedExamplesFor(@"CalculationTestHelper", ^(NSDictionary *data) {
  
  it(@"should pass the sequence expectation", ^{
    NSString *typingSequence = data[@"sequence"];
    NSArray *expectedStates = data[@"expectedStates"];
    
    expect(typingSequence.length).to.equal(expectedStates.count);
    
    RACTuple *state = data[@"state"];
    __block NSUInteger i = 0;
    handleInputSequenceForCalculatorState(state, typingSequence, ^(NSString *input, RACTuple *stepResultState) {
      
      if (!stepResultState) {
        failure([NSString stringWithFormat:@"Wrong input value `%@` in the input sequence `%@`", input, typingSequence]);
        
      } else {
        RACTuple *expectedState = expectedStates[i];
        expect(stepResultState).to.beKindOf([RACTuple class]);
        expect(expectedState).to.beKindOf([RACTuple class]);
        
        // Add this info value to the description to let the failure message
        // showing addtional info.
        NSString *info = [NSString stringWithFormat:@"Step %u (%@) in `%@` state-> ", (i + 1), input, typingSequence];
        NSString *stateDescription = [NSString stringWithFormat:@"%@%@", info, stepResultState.stateDescription];
        NSString *expectedStateDescription = [NSString stringWithFormat:@"%@%@", info, expectedState.stateDescription];
        expect(stateDescription).to.equal(expectedStateDescription);
      }
      
      i += 1;
    });
    
  });
  
});

SharedExamplesEnd



