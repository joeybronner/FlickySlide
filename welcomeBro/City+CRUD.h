//
//  City+CRUD.h
//  FlickySlide
//
//  Created by Joey Bronner on 16/05/2014.
//  Copyright (c) 2014 Joey Bronner. All rights reserved.
//

#import "City.h"

@interface City (CRUD)

+ (instancetype) newCity;

+ (NSArray*) allCities;

- (void) destroy;

+ (void) saveChanges;

@end
