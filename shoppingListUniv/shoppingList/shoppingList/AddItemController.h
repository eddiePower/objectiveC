//
//  AddItemController.h
//  shoppingList
//
//  Used to connect the AddItem view with the addItem logic. which in this
//   case was the JSON download, last update check and save, 
//
//  Created by Eddie Power on 2/04/2014.
//  Copyright (c) 2014 Eddie Power. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "ItemData.h"
#import "item.h"
#import "ItemCell.h"

@protocol AddItemDelegate <NSObject>

-(void)addItem:(Item*)item;

@end

@interface AddItemController : UITableViewController

@property (strong, nonatomic) NSManagedObjectContext* managedObjectContext;
@property (strong, nonatomic) NSArray* allItems;  
@property (weak, nonatomic) id<AddItemDelegate> delegate;

@end
