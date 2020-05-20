//
//  ViewController.m
//  MemoryManagement
//
//  Created by Paul Solt on 1/29/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "ViewController.h"
#import "Car.h"
#import "Person.h"
#import "LSILog.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // TODO: Disable ARC in settings
    
    NSLog(@"Hi");

    NSString *name = [[NSString alloc] initWithString:@"Mark"]; // retain: 1 (alloc/init = +1)

    // Two methods for Manual Reference Counting (MRC)
    // Only exist when ARC disabled
    // retain
    // release

    [name retain]; // retain: 2 (retain = +1)
    [name retain]; // retain: 3 (retain = +1)

    [name release]; // retain: 2 (retain = -1)
    [name release]; // retain: 1 (retain = -1)

    [name release]; // retain: 0 -> automatically cleaned up
    name = nil;
    // No longer safe to use name as a variable with what it's pointing at

    // Dangling pointer if you don't set it to nil
    // May crash, unexpected behaviors - undefined behaviors 
    NSLog(@"Name: %@", name.description);

    // All collection types will take ownership of the memory you pass them (objects)
    NSMutableArray *colors = [[NSMutableArray alloc] init]; // colors: 1

    NSLog(@"colors: %@", colors);

    NSString *favoriteColor = [[NSString alloc] initWithString:@"Blue"]; // favoriteColor: 1
    [colors addObject:favoriteColor]; // favoriteColor: 2 (addObject +1)
    [favoriteColor release]; // favoriteColor: 1 -> transfer object ownership to the array

    NSString *color2 = [[[NSString alloc] initWithString:@"Red"] autorelease];
    [colors addObject:color2];


    // How do I clean it up?
    [colors release]; // colors: 0 -> automatic cleanup of memory (other variables can now use this space)
    // favoriteColor: 0
    colors = nil;

    Car *honda = [[[Car alloc] initWithMake:@"Civic"] autorelease]; // honda: 1
    Person *person = [[Person alloc] initWithCar:honda]; // person: 1

    // person.car will retain
    // alloc/init will retain
    Car *subaru = [[Car alloc] initWithMake:@"Forester"]; // 1
    person.car = subaru; // 2
    [subaru release]; // 1
    
    person.car = subaru; // 3

    [person release];
    person = nil; // protect future self
}


@end
