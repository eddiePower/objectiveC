//
//  PartyListController.h
//  Project name: Week04
//
//  Used to control the PartyView by instantiation and
//   delegation from the add monster delegate.
//  Created by Eddie Power on 26/03/2014.
//  Copyright (c) 2014 Eddie Power.
//  All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Party.h"
#import "Monster.h"
#import "MonsterCell.h"
#import "AddMonsterController.h"

@interface PartyListController : UITableViewController <AddMonsterDelegate>

@property (strong, nonatomic) NSManagedObjectContext* managedObjectContext;
@property (strong, nonatomic) Party* currentParty;
@property (strong, nonatomic) NSArray* partyMonsterList;

@end
