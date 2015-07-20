//
//  FISZipSearchOperation.h
//  multiThreadLab
//
//  Created by Yoseob Lee on 7/20/15.
//  Copyright (c) 2015 Joe Burgess. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FISZipCode.h"

@interface FISZipSearchOperation : NSOperation
@property (nonatomic, strong) NSString *searchZipCode;
@property (nonatomic, copy) void (^zipCodeBlock)(FISZipCode *zipCode, NSError *error);


@property (nonatomic, strong) FISZipCode *zipCode;
@property (nonatomic, strong) NSMutableArray *entries;

-(instancetype)initWithZipCode:(NSString *)zipcode;

@end
