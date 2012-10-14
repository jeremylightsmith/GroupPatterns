@class Card;

@interface CardDetailsController : UIViewController {
  IBOutlet UIWebView *webView;
  Card *card;
}

@property (nonatomic, strong) Card *card;

@end
