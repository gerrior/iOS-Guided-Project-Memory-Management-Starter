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

    // Disable ARC in settings
    
    NSLog(@"Hi");
    
    NSString *name = [[NSString alloc] initWithString:@"Mark"]; // retain: 1 (alloc/init = +1)
    
    // Two methods for Manual Reference Counting (MRC)
    // Only exist with ARC disabled
    // retain
    // release
    
    [name retain]; // retain: 2 (retain = +1)
    [name retain]; // retain: 3 (retain = +1)

    [name release]; // retain: 2 (retain = -1)
    [name release]; // retain: 1 (retain = -1)

    
    // When we're done using variables, we want them to cleanup
    
    [name release]; // retain: 0 -> automatically cleaned up
    name = nil; // position zero in memory
    // No longer safe to use name as a variable with what it's pointing at
    
    // Dangling pointer if we release to 0, and try to use (always set to nil when finished)
    // Bug to use it here: May crash, unexpected behaviors - undefined behaviors
    NSLog(@"Name: %@", name.description);
    
    
    // All Collection types will take ownership of the memory you pass them (objects)

    NSMutableArray *colors = [[NSMutableArray alloc] init]; // colors: 1

    NSLog(@"colors: %@", colors);

    NSString *favoriteColor = [[NSString alloc] initWithString:@"Blue"]; // favoriteColor: 1
    [colors addObject:favoriteColor]; // favoriteColor: 2 (addObject +1)
    [favoriteColor release]; // favoriteColor: 1 -> transfering object ownership to the array
    
    NSString *color2 = [[[NSString alloc] initWithString:@"Red"] autorelease];
    [colors addObject:color2];
    
    
    // How do I clean it up?
    [colors release]; // colors: 0 -> automatic cleanup of memory (other variables can now use this space)
    // favoriteColor: 0
    colors = nil; // Prevent bugs with using invalid memory (Protecting my future self from making a mistake)

    // using colors after setting it to nil is a no-op and will be predictable ... without it ... anything can
    // happen
    
    
    Car *honda = [[Car alloc] initWithMake:@"Civic"]; // honda: 1
    
    Person *person = [[Person alloc] initWithCar:honda]; // person: 1, honda: 2
    [honda release]; // honda: 1
    
    person.car = honda;
    
    
    // person.car will retain
    // alloc/init will retain
    Car *subaru = [[Car alloc] initWithMake:@"Forester"]; // 1
    person.car = subaru; // 2
    [subaru release]; // 1
    
    person.car = subaru; // 3
    
    // cleanup person now, or I need to hold onto it
    //self.person = person; // -> need to release in the dealloc
    
    [person release]; // person: 0
    person = nil; // prevents future issues (protects my future self)
}


@end
