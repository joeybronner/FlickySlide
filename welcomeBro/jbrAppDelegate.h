//
//  jbrAppDelegate.h
//  welcomeBro
//
//  Created by Joey Bronner on 10/04/2014.
//  Copyright (c) 2014 Joey Bronner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface jbrAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
