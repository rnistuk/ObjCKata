#import "NSString+DSStringCalculator.h"

@implementation NSString (DSStringCalculator)

+(NSString*)parseNumbersString:(NSString*)numbers forDelimiters:(NSCharacterSet**)delimiters {
    NSMutableCharacterSet *tmpDelimiters = [NSMutableCharacterSet characterSetWithCharactersInString:@",\n"];
    if ( numbers.length>2 && [[numbers substringToIndex:2] isEqualToString:@"//"]) {
        [tmpDelimiters addCharactersInString:[numbers substringWithRange:NSMakeRange(2, 1)]];
        numbers = [numbers substringFromIndex:3];
    }
    *delimiters = (NSCharacterSet*)[tmpDelimiters copy];
    return numbers;
}

+ (void)findNegativesAndRaiseException:(NSArray *)strValues {
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        return 0>[evaluatedObject integerValue];
    }];
    NSArray* negatives = [strValues filteredArrayUsingPredicate:predicate];
    NSString* raised = [NSString stringWithFormat:@"negatives not allowed %@", [negatives componentsJoinedByString:@","]];
    [NSException raise:raised format:@""];
}

+(NSInteger)Add:(NSString*)numberString {
    NSInteger sum = 0;
    NSCharacterSet *delimiters = nil;
    numberString = [NSString parseNumbersString:numberString forDelimiters:&delimiters];
    
    NSArray* strValues = [numberString componentsSeparatedByCharactersInSet:delimiters];
    for (NSString *strValue in strValues) {
        NSInteger v = [strValue integerValue];
        if(v<0)
            [self findNegativesAndRaiseException:strValues];
        sum += v < 1000 ? v : 0.0;
    }
    return sum;
}

@end
