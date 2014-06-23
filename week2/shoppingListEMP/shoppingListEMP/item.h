//////////////////////////////////////////////////////////////////////////
//  item.h                                                             //
//  shoppingListEMP                                                   //
//                                                                   //
//  Portfolio excorcise 1 for FIT3027 iOS/Android.                  //
//                                                                 //
//  Created by Eddie Power on 11/03/2014.                         //
//  Copyright (c) 2014 Eddie Power.                              //
//  All rights reserved.                                        //
/////////////////////////////////////////////////////////////////

#import <Foundation/Foundation.h>

//interface is the way to interact with object item of type NSObject
@interface item : NSObject

//Item Class properties or class variables. comes with some built in set and get methods.
//readonly property will mean that only a geter will be available not a setter.

@property NSString* name;
@property NSString* itemDescription;

//nonatomic relates to the threds and if they can interact
//must be used for primative types like int, bool, float, double, char etc.
@property (nonatomic)double price;


//Item Class methods
-(id)initWithName:(NSString*)name itemDescription:(NSString*)aDescription itemPrice:(double)price;

@end
