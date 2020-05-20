//
//  Person.m
//  iOS9-MemoryManagement
//
//  Created by Paul Solt on 11/13/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

#import "Person.h"
#import "Car.h"
#import "LSILog.h"

@implementation Person

- (instancetype)initWithCar:(Car *)car
{
    self = [super init];
    if (self) {
        // Implement initWithCar with MRC
        _car = [car retain];
        NSLog(@"-[Person init]: %@", _car);
    }
    return self;
}

- (void)dealloc
{
    // TODO: Implement dealloc with MRC (order is important)
    [_car release];
    NSLog(@"-[Person dealloc]: %@", _car);
    [super dealloc];
}

// TODO: Implement setCar with MRC
- (void)setCar:(Car *)car
{
    if (car != _car) {
        [_car release]; // releasing old car
        _car = [car retain];
    }
}

@end
