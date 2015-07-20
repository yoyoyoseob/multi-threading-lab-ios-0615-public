//
//  FISZipCode.h
//  multiThreadLab
//
//  Created by Yoseob Lee on 7/20/15.
//  Copyright (c) 2015 Joe Burgess. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FISZipCode : NSObject

@property (nonatomic, strong) NSString *county;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *state;

@end
