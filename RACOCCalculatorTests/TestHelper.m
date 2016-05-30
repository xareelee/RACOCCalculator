//
//  TestHelper.m
//  RACOCCalculator
//
//  Created by Xaree on 5/30/16.
//  Copyright © 2016 Xaree Lee. All rights reserved.
//

#import "TestHelper.h"
#import <Expecta/Expecta.h>

@implementation KIFUITestActor(Helper)

- (void)typeCalculatorWithExpectedStartValue:(NSString *)startValue sequence:(NSString *)sequence expectedResult:(NSString *)resultsValue {
  
  UILabel *displayLabel = (UILabel *)[self waitForViewWithAccessibilityLabel:@"display"];
  expect(displayLabel.text).to.equal(startValue);
  
  [sequence enumerateSubstringsInRange:NSMakeRange(0, sequence.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
    //NSLog(@"tap: %@", substring);
    [tester tapViewWithAccessibilityLabel:substring];
  }];
  
  expect(displayLabel.text).to.equal(resultsValue);
}

@end
