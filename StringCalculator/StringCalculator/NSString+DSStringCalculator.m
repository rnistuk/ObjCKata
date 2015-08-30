#import "NSString+DSStringCalculator.h"

@implementation NSString (DSStringCalculator)

+(NSString*)parseNumbersString:(NSString*)numbers forDelimiters:(NSArray**)delimiters {
    if(numbers.length>2 && [[numbers substringToIndex:2] isEqualTo:@"//"]) {
        @try {
            NSMutableArray* tempDelimiters = [NSMutableArray arrayWithArray:@[@",", @"\n"]];
            NSMutableString* tmpDelimitersPart = [NSMutableString new];
            NSMutableString* tmpNumbersPart = [NSMutableString new];
            NSRange rng = [numbers rangeOfString:@"\n"];
            [tmpDelimitersPart setString:[numbers substringWithRange:NSMakeRange(2, rng.location-2)]];
            
            [tmpDelimitersPart enumerateSubstringsInRange:NSMakeRange(0, tmpDelimitersPart.length)
                                                  options:NSStringEnumerationByComposedCharacterSequences
                                               usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                                   static BOOL inGroup = NO;
                                                   static NSMutableString *delimiter = nil;
                                                   if([substring containsString:@"["]) {
                                                       inGroup = YES;
                                                       delimiter = [NSMutableString new];
                                                       return;
                                                   } else if(inGroup) {
                                                       if ([substring containsString:@"]"]) {
                                                           inGroup = NO;
                                                           [tempDelimiters addObject:delimiter];
                                                           return;
                                                       }
                                                       [delimiter appendString:substring];
                                                   } else
                                                       [tempDelimiters addObject:substring];
                                               }
             ];
            
            *delimiters = (NSArray*)tempDelimiters;
            
            
            
            NSRange numRng = NSMakeRange(rng.location+1, [numbers length]-(rng.location+1));
            numbers =  [[numbers substringWithRange:numRng] copy];

            
            NSLog(@"%@", tmpNumbersPart);
        }
        @catch(NSException *e) {
            NSLog(@"e %@", e);
        }
        
        
    } else {
        *delimiters = [@[@",", @"\n"] copy];
    }
    
    /*
    NSMutableArray *tmpDelimiters = [NSMutableArray arrayWithArray:@[ @",", @"\n"]];
    if ( numbers.length>2 && [[numbers substringToIndex:2] isEqualToString:@"//"]) {
        [tmpDelimiters addObject:[numbers substringWithRange:NSMakeRange(2, 1)]];
        numbers = [numbers substringFromIndex:3];
    }
    *delimiters = (NSArray*)[tmpDelimiters copy];
     */
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
    NSArray *delimiters = nil;
    
    NSMutableString* cleanNumberString = [NSMutableString stringWithString:[NSString parseNumbersString:numberString forDelimiters:&delimiters]];
    
    for (NSString* delimiter in delimiters) {
        if (![delimiter isEqualTo:@"|"]) {
            BOOL containsDelimiters = YES;
            while (containsDelimiters) {
                NSRange rng = [cleanNumberString rangeOfString:delimiter];
                if (rng.location == NSNotFound)
                    containsDelimiters=NO;
                else
                    [cleanNumberString replaceCharactersInRange:rng withString:@"|"];
            }
        }
    }
    
    NSArray* strValues = [cleanNumberString componentsSeparatedByString:@"|"];
    for (NSString *strValue in strValues) {
        NSInteger v = [strValue integerValue];
        if(v<0)
            [self findNegativesAndRaiseException:strValues];
        sum += v < 1000 ? v : 0.0;
    }
    return sum;
}

@end
