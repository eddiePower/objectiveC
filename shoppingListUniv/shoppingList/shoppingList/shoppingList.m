//
//  ShoppingList.m
//  shoppingList
//
//  This was my shoppingList class but with CoreData this was replaced with
//  (CoreData Generated Accessors) and now only holds a calcTotalCost method to get the list
//  total.
//
//  Created by Eddie Power on 16/04/2014.
//  Copyright (c) 2014 Eddie Power. All rights reserved.
//

#import "ShoppingList.h"
#import "Item.h"


@implementation ShoppingList

@dynamic shoppingList_items;

//calcTotalCost returns the double to show a dollar amount and takes in an Array
// populated from the listView on the main page.
-(double)calcTotalCost: (NSArray*)currentItemList
{
    //properties used in my calcTotalCost method.
    double total = 0;
    double itemCost = 0;
    
    //Loop through the passed Item list and add the item price onto a running total.
    for (int i=0; i < [currentItemList count]; i++)
    {
        //New Item from passed list parameter.
        Item* myItem = [currentItemList objectAtIndex:i];
        
        //Convert the item price from an NSNumber to a double value for arythmatic operations.
        itemCost = [myItem.item_price doubleValue];
        
        //Add the double value of item price to the list total so far.
        total += itemCost;
        NSLog(@"\ncalcTotalCost: Current List total is: $%.2f", total);
    }
    
    //Return list total.
    return total;
}

@end
