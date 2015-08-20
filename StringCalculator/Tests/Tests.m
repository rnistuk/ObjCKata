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


@end
