//
//  FISZipSearchOperation.m
//  multiThreadLab
//
//  Created by Yoseob Lee on 7/20/15.
//  Copyright (c) 2015 Joe Burgess. All rights reserved.
//

#import "FISZipSearchOperation.h"

@implementation FISZipSearchOperation

-(instancetype)initWithZipCode:(NSString *)zipcode
{
    self = [super init];
    if (self)
    {
        _searchZipCode = zipcode;
        _entries = [NSMutableArray new];
        _zipCode = [[FISZipCode alloc]init];
    }
    return self;
}

-(void)main
{
    if (self.searchZipCode.length != 5)
    {
        NSDictionary *userInfo = @{ @"NSLocalizedDescriptionKey" : @"Zipcodes must be 5 digits long." };
        NSError *error = [[NSError alloc]initWithDomain:@"Zipcode Not Found" code:101 userInfo:userInfo];
        self.zipCodeBlock(nil, error);
        return;
    }
    
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc]init];
    
    NSBlockOperation *parseOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"zip_codes_states" ofType:@"csv"];
        NSString *contents = [NSString stringWithContentsOfURL:[NSURL fileURLWithPath:filePath] encoding:NSUTF8StringEncoding error:nil];
        
        for (NSString *line in [contents componentsSeparatedByString:@"\n"])
        {
            NSArray *rows = [line componentsSeparatedByString:@","];
            
            NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"\"\r"];
            NSMutableArray *editedRow = [[NSMutableArray alloc]init];
            
            for (NSString *objects in rows)
            {
                NSString *newString = [[objects componentsSeparatedByCharactersInSet:characterSet] componentsJoinedByString:@""];
                [editedRow addObject:newString];
            }
            [self.entries addObject:editedRow];
        }
        [self.entries removeObjectAtIndex:0];
    }];
    
    NSBlockOperation *searchOperation = [NSBlockOperation blockOperationWithBlock:^{
        
        NSPredicate *zipCodePredicate = [NSPredicate predicateWithFormat:@"ANY SELF == %@", self.searchZipCode];
        NSArray *filteredArray = [self.entries filteredArrayUsingPredicate:zipCodePredicate];
        
        if (filteredArray.count != 0)
        {
            NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
            [mainQueue addOperationWithBlock:^{
                
                self.zipCode.county = filteredArray[0][5];
                self.zipCode.city = filteredArray[0][4];
                self.zipCode.state = filteredArray[0][3];
                self.zipCode.latitude = filteredArray[0][1];
                self.zipCode.longitude = filteredArray[0][2];
                
                if (self.zipCodeBlock)
                {
                    self.zipCodeBlock(self.zipCode, nil);
                }
            }];
        }
        else
        {
            NSDictionary *userInfo = @{ @"NSLocalizedDescriptionKey" : @"Invalid Zipcode" };
            NSError *error = [[NSError alloc]initWithDomain:@"Zipcode Not Found" code:102 userInfo:userInfo];
            self.zipCodeBlock(nil, error);
            return;
        }
        
    }];
    
    [searchOperation addDependency:parseOperation];
    [operationQueue addOperation:parseOperation];
    [operationQueue addOperation:searchOperation];
}

@end
