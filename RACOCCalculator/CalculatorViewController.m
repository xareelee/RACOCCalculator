//
//  ViewController.m
//  RACOCCalculator
//
//  Created by Xaree on 5/30/16.
//  Copyright © 2016 Xaree Lee. All rights reserved.
//

#import "CalculatorViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

#import "RACMergeChannel.h"

@interface CalculatorViewController ()

@property (weak, nonatomic) IBOutlet UILabel *displayLabel;

@property (weak, nonatomic) IBOutlet UIButton *inputButton0;
@property (weak, nonatomic) IBOutlet UIButton *inputButton1;
@property (weak, nonatomic) IBOutlet UIButton *inputButton2;
@property (weak, nonatomic) IBOutlet UIButton *inputButton3;
@property (weak, nonatomic) IBOutlet UIButton *inputButton4;
@property (weak, nonatomic) IBOutlet UIButton *inputButton5;
@property (weak, nonatomic) IBOutlet UIButton *inputButton6;
@property (weak, nonatomic) IBOutlet UIButton *inputButton7;
@property (weak, nonatomic) IBOutlet UIButton *inputButton8;
@property (weak, nonatomic) IBOutlet UIButton *inputButton9;
@property (weak, nonatomic) IBOutlet UIButton *inputButtonDecimalPoint;

@property (weak, nonatomic) IBOutlet UIButton *actionButtonAdd;
@property (weak, nonatomic) IBOutlet UIButton *actionButtonSubstract;
@property (weak, nonatomic) IBOutlet UIButton *actionButtonMultiply;
@property (weak, nonatomic) IBOutlet UIButton *actionButtonDivide;
@property (weak, nonatomic) IBOutlet UIButton *actionButtonEqual;

@property (weak, nonatomic) IBOutlet UIButton *actionButtonClear;
@property (weak, nonatomic) IBOutlet UIButton *actionButtonPercentage;
@property (weak, nonatomic) IBOutlet UIButton *actionButtonTransitPosNeg;


// Internal
@property (strong, nonatomic) NSString *currentValue;
@property (strong, nonatomic) RACMergeChannel *updateCurrentValueChannel;
@end

@implementation CalculatorViewController

- (void)resetCurrentValue:(NSString *)numberString {
  self.currentValue = numberString;
}

- (void)resetCalculater {
  [self resetCurrentValue:@"0"];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  // Initialization
  {
    [self resetCalculater];
  }
  
  // Binding current value signal to the display label
  RACSignal *currentValueSignal;
  RACMergeChannel *updateCurrentValueChannel;
  {
    // Update `currentValue` use -[channel mergeSignal:] for multiple signals
    updateCurrentValueChannel = [RACMergeChannel new];
    RAC(self, currentValue) = updateCurrentValueChannel.followingTerminal;
    self.updateCurrentValueChannel = updateCurrentValueChannel;
    
    // Observe values
    currentValueSignal  = RACObserve(self, currentValue);
    
    // Update the display label with the current value
    RAC(self, displayLabel.text) = currentValueSignal;
  }
  
  // Input command & signals for 0-9 and decimal point
  RACSignal *inputSignal;
  {
    RACCommand *inputCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(UIButton *inputButton) {
      return [RACSignal return:inputButton.accessibilityLabel];
    }];
    
    self.inputButton0.rac_command = inputCommand;
    self.inputButton1.rac_command = inputCommand;
    self.inputButton2.rac_command = inputCommand;
    self.inputButton3.rac_command = inputCommand;
    self.inputButton4.rac_command = inputCommand;
    self.inputButton5.rac_command = inputCommand;
    self.inputButton6.rac_command = inputCommand;
    self.inputButton7.rac_command = inputCommand;
    self.inputButton8.rac_command = inputCommand;
    self.inputButton9.rac_command = inputCommand;
    self.inputButtonDecimalPoint.rac_command = inputCommand;
    
    inputSignal = inputCommand.executionSignals.switchToLatest;
  }
  
  // Calculated signal for input signal
  {
    RACSignal *newValueSignal =
    [[inputSignal
      zipWith:[currentValueSignal sample:inputSignal]]
      map:^id(RACTuple *tuple) {
        RACTupleUnpack(NSString *nextValue, NSString *currentValue) = tuple;
        NSString *results;
        if ([currentValue containsString:@"."] &&
            [nextValue isEqualToString:@"."]) {
          results = currentValue;
        } else if ([currentValue isEqualToString:@"0"] &&
                   ![nextValue isEqualToString:@"."]) {
          results = nextValue;
        } else {
          results = [currentValue stringByAppendingString:nextValue];
        }
        debug_and_test_only(^{
          NSLog(@"#input(%@) ( %@ + %@ ) => %@\t\t", nextValue, currentValue, nextValue, results);
        });
        return results;
      }].publish.autoconnect;
    
    [updateCurrentValueChannel mergeSignal:newValueSignal];
  }
  
  // Clear Button
  {
    @weakify(self);
    RACCommand *clearCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
      return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [self resetCalculater];
        debug_and_test_only(^{
          NSLog(@"#clear");
        });
        [subscriber sendCompleted];
        return nil;
      }];
    }];
    
    self.actionButtonClear.rac_command = clearCommand;
  }
  
  
  
  
  debug_only(^{
    
  });
  
}

@end
