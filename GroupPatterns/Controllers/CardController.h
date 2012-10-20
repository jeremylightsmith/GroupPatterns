#import "WebViewController.h"

@class Card;
@class CardListController;

@interface CardController : WebViewController {
  Card *card;
}

@property (nonatomic, strong) Card *card;

@property(nonatomic, strong) CardListController *cardListController;
@end
