#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import "NSString+DSStringCalculator.h"

@interface Tests : XCTestCase

@end

@implementation Tests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testAddMethodCreated {
    //1) Create a simple String Calculator with a method  int Add(string numbers)
    XCTAssert([NSString respondsToSelector:@selector(Add:)], @"Pass");
}

- (void)testAddUpToTwoIntegers {
    // The method can take 0, 1 or 2 numbers, and will return their sum (for an
    // empty string it will return 0) for example “” or “1” or “1,2”
    XCTAssertEqual(0, [NSString Add:@""]);
    XCTAssertEqual(1, [NSString Add:@"1"]);
    XCTAssertEqual(3, [NSString Add:@"1,2"]);
    XCTAssertEqual(2, [NSString Add:@"0,2"]);
    XCTAssertEqual(300, [NSString Add:@"100,200"]);
}

- (void)testUnknownNumberOfNumbers {
    // 2. Allow the Add method to handle an unknown amount of numbers
    XCTAssertEqual(434, [NSString Add:@"1,2,1,30,100,200,100"]);
}

- (void)testAddNewLineDelimiterHandling {
    // Allow the Add method to handle new lines between numbers (instead of
    // commas).
    XCTAssertEqual(6, [NSString Add:@"1\n2,3"]);
}

- (void)testSupportDifferentDelimiters {
    // to change a delimiter, the beginning of the string will contain a
    // separate line that looks like this: “//[delimiter]\n[numbers…]” for
    // example “//;\n1;2” should return three where the default delimiter is ‘;’ .
    // the first line is optional. all existing scenarios should still be
    // supported
    XCTAssertEqual(3, [NSString Add:@"//;\n1;2"]);
}

- (void)testExceptionOnNegative {
    // Calling Add with a negative number will throw an exception “negatives
    // not allowed” - and the negative that was passed.if there are multiple
    // negatives, show all of them in the exception message
    //zXCTAssertThrowsSpecificNamed([NSString Add:@"2, -1"], NSException, @"negatives not allowed -1");
    XCTAssertThrowsSpecificNamed([NSString Add:@"2,-1,-3,-4"], NSException, @"negatives not allowed -1,-3,-4");
}

-(void)testIgnoreBigNumbers {
    // Numbers bigger than 1000 should be ignored, so adding 2 + 1001  = 2
    XCTAssertEqual(2, [NSString Add:@"2,1001"]);
}



@end
