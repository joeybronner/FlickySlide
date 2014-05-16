//
//  City+CRUD.m
//  FlickySlide
//
//  Created by Joey Bronner on 16/05/2014.
//  Copyright (c) 2014 Joey Bronner. All rights reserved.
//

#import "City+CRUD.h"
#import "jbrAppDelegate.h"

@implementation City (CRUD)



+ (instancetype)newCity
{
    City * city = [NSEntityDescription insertNewObjectForEntityForName:@"City" inManagedObjectContext:[self context]];
    [[self appDelegate] saveContext];
    return city;
}

- (void)destroy
{
    [[City context] deleteObject:self]; // on supprime la ville
    [[City appDelegate] saveContext]; // on sauvegarde la base de données
}

+ (NSArray*) allCities
{
    NSFetchRequest * request = [[NSFetchRequest alloc] initWithEntityName:@"City"];
    return [[self context] executeFetchRequest:request error:nil];
}


+ (jbrAppDelegate*) appDelegate;
{
    return [[UIApplication sharedApplication] delegate];
}

+ (NSManagedObjectContext*) context
{
    return [[self appDelegate] managedObjectContext];
}


@end
