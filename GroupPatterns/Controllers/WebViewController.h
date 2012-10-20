@interface WebViewController : UIViewController <UIWebViewDelegate> {
  IBOutlet UIWebView *webView;
}
- (void)loadHTMLString:(NSString *)html;

- (void)loadPage:(NSString *)name;

- (NSString *)cardLinksHtml:(NSArray *)someCards;


@end