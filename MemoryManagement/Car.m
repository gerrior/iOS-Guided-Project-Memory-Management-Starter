//
//  Car.m
//  iOS9-MemoryManagement
//
//  Created by Paul Solt on 11/13/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

#import "Car.h"
#import "LSILog.h"

@implementation Car

- (instancetype)initWithMake:(NSString *)make
{
    self = [super init];
    if (self) {
        NSLog(@"-[Car init]: %@", make);
        _make = [make copy]; // retain: 1
    }
    return self;
}

// Implement autoreleased class car method
+ (instancetype)carWithMake:(NSString *)make {
    return [[[Car alloc] initWithMake:make] autorelease];
}


- (void)dealloc
{
    NSLog(@"-[Car dealloc]: %@", self);
    // Print self before releasing anything
    [_make release];
    
    [super dealloc];
}

- (NSString *)description
{
    // TODO: Implement a standard autoreleasing method.
    NSString *description = [NSString stringWithFormat:@"Car: %@", self.make];
//    NSString *description = [[[NSString alloc] initWithFormat:@"Car: %@", self.make] autorelease];
    return description;
}

@end
