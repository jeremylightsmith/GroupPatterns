#import <MessageUI/MessageUI.h>
#import "WebViewController.h"

@class Card;
@class CardListController;

@interface CardController : WebViewController <MFMailComposeViewControllerDelegate> {
  Card *card;
}

@property (nonatomic, strong) Card *card;

@property(nonatomic, strong) CardListController *cardListController;

- (IBAction) shareThis;

@end
