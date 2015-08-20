#import "NSString+DSStringCalculator.h"

@implementation NSString (DSStringCalculator)

+(NSInteger)Add:(NSString*)numbers {
    NSInteger sum = 0;
    NSArray* strValues = [numbers componentsSeparatedByString:@","];
    for (NSString *strValue in strValues) {
        sum += [strValue integerValue];
    }
    return sum;
}

@end
