//
//  Party.h
//  Week04
//
//  Created by Eddie Power on 2/04/2014.
//  Copyright (c) 2014 Eddie Power. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Monster;

@interface Party : NSManagedObject

@property (nonatomic, retain) NSSet *members;
@end

@interface Party (CoreDataGeneratedAccessors)

- (void)addMembersObject:(Monster *)value;
- (void)removeMembersObject:(Monster *)value;
- (void)addMembers:(NSSet *)values;
- (void)removeMembers:(NSSet *)values;

@end
