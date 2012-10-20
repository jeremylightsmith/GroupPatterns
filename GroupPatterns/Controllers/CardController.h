@class Card;

@interface CardController : UIViewController <UIWebViewDelegate> {
  IBOutlet UIWebView *webView;
  
  Card *card;
}

@property (nonatomic, strong) Card *card;

@end
