//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Eddie Power on 23/04/2014.
//  Copyright (c) 2014 Eddie Power. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"
#import "Deck.h"
#import "PlayingCardDeck.h"

@interface CardGameViewController ()

@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *CardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *userMessage;



@end

@implementation CardGameViewController

- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.CardButtons count]
                                                          usingDeck: [self createDeck]];
    
    return _game;
}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    int chooseButtonIndex = [self.CardButtons indexOfObject: sender];
    
    [self.game chooseCardAtIndex: chooseButtonIndex];
    [self updateUI];
}

- (void) updateUI
{
    for (UIButton *cardButton in self.CardButtons)
    {
        //Method variables for working through all cards / buttons.
        int cardButtonIndex = [self.CardButtons indexOfObject: cardButton];
        Card *card = [self.game cardAtIndex: cardButtonIndex];
        
        //Set the title from the other cards???
        [cardButton setTitle: [self titleForCard: card]
                    forState: UIControlStateNormal];
        [cardButton setBackgroundImage: [self backgroundImageForCard: card]
                              forState: UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d points.", self.game.score];
    }
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed: card.isChosen ? @"cardfront" : @"cardback"];
}

@end