@interface WebViewController : UIViewController <UIWebViewDelegate> {
  IBOutlet UIWebView *webView;
}
- (void)loadHTMLString:(NSString *)html;

- (void)loadPage:(NSString *)name;


@end