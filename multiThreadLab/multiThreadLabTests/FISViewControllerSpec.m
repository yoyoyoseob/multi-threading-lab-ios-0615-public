//
//  FISViewControllerSpec.m
//  
//
//  Created by Joe Burgess on 4/17/14.
//  Copyright 2014 __MyCompanyName__. All rights reserved.
//

#import "Specta.h"
#define EXP_SHORTHAND
#import "Expecta.h"
#import "KIF.h"

SpecBegin(FISViewController)

describe(@"FISViewController", ^{
    
    beforeAll(^{

    });
    
    beforeEach(^{

    });
    
    it(@"", ^{
        UIView *backgroundView = [tester waitForViewWithAccessibilityLabel:@"Main View"];
        UIColor *before = [UIColor colorWithCGColor:backgroundView.backgroundColor.CGColor];
        NSLog(@"%@",before);
        CFRunLoopRunInMode(kCFRunLoopDefaultMode, 1,false);
        NSLog(@"%@",backgroundView.backgroundColor);
        expect(before).willNot.equal(backgroundView.backgroundColor);

    });  
    
    afterEach(^{

    });
    
    afterAll(^{

    });
});

SpecEnd
