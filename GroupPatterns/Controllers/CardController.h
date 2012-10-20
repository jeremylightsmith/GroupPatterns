#import "WebViewController.h"

@class Card;

@interface CardController : WebViewController {
  Card *card;
}

@property (nonatomic, strong) Card *card;

@end
