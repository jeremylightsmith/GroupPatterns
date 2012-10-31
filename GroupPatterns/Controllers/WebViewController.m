#import "WebViewController.h"
#import "CategoryController.h"


@interface WebViewController ()
@property(nonatomic, copy) NSString *pageToLoad;

@end

@implementation WebViewController {

@private
  NSString *_pageToLoad;
}
@synthesize pageToLoad = _pageToLoad;


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewDidLoad {
  self.navigationItem.title = @"Loading...";
  if (self.pageToLoad != nil) {
    [self loadPage:self.pageToLoad];
    self.pageToLoad = nil;
  }
}

- (void)loadHTMLString:(NSString *)html {
  NSString *path = [[NSBundle mainBundle] bundlePath];
  NSURL *baseURL = [NSURL fileURLWithPath:path];
  [webView loadHTMLString:html baseURL:baseURL];
}

- (void)loadPage:(NSString *)name {
  if (webView == nil) {
    self.pageToLoad = name;

  } else {
    if ([[name substringToIndex:4] isEqualToString:@"http"]) {
      [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:name]]];

    } else {
      NSString *path = [[NSBundle mainBundle] bundlePath];
      NSURL *baseURL = [NSURL fileURLWithPath:path];
      NSData *data = [[NSFileManager defaultManager] contentsAtPath:[NSString stringWithFormat:@"%@/%@", path, name]];
      [webView loadData:data MIMEType:@"text/html" textEncodingName:@"utf-8" baseURL:baseURL];
    }
  }
}

- (void)webViewDidFinishLoad:(UIWebView *)aWebView {
  if ([self.navigationItem.title isEqualToString:@"Loading..."]) {
    self.navigationItem.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
  }
}

@end