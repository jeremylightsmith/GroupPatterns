@class Card;

@interface CardDetailsController : UIViewController {
  IBOutlet UIWebView *webView;
  Card *card;
}

@property (nonatomic, retain) Card *card;

@end
