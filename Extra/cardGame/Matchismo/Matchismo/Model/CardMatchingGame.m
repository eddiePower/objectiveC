//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Eddie Power on 24/04/2014.
//  Copyright (c) 2014 Eddie Power. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;

@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];  //Super class's designated initilizer
    
    if (self)
    {
        for (int i = 0; i < count; i++)
        {
            Card *card = [deck drawRandomCard];
            if(card)
            {
               [self.cards addObject: card];
            }
            else
            {
                self = nil;
                break;
            }
        }
    }
    return self;
}


- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index<[self.cards count]) ? self.cards[index] : nil;
}

/* CONSTANT - simple data-type variables 
 *  for static values that are needed. 
 */
static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex: index];
    
    if (!card.isMatched)
    {
        if(card.isChosen)
        {
            card.chosen = NO;
        }
        else
        {
            //Match against other chosen cards.
            for (Card *otherCard in self.cards)
            {
                if (otherCard.isChosen && !otherCard.isMatched)
                {
                    int matchScore = [card match:@[otherCard]];
                    
                    if (matchScore)
                    {
                        self.score += matchScore * MATCH_BONUS;
                        otherCard.matched = YES;
                        card.matched = YES;
                    }
                    else
                    {
                        self.score -= MISMATCH_PENALTY;
                        //unset the chosen bool for a mismatch.
                        otherCard.chosen = NO;
                    }
                    
                    /*
                     * Exit the for loop after handelling the
                     *  selected cards and check if they match, 
                     * user->cardArray/deck to main cardArray/deck.
                     */
                    break;
                } //end if matchScore exsists.
            } //end of for loop of card deck of otherCard[s]
            
            //Take off the cost of choosing a matching pair of cards.
            self.score -= COST_TO_CHOOSE;
            
            //Set the card chosen bool to true.
            card.chosen = YES;
            
        } //end Else from card match if
    } //end IF from card match if.
}

@end