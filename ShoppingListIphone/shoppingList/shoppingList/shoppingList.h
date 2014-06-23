//
//  ShoppingList.h
//  shoppingList
//
//  Created by Eddie Power on 16/04/2014.
//  Copyright (c) 2014 Eddie Power. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Item;

@interface ShoppingList : NSManagedObject

@property (nonatomic, retain) NSSet *shoppingList_items;

@end

@interface ShoppingList (CoreDataGeneratedAccessors)

-(void)addShoppingList_itemsObject:(Item *)value;
-(void)removeShoppingList_itemsObject:(Item *)value;
-(void)addShoppingList_items:(NSSet *)values;
-(void)removeShoppingList_items:(NSSet *)values;

//Calculate total cost of the NSArray or shopping list from mainView.
-(double)calcTotalCost: (NSArray*)currentItemList;

@end
