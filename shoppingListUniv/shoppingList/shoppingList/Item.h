//
//  Item.h
//  shoppingList
//
//  Created by Eddie Power on 16/04/2014.
//  Copyright (c) 2014 Eddie Power. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Item : NSManagedObject

@property (nonatomic, retain) NSString * item_name;
@property (nonatomic, retain) NSString * item_description;

//The reason this is a NSNumber now is because the NSArray
// that CoreData uses can only store objects not primative types like double
// but it does have initialiser methods for these primative types which i used earlier.
@property (nonatomic, retain) NSNumber * item_price;
@property (nonatomic, retain) NSManagedObject *shoppingList;

@end
