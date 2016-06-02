//
//  TestHelper.h
//  RACOCCalculator
//
//  Created by Xaree on 5/30/16.
//  Copyright © 2016 Xaree Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <KIF/KIF.h>

@interface KIFUITestActor(Helper)

// For CalculatorViewController test
- (void)typeCalculatorWithExpectedStartValue:(NSString *)sequence sequence:(NSString *)startValue expectedResult:(NSString *)resultsValue;

@end



