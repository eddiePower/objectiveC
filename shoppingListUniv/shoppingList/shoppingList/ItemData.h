//
//  ItemData.h
//  shoppingList
//
//  Created by Eddie Power on 16/04/2014.
//  Copyright (c) 2014 Eddie Power. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ItemData : NSManagedObject

@property (nonatomic, retain) NSString * item_name;
@property (nonatomic, retain) NSString * item_description;
//As this data is used by core Data it must handle numbers as NSNumber objects not
// primative types like a double which it was in earlier projects.
@property (nonatomic, retain) NSNumber * item_price;

@end
