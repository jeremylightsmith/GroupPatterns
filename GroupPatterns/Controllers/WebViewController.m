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

- (NSString *)cardLinksHtml:(NSArray *)someCards {
  NSMutableArray *cardLinks = [NSMutableArray array];
  for (NSString *name in someCards) {
    [cardLinks addObject:[NSString stringWithFormat:@"<a href='/cards/%@'>%@</a>", name, name]];
  }
  return [cardLinks componentsJoinedByString:@", "];
}


@end