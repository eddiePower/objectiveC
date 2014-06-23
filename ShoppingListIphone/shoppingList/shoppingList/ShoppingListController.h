//
//  ShoppingListController.h
//  shoppingList
//
//  Created by Eddie Power on 2/04/2014.
//  Copyright (c) 2014 Eddie Power. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "shoppingList.h"
#import "Item.h"
#import "ItemCell.h"
#import "AddItemController.h"

@interface ShoppingListController : UITableViewController <AddItemDelegate>

@property (strong, nonatomic) NSManagedObjectContext* managedObjectContext;
@property (strong, nonatomic) ShoppingList* currentShoppingList;
@property (strong, nonatomic) NSArray* shoppingListItems;

@end
