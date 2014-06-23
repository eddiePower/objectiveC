//////////////////////////////////////////////////////////////////////////
//  shoppingList.h                                                     //
//  shoppingListEMP                                                   //
//                                                                   //
//  Portfolio excorcise 1 for FIT3027 iOS/Android.                  //
//                                                                 //
//  Created by Eddie Power on 11/03/2014.                         //
//  Copyright (c) 2014 Eddie Power.                              //
//  All rights reserved.                                        //
/////////////////////////////////////////////////////////////////

#import <Foundation/Foundation.h>
#import "item.h"

@interface shoppingList : NSObject

//an item to work with ie put in array or take out. --maybe a int would do?
@property item* curItem;
//full list of all items to choose from, may drop this!
@property NSMutableArray* itemList;
//user selected list of items
@property NSMutableArray* myShoppingList;
@property (nonatomic) double total;


-(id)initWithItem: (item*)i1 secondItem:(item*)i2 thirdItem:(item*)i3 fourthItem:(item*)i4 andLastItem:(item*)i5;
-(void)addItem: (item*)chosenItem;
-(void)removeItem: (item*)removeItem;
-(double)calcTotalCost: (NSMutableArray*)currentItemList;


@end
