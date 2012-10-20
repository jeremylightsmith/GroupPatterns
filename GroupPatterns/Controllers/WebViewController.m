#import "WebViewController.h"


@implementation WebViewController {

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)loadHTMLString:(NSString *)html {
  NSString *path = [[NSBundle mainBundle] bundlePath];
  NSURL *baseURL = [NSURL fileURLWithPath:path];
  [webView loadHTMLString:html baseURL:baseURL];
}

- (void)loadPage:(NSString *)name {
  NSString *path = [[NSBundle mainBundle] bundlePath];
  NSURL *baseURL = [NSURL fileURLWithPath:path];
  NSData *data = [[NSFileManager defaultManager] contentsAtPath:[NSString stringWithFormat:@"%@/%@", path, name]];
  [webView loadData:data MIMEType:@"text/html" textEncodingName:@"utf-8" baseURL:baseURL];
}

@end