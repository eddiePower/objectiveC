//
//  AppDelegate.m
//  shoppingList
//
//  Created by Eddie Power on 2/04/2014.
//  Copyright (c) 2014 Eddie Power. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    //Set the database/CoreData Store name, root location and put them together into storeUrl
    self.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *dbPath = [rootPath stringByAppendingPathComponent:@"Items.sqlite"];
    NSURL *storeUrl = [NSURL fileURLWithPath:dbPath];
    
    //Error checking makeing sure the creation of the store or database above was sucsessfull, COREDATA stuff.
    NSError* error;
    if (![self.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error])
    {
        NSLog(@"Could not open/create Persistant Store:\n%@", error.userInfo);
    }
    
    self.managedObjectContext = [[NSManagedObjectContext alloc] init];
    self.managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        //Set up iPad links to storyboard and controllers.
        UISplitViewController* splitController = (UISplitViewController*)self.window.rootViewController;
        UINavigationController* navController = [splitController.viewControllers firstObject];
        AddItemController* addItemController = [navController.viewControllers firstObject];
        addItemController.managedObjectContext = self.managedObjectContext;
        ShoppingListController* shoppingList = [splitController.viewControllers lastObject];
        shoppingList.managedObjectContext = self.managedObjectContext;
        addItemController.delegate = shoppingList;
    }
    else
    {
        //Else build iPhone links to storyboard and controllers.
        UINavigationController* navController = (UINavigationController*)self.window.rootViewController;
        ShoppingListController* shoppingListController = [navController.viewControllers firstObject];
        shoppingListController.managedObjectContext = self.managedObjectContext;
    }
   
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
