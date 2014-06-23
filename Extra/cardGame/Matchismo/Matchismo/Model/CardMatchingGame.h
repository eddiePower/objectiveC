//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Eddie Power on 24/04/2014.
//  Copyright (c) 2014 Eddie Power. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

   //designated initilizer for cardMatchingGame()
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;

@end