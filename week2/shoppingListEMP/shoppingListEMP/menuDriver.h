//////////////////////////////////////////////////////////////////////////
//  menuDriver.h                                                       //
//  ShoppingListEMP                                                   //
//                                                                   //
// Portfolio excorcise 1 for FIT3027 iOS/Android.                   //
//                                                                 //
//  Created by Eddie Power on 18/3/14.                            //
//  Copyright (c) 2014 Eddie Power.                              //
//  All rights reserved.                                        //
/////////////////////////////////////////////////////////////////

#import <Foundation/Foundation.h>
#import "shoppingList.h"
#import "KeyboardScanner.h"


@interface menuDriver : NSObject
@property shoppingList* allItemList;
@property shoppingList* shoppingList;

-(id)initWithItems1:(item*)i1 item2:(item*)i2 item3:(item*)i3 item4:(item*)i4 andItem5:(item*)i5;
-(void)runListMaker;

@end
