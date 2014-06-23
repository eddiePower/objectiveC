//
//  AddMonsterController.h
//  Project Name: Week04
//
//  Created by Eddie Power on 26/03/2014.
//  Copyright (c) 2014 Eddie Power.
//  All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "MonsterData.h"
#import "Monster.h"
#import "MonsterCell.h"

@protocol AddMonsterDelegate <NSObject>

-(void)addMonster:(Monster*)monster;

@end

@interface AddMonsterController : UITableViewController

@property (strong, nonatomic) NSManagedObjectContext* managedObjectContext;
@property (strong, nonatomic) NSArray* allMonsters;
@property (weak, nonatomic) id<AddMonsterDelegate> delegate;

@end
