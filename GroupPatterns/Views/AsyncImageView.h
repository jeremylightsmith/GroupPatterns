@interface AsyncImageView : UIImageView {
  NSURLConnection *connection;
  NSMutableData *data;
}

- (void)loadImageFromURL:(NSURL *)url;

@end
