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

@end
