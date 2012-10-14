#import "AsyncImageView.h"

@implementation AsyncImageView

- (void)dealloc {
	[connection cancel]; 
}

- (void)loadImageFromURL:(NSURL*)url {
	if (connection != nil) {  connection = nil; }
	if (data != nil) {  data = nil; }
	
	NSURLRequest* request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
	connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)incrementalData {
	if (data == nil) { data = [[NSMutableData alloc] initWithCapacity:2048]; } 
	[data appendData:incrementalData];
}

- (void)connectionDidFinishLoading:(NSURLConnection*)theConnection {
	connection=nil;
  
  self.image = [UIImage imageWithData:data];
  
	 //don't need this any more, its in the UIImageView now
	data=nil;
}

@end