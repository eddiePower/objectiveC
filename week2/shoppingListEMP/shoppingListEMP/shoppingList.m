//////////////////////////////////////////////////////////////////////////
//  shoppingList.m                                                     //
//  shoppingListEMP                                                   //
//                                                                   //
//  Portfolio excorcise 1 for FIT3027 iOS/Android.                  //
//                                                                 //
//  Created by Eddie Power on 11/03/2014.                         //
//  Copyright (c) 2014 Eddie Power.                              //
//  All rights reserved.                                        //
/////////////////////////////////////////////////////////////////

#import "shoppingList.h"

@implementation shoppingList

-(id)init
{
    if (self = [super init])
    {
         self.itemList = [[NSMutableArray alloc] init];
    }
    return self;
}

-(id)initWithItem: (item*)i1 secondItem:(item*)i2 thirdItem:(item*)i3 fourthItem:(item*)i4 andLastItem:(item*)i5
{
    if (self = [super init])
    {
        self.itemList = [[NSMutableArray alloc] init];
        [self.itemList addObject:i4];
        [self.itemList addObject:i3];
        [self.itemList addObject:i5];
        [self.itemList addObject:i1];
        [self.itemList addObject:i2];
    }
    return self;
}

-(void)addItem: (item*)chosenItem
{
    [self.itemList addObject:chosenItem];
}

-(void)removeItem: (item*)removeItem
{
    [self.itemList removeObject: removeItem];
}

-(double)calcTotalCost: (NSMutableArray*)currentItemList
{
    self.total = 0;
    for (int i=0; i < [currentItemList count]; i++)
    {
        item* myItem = [currentItemList objectAtIndex:i];
        self.total += myItem.price;
    }
    return self.total;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"\nShopping List description: \n %@ ", self.itemList];
}

@end
